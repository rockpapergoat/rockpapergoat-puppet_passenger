# Class: puppet-passenger
# centos/rhel specific reworking of the passenger config install
# provided by puppetlabs under /usr/share/puppet/ext/rack/ (as of puppet 3.0.1)

class puppet-passenger {
	include puppetserver
	include httpd-passenger
	include yumrepos
	
	Class["yumrepos"] -> Class["puppetserver"] -> Class["httpd-passenger"]
}