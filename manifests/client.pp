class mysql::client (

  $version = $mysql::params::version,
) inherits mysql::params  {

  include mysql::client::install
}
