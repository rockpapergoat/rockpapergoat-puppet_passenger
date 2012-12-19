# Class: httpdpassenger
#
#
class httpdpassenger {

include puppetpassenger::params

    notify {"1":
    message => "$apache_conf_dir/puppetmasterd.conf",
    }

	file { ["/etc/puppet/rack", "/etc/puppet/rack/public"]:
	  ensure => directory,
	  mode => 0755,
	  owner => root,
	  group => root,
	}
	file { "/etc/puppet/rack/config.ru":
	  ensure => present,
	  content => template("puppetpassenger/config.ru.erb"),
	  mode => 0644,
	  owner => puppet,
	  group => root,
	}
	file { "$apache_conf_dir/puppetmasterd.conf":
	  ensure => present,
	  content => template("puppetpassenger/httpd.conf.erb"),
	  mode => 0644,
	  owner => root,
	  group => root,
	  require => [File["/etc/puppet/rack/config.ru"], File["/etc/puppet/rack/public"], Package[$apache_name], Package["passenger"]],
	  notify => Service[$apache_name],
	}

	file { "$apache_conf_dir/passenger.conf":
	  ensure => present,
	  content => template("puppetpassenger/passenger.conf.erb"),
	  mode => 0644,
	  owner => root,
	  group => root,
	  require => [File["/etc/puppet/rack/config.ru"], File["/etc/puppet/rack/public"], Package[$apache_name], Package["passenger"]],
	  notify => Service[$apache_name],
	}

	package { puppetpassenger::params::$core_gems:
	  ensure => installed,
	  provider => "gem",
	}

	    Service[$apache_name] {
	      require => Package[$apache_name],
	    }

	service { $apache_name:
		ensure => running,
		enable => true,
	}

	    package { puppetpassenger::params::$core_packages:
	      ensure => installed,
	    }

    
	    file { "$apache_conf_dir/ssl.conf":
	      ensure => "present",
	      notify => Service[$apache_name],
	      require => Package["mod_ssl"],
	    }
	    exec { "/usr/bin/passenger-install-apache2-module --auto":
	      subscribe => Package["passenger"],
	      before => Service[$apache_name],
          creates => "/usr/lib/ruby/gems/1.8/gems/$passenger_version/ext/apache2/mod_passenger.so",
	    }
}