class mysql::server::install {

  realize Package['augeas-lenses']

  case $mysql::server::version {
    "7": {
      $mysql_server = "${mysql::params::mysql_server}-5.7"
    }
    default: {
      $mysql_server = $mysql::params::mysql_server
    }
  }

  package {$mysql::params::mysql_server:
    ensure => present
  }

  file {'augeas_mysql_len':
    ensure  => present,
    path    => '/usr/share/augeas/lenses/dist/mysql.aug',
    content => template("${module_name}/mysql.aug.erb"),
    mode    => '0664',
    require => Package['augeas-lenses']
  }
}
