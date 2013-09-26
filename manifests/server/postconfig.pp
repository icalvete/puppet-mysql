class mysql::server::postconfig (

  $root_pass = $mysql::params::mysql_root_pass

) {

  exec {'setup_mysql_root_pass':
    command => "/usr/bin/mysqladmin -uroot -h localhost password ${root_pass}",
    onlyif  => '/usr/bin/mysql -uroot -h localhost',
  }
}
