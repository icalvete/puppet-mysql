class mysql::server::config {

  augeas{'set_mysql_conf' :
    context => "/files/${mysql::params::mysql_conf}",
    changes => "set target[. = 'mysqld']/bind-address 0.0.0.0",
  }
}
