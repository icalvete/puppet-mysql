class mysql::params {

  $backup_dir   = hiera('backup_dir', '/srv/backup')
  $root_user    = hiera('mysql_root_user', 'root')
  $root_pass    = hiera('mysql_root_pass', 'mysql')

  $mysql_server = 'mysql-server'
  $mysql_client = 'mysql-client'

  $log_bin      = '/var/log/mysql/mysql-bin.log'
  $relay_log    = '/var/log/mysql/mysql-relay-bin'

  case $::operatingsystem {
    /^(Debian|Ubuntu)$/: {

      $mysql_dev       = 'libmysqlclient-dev'
      $mysql_service   = 'mysql'

      case $::operatingsystemrelease {

        /^(12.04|12.10|13.04)$/: {
          $mysql_conf = '/etc/mysql/my.cnf'
        }
        default: {
          $mysql_conf = '/etc/mysql/mysql.conf.d/mysqld.cnf'
        }
      }


    }
    /^(CentOS|RedHat)$/: {

      $mysql_conf    = '/etc/my.cnf'
      $mysql_dev     = 'mysql-devel'
      $mysql_service = 'mysqld'

    }
    default: {

      fail ("${::operatingsystem} not supported.")
    }
  }
}
