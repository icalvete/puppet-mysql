define mysql::db (

  $db             = $name,
  $user           = 'root',
  $host           = 'localhost',
  $server         = 'localhost',
  $root_user      = $mysql::server::root_user,
  $root_pass      = $mysql::server::root_pass,
  $privileges     = 'all privileges',
  $charset_name   = 'utf8',
  $collation_name = 'collation_name'

){
  include mysql

  exec {
    "create_db_$name":
      path        => '/usr/bin:/bin:/sbin',
      command     => "mysql -u${root_user} -p$root_pass -h \"$server\" -e \"CREATE DATABASE $db CHARACTER SET $charset_name COLLATE $collation_name\"",
      unless      => "mysql -u${root_user} -p$root_pass -h \"$server\" -e 'use $db'";
  }
  if $user != 'root' {
    exec {
      "set_privileges_$db":
        path        => '/usr/bin:/bin:/sbin',
        command     => "mysql -u${root_user} -p$root_pass -h $server -e \"grant $privileges on $db.* to '$user'@'$host'\"",
    }
  }
}
