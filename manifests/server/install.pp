class mysql::server::install {

  package {$mysql::params::mysql_server:
    ensure => present
  }
}
