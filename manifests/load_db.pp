define mysql::load_db (

  $db     = undef,
  $ddl    = undef,
  $unless = undef

) {

  $ddl_source = $ddl['source']
  $ddl_file   = $ddl['file']

  if $db {
    fail('mysql::load_db needs db parameter.')
  }

  if $ddl {
    fail('mysql::load_db needs ddl parameter.')
  }

  if $ddl_file =~ /\.erb$/ {

    file {"load_db_${name}":
      path    => "/tmp/${ddl_file}",
      content => template("${ddl_source}/${ddl_file}"),
    }
  }else{

    file {"load_db_${name}":
      path   => "/tmp/${ddl_file}",
      source => "puppet:///modules/${ddl_source}/${ddl_file}",
    }
  }

  exec {"load_db_${name}":
    cwd     => '/tmp/',
    command => "/usr/bin/mysql ${db} < /tmp/${ddl_file}",
    require => File["load_db_${name}"],
    unless  => $unless
  }
}
