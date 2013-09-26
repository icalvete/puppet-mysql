class mysql::dev {

  package {$mysql::params::mysql_dev:
    ensure => present
  }
}
