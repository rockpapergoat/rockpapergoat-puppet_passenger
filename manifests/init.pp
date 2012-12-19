# Class: puppet-passenger
# centos/rhel specific reworking of the passenger config install
# provided by puppetlabs under /usr/share/puppet/ext/rack/ (as of puppet 3.0.1)

class puppetpassenger {
    $passenger_version = "3.0.18"
	include puppetserver
	include httpdpassenger
	include yumrepos
	
	Class["yumrepos"] -> Class["puppetserver"] -> Class["httpdpassenger"]
}