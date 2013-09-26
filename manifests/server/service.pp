class mysql::server::service {

  service{$mysql::params::mysql_service:
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true
  }
}
