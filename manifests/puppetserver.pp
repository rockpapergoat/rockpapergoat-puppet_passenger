# Class: puppetserver
#
#
class puppetserver {
	
	package {"puppet-server":
      ensure => installed,
  }

	# we need to stop and start the service at least once
	# to generate certs
	service {"puppetmaster":
		ensure => running,
		enable => false,
	}
}

Service["puppetmaster"] {ensure => stopped}