### centos
class apache::centos inherits apache::package {
    $config_dir = '/etc/httpd'

    Package[apache]{
        name => 'httpd',
    }
    Service[apache]{
        name => 'httpd',
        restart => '/etc/init.d/httpd graceful',
    }
    File[vhosts_dir]{
        path => "$config_dir/vhosts.d",
    }
    File[config_dir]{
        path => "$config_dir/conf.d",
    }
    File[include_dir]{
        path => "$config_dir/include.d",
    }
    File[modules_dir]{
        path => "$config_dir/modules.d",
    }
    File[web_dir]{
        path => "/var/www/vhosts",
    }
    File[default_apache_index]{
        path => '/var/www/html/index.html',
    }

    file{'apache_service_config':
        path => '/etc/sysconfig/httpd',
        source => [ "puppet:///modules/site-apache/service/CentOS/${fqdn}/httpd",
                    "puppet:///modules/site-apache/service/CentOS/httpd",
                    "puppet:///modules/apache/service/CentOS/httpd" ],
        require => Package['apache'],
        notify => Service['apache'],
        owner => root, group => 0, mode => 0644;
    }

    line{
      'pidfile_httpd.conf':
        file => '/etc/httpd/conf/httpd.conf',
        line => 'PidFile run/httpd.pid';
      'listen_httpd.conf':
        file => '/etc/httpd/conf/httpd.conf',
        line => 'Listen 80';
    }
    apache::config::global{'00-listen.conf':
      ensure => absent,
    }

    include apache::logrotate::centos

    apache::config::global{ 'welcome.conf': }
    apache::config::global{ 'vhosts.conf': }
}

