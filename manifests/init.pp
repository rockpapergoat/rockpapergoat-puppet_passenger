# Class: puppet-passenger
# centos/rhel specific reworking of the passenger config install
# provided by puppetlabs under /usr/share/puppet/ext/rack/ (as of puppet 3.0.1)

class puppetpassenger {
   # include puppetpassenger::params
	include puppetserver
	include httpdpassenger
	include yumrepos
	
	Class["yumrepos"] -> Class["puppetserver"] -> Class["httpd-passenger"]
}