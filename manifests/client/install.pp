class mysql::client::install {

  package {$mysql::params::mysql_client:
    ensure => present
  }
}
