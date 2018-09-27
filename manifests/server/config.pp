class mysql::server::config {

  augeas{'set_mysql_conf' :
    context => "/files/${mysql::server::mysql_conf}",
    changes => "set target[. = 'mysqld']/bind-address 0.0.0.0",
  }

  exec{ 'set_mysql_conf_exec':
      command => "/bin/sed -i -e \"s/127.0.0.1/0.0.0.0/\" ${mysql::server::mysql_conf}",
      unless  => "/bin/grep '0.0.0.0' ${mysql::server::mysql_conf}"
  }

  if $mysql::server::id {

    if ! is_integer($mysql::server::id) {
      fail('param $id must be an integer.')
    }

    augeas{'set_mysql_id' :
      context => "/files/${mysql::server::mysql_conf}",
      changes => "set target[. = 'mysqld']/server-id ${mysql::server::id}",
    }

    augeas{'set_mysql_log_bin' :
      context => "/files/${mysql::server::mysql_conf}",
      changes => "set target[. = 'mysqld']/log-bin ${mysql::server::log_bin}",
    }

    augeas{'set_mysql_relay_log' :
      context => "/files/${mysql::server::mysql_conf}",
      changes => "set target[. = 'mysqld']/relay-log ${mysql::server::relay_log}",
    }

    augeas{'set_mysql_binlog_format' :
      context => "/files/${mysql::server::mysql_conf}",
      changes => "set target[. = 'mysqld']/binlog_format row",
    }

    augeas{'set_mysql_autoincrement' :
      context => "/files/${mysql::server::mysql_conf}",
      changes => "set target[. = 'mysqld']/auto_increment_increment 2",
    }

    augeas{'set_mysql_autoincrement_offset' :
      context => "/files/${mysql::server::mysql_conf}",
      changes => "set target[. = 'mysqld']/auto_increment_offset ${mysql::server::id}",
    }
  }
}
