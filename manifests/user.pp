define mysql::user (

  $pass      = 'pass',
  $root_pass = $mysql::params::mysql_root_pass,
  $server    = 'localhost',
  $host      = 'localhost'

){

  exec {"add_mysql_user_${name}":
    path    => '/usr/bin:/bin:/sbin',
    command => "mysql -uroot -p$root_pass -h \"$server\" -e \"create user '$name'@'$host' identified by '$pass'\"",
    require => Class[mysql::server::service],
    unless  => "mysql -uroot -p$root_pass -h$server -e \"use mysql;select user,host from user;\"|grep $host|grep $name"
  }
}
