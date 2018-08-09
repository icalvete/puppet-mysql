class mysql::client inherits mysql::params (
  
  $version = $mysql::params::version,
){

  include client::install
}
