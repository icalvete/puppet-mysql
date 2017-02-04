class mysql::server::postconfig (

  $root_user  = $mysql::server::root_user,
  $root_pass  = $mysql::server::root_pass,
  $backup_dir = $mysql::server::backup_dir,

) {

  case $::operatingsystem {
    /^(Debian|Ubuntu)$/: {

      case $::operatingsystemrelease {

        /^(12.04|12.10|13.04)$/: {
          exec {'setup_mysql_root_pass':
            command => "/usr/bin/mysqladmin -uroot -h localhost password ${root_pass}",
            onlyif  => '/usr/bin/mysql -uroot -h localhost',
          }
        }
        default: {
          exec {'setup_mysql_root_pass':
            command  => "echo \"ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '${root_pass}'; flush privileges;\" | /usr/bin/mysql -uroot -h localhost",
            provider => 'shell',
            onlyif   => '/usr/bin/mysql -uroot -h localhost',
          }
        }
      }
    }
    /^(CentOS|RedHat)$/: {
    }
    default: {
      fail ("${::operatingsystem} not supported.")
    }
  }
}
