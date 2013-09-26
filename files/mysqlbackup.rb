# == Class: MysqlBackup
#
# Class to MySQL backup
#
# === Requirement/Dependencies:
#
#  require gem mysql2
#
# === Autors:
#
# Israel Calvete <icalvete@gmail.com>
#
class MysqlBackup
  def initialize(user, pass, dir, date, database)
    @user          = user
    @pass          = pass
    @dir           = dir
    @date          = date
    @database      = database
    @host_path     = @dir + "/#{@date}"
    @database_path = @host_path + "/#{@database}"
    createDir
    schemaBackup
    fullBackup
    functionBackup
  end
  def createDir
    if ! FileTest::directory?(@dir)
      Dir::mkdir(@dir)
    end
    if ! FileTest::directory?(@host_path)
      Dir::mkdir(@host_path)
    end
    if ! FileTest::directory?(@database_path)
      Dir::mkdir(@database_path)
    end
    if $debug
      puts "do createDir 4 #{@database} in #{@database_path}/."
    end
  end
  def schemaBackup
    if $debug
      puts "do schemaBackup 4 #{@database}."
    end
    system 'mysqldump --single-transaction -u'+@user+' -p'+@pass+' -d -t -B '+@database+"> #{@database_path}/CREATEDATABASE.sql"
  end
  def functionBackup
    if $debug
      puts "do functionBackup 4 #{@database}."
    end
    system 'mysqldump --single-transaction -u'+@user+' -p'+@pass+' '+@database+" -Rdnt --triggers=FALSE| gzip -9  > #{@database_path}/FUNCIONES.gz"
  end
  def fullBackup
    if $debug
      puts "do fullBackup 4 #{@database}."
    end
    system 'mysqldump --single-transaction -u'+@user+' -p'+@pass+' '+@database+" | gzip -9  > #{@database_path}/#{@database}.gz"
  end
  def tableBackup(table)
    if $debug
      puts "do tableBackup(#{table}) of #{@database}."
    end
    system 'mysqldump --single-transaction --skip-lock-tables --add-locks=FALSE -u'+@user+' -p'+@pass+' '+@database+' '+table+"| gzip -9  > #{@database_path}/#{table}.gz"
  end
  private :createDir
  private :schemaBackup
  private :fullBackup
  private :functionBackup
end
