define mysql::db (

  $db         = $name,
  $user       = 'root',
  $host       = 'localhost',
  $server     = 'localhost',
  $root_pass  = $mysql::params::mysql_root_pass,
  $privileges = 'all privileges',

){
  exec {
    "create_db_$name":
      path        => '/usr/bin:/bin:/sbin',
      command     => "mysqladmin -uroot -p$root_pass -h \"$server\" create \"$db\"",
      unless      => "mysql -uroot -p$root_pass -h \"$server\" -e 'use $db'";

    "set_privileges_$db":
      path        => '/usr/bin:/bin:/sbin',
      command     => "mysql -uroot -p$root_pass -h $server -e \"grant $privileges on $db.* to '$user'@'$host'\"",
  }
}
