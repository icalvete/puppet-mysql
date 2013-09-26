class mysql::params {

  case $::operatingsystem {
    /^(Debian|Ubuntu)$/: {
      $backup_dir      = hiera('backup_dir')
      $mysql_root_pass = hiera('mysql_root_pass')

      $mysql_conf      = '/etc/mysql/my.cnf'
      $mysql_server    = 'mysql-server'
      $mysql_client    = 'mysql-client'
      $mysql_dev       = 'libmysqlclient-dev'
      $mysql_service   = 'mysql'

    }
    default: {
      fail ("${::operatingsystem} not supported.")
    }
  }
}
