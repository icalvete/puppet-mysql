class mysql::server (

  $root_user  = $mysql::params::root_user,
  $root_pass  = $mysql::params::root_pass,
  $backup_dir = $mysql::params::backup_dir,
  $s3_backup  = false,
  $id         = undef,
  $log_bin    = $mysql::params::log_bin,
  $relay_log  = $mysql::params::relay_log,
  $mysql_conf = $mysql::params::mysql_conf

) inherits mysql::params {

  anchor{'mysql::server:begin':
    before => Class['mysql::server::install']
  }

  class {'mysql::server::install':
    require => Anchor['mysql::server:begin']
  }

  class {'mysql::server::config':
    require => Class['mysql::server::install']
  }

  class {'mysql::server::service':
    subscribe => Class['mysql::server::config']
  }

  class {'mysql::server::postconfig':
    root_pass => $root_pass,
    require   => Class['mysql::server::service']
  }

  class {'mysql::dev':
    require => Anchor['mysql::server:begin']
  }

  class {'mysql::server::backup':
    root_user  => $root_user,
    root_pass  => $root_pass,
    backup_dir => $backup_dir,
    s3_backup  => $s3_backup,
    require    => Class['mysql::server::postconfig', 'mysql::dev']
  }

  anchor{'mysql::server:end':
    require => Class['mysql::server::backup']
  }
}
