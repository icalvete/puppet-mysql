# puppet-mysql

Puppet manifest to install, configure and simple admin a standalone mysql server

[![Build Status](https://secure.travis-ci.org/icalvete/puppet-mysql.png)](http://travis-ci.org/icalvete/puppet-mysql)

# Actions:

* Install server
* Intall client
* Create user
* Create db
* Load file with schema and data
* Local backup

## Requires:

* Works in Debian|Ubuntu|RedHat|CentOS
* [hiera](http://docs.puppetlabs.com/hiera/1/index.html)
* [augeas](http://projects.puppetlabs.com/projects/1/wiki/puppet_augeas)
* https://github.com/icalvete/puppet-common

## Examples:

```puppet
    node 'os01.smartpurposes.net' inherits sp_defaults {

      include roles::puppet_agent
      include roles::syslog_sender_server
      include roles::rabbitmq_serve
      include roles::mysql_server
      
      $puppet_dashboard_db      = hiera('puppet_dashboard_db')
      $puppet_dashboard_db_user = hiera('puppet_dashboard_db_user')
      $puppet_dashboard_db_pass = hiera('puppet_dashboard_db_pass')
      
      mysql::user {$puppet_dashboard_db_user:
        pass => $puppet_dashboard_db_pass,
        host => '%'
      }
      
      mysql::db {$puppet_dashboard_db:
        user    => $puppet_dashboard_db_user,
        host    => '%',
        require => Mysql::User[$puppet_dashboard_db_user]
      }
    }
```

## TODO:

* Tunning mysql configuration.
* Replication?
  
  (Maybe should use MMM http://mysql-mmm.org/).
  https://github.com/icalvete/puppet-mysql_mmm

## Authors:

Israel Calvete Talavera <icalvete@gmail.com>
