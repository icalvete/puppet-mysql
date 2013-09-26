class mysql::server::backup (

  $root_pass  = $mysql::params::mysql_root_pass,
  $backup_dir = $mysql::params::backup_dir,
  $s3_backup  = false

) {

  package {'mysql2':
    ensure   => present,
    provider => gem
  }

  file{'mysql_backup_dir':
    ensure => directory,
    path   => "${backup_dir}/mysql"
  }

  file {'mysql_backup_file':
    ensure  => present,
    path    => "${backup_dir}/script_mysql_backup.rb",
    content => template("${module_name}/script_mysql_backup.erb"),
    mode    => '0744',
    require => File['mysql_backup_dir']
  }

  file {'mysql_backup_lib':
    ensure  => present,
    path    => "${backup_dir}/mysqlbackup.rb",
    source  => "puppet:///modules/${module_name}/mysqlbackup.rb",
    mode    => '0744',
    require => File['mysql_backup_dir']
  }

  cron { "add_backup_mysql_${::hostname}":
    command => "cd ${backup_dir} && ${backup_dir}/script_mysql_backup.rb ${::hostname} 3",
    user    => 'root',
    hour    => '3',
    minute  => '15',
    require => File['mysql_backup_file']
  }

  if $s3_backup {
    s3sync::add_backup{"mysql_backup_${::hostname}":
      target   => "${backup_dir}/mysql",
      s3bucket => $::s3bucket,
      require  => Cron["add_backup_mysql_${::hostname}"]
    }
  }
}
