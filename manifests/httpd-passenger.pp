# Class: httpd-passenger
#
#
class httpd-passenger {


	file { ["/etc/puppet/rack", "/etc/puppet/rack/public"]:
	  ensure => directory,
	  mode => 0755,
	  owner => root,
	  group => root,
	}
	file { "/etc/puppet/rack/config.ru":
	  ensure => present,
	  content => template("puppet-passenger/config.ru.erb"),
	  mode => 0644,
	  owner => puppet,
	  group => root,
	}
	file { "/etc/httpd/conf.d/puppetmasterd.conf":
	  ensure => present,
	  content => template("puppet-passenger/httpd.conf.erb"),
	  mode => 0644,
	  owner => root,
	  group => root,
	  require => [File["/etc/puppet/rack/config.ru"], File["/etc/puppet/rack/public"], Package["httpd"], Package["passenger"]],
	  notify => Service["httpd"],
	}

	file { "/etc/httpd/conf.d/passenger.conf":
	  ensure => present,
	  content => template("puppet-passenger/passenger.conf.erb"),
	  mode => 0644,
	  owner => root,
	  group => root,
	  require => [File["/etc/puppet/rack/config.ru"], File["/etc/puppet/rack/public"], Package["httpd"], Package["passenger"]],
	  notify => Service["httpd"],
	}

	package { ["rack", "passenger"]:
	  ensure => installed,
	  provider => "gem",
	}

	    Service["httpd"] {
	      require => Package["httpd"],
	    }

	service { "httpd":
		ensure => running,
		enable => true,
	}

	    package { ["httpd-itk",  "httpd", "mod_ssl", "httpd-devel", 
	    "apr-util", "apr-util-devel", "openssl-devel", "libcurl-devel", 
	    "zlib-devel", "gcc-c++", "ruby-devel", "rubygem-rake", "rubygem-passenger"]:
	      ensure => installed,
	    }

    
	    file { "/etc/httpd/conf.d/ssl.conf":
	      ensure => "present",
	      notify => Service["httpd"],
	      require => Package["mod_ssl"],
	    }
	    exec { "/usr/bin/passenger-install-apache2-module --auto":
	      subscribe => Package["passenger"],
	      before => Service["httpd"],
          creates => "/usr/lib/ruby/gems/1.8/gems/$passenger_version/ext/apache2/mod_passenger.so",
	    }
}