class mysql::params {

  $backup_dir      = hiera('backup_dir')
  $mysql_root_user = hiera('mysql_root_user')
  $mysql_root_pass = hiera('mysql_root_pass')

  $mysql_server    = 'mysql-server'
  $mysql_client    = 'mysql-client'

  case $::operatingsystem {
    /^(Debian|Ubuntu)$/: {

      $mysql_conf      = '/etc/mysql/my.cnf'
      $mysql_dev       = 'libmysqlclient-dev'
      $mysql_service   = 'mysql'

    }
    /^(CentOS|RedHat)$/: {

      $mysql_conf    = '/etc/my.cnf'
      $mysql_dev     = 'mysql-devel'
      $mysql_service = 'mysqld'

    }
    default: {

      fail ("${::operatingsystem} not supported.")
    }
  }
}
