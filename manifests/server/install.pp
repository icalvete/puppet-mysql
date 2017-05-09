class mysql::server::install {

  package {$mysql::params::mysql_server:
    ensure => present
  }

  file {'augeas_mysql_len':
    ensure  => present,
    path    => '/usr/share/augeas/lenses/dist/mysql.aug',
    content => template("${module_name}/mysql.aug.erb"),
    mode    => '0664',
  }
}
