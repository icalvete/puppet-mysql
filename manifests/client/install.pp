class mysql::client::install {
  
  case $mysql::server::version {
    "7": {
      $mysql_client = "${mysql::params::mysql_client}-5.7"
    }
    default: {
      $mysql_client = $mysql::params::mysql_client
    }
  }

  package {$mysql::params::mysql_client:
    ensure => present
  }
}
