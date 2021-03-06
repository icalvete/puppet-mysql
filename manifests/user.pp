define mysql::user (

  $user      = $name,
  $pass      = 'pass',
  $root_user = $mysql::server::root_user,
  $root_pass = $mysql::server::root_pass,
  $server    = 'localhost',
  $host      = 'localhost'

){

  include mysql

  exec {"add_mysql_user_${name}":
    path    => '/usr/bin:/bin:/sbin',
    command => "mysql -u${root_user} -p$root_pass -h \"$server\" -e \"create user '$user'@'$host' identified by '$pass'\"",
    unless  => "mysql -u${root_user} -p$root_pass -h$server -e \"use mysql;select user,host from user;\"|grep $host|grep $user"
  }
}
