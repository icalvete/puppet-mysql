class mysql::server (

  $root_user  = $mysql::params::root_user,
  $root_pass  = $mysql::params::root_pass,
  $backup_dir = $mysql::params::backup_dir,
  $s3_backup  = false,
  $id         = undef,
  $log_bin    = $mysql::params::log_bin,
  $relay_log  = $mysql::params::relay_log

) inherits mysql::params {

  anchor{'mysql::server:begin':
    before => Class['server::install']
  }

  class {'server::install':
    require => Anchor['mysql::server:begin']
  }

  class {'server::config':
    require => Class['server::install']
  }

  class {'server::service':
    subscribe => Class['server::config']
  }

  class {'server::postconfig':
    root_pass => $root_pass,
    require   => Class['server::service']
  }

  class {'mysql::dev':
    require => Anchor['mysql::server:begin']
  }

  class {'server::backup':
    root_user  => $root_user,
    root_pass  => $root_pass,
    backup_dir => $backup_dir,
    s3_backup  => $s3_backup,
    require    => Class['server::postconfig', 'mysql::dev']
  }

  anchor{'mysql::server:end':
    require => Class['server::backup']
  }
}
