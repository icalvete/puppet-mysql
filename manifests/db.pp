define mysql::db (

  $db         = $name,
  $user       = 'root',
  $host       = 'localhost',
  $server     = 'localhost',
  $root_user  = $mysql::server::root_user,
  $root_pass  = $mysql::server::root_pass,
  $privileges = 'all privileges',

){
  include mysql

  exec {
    "create_db_$name":
      path        => '/usr/bin:/bin:/sbin',
      command     => "mysqladmin -u${root_user} -p$root_pass -h \"$server\" create \"$db\"",
      unless      => "mysql -u${root_user} -p$root_pass -h \"$server\" -e 'use $db'";

    "set_privileges_$db":
      path        => '/usr/bin:/bin:/sbin',
      command     => "mysql -u${root_user} -p$root_pass -h $server -e \"grant $privileges on $db.* to '$user'@'$host'\"",
  }
}
