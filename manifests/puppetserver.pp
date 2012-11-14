# Class: puppetserver
#
#
class puppetserver {
	
	package {["puppet", "puppet-server"]:
      ensure => latest,
  }

	# we need to stop and start the service at least once
	# to generate certs
	service {"puppetmaster":
		ensure => running,
		enable => false,
		require => Package["puppet-server"],
	}
	
	exec { "stopmaster":
		command => "service puppetmaster stop",
		path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
		refreshonly => true,
		require => Service["puppetmaster"],
	}
}

