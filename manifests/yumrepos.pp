# Class: repos
#
#
class yumrepos {
    
    # uses puppetlabs-epel module
    include epel
    
    file { "/etc/yum.repos.d/puppetlabs.repo":
	   ensure => file,
	   content => template("puppet-passenger/puppetlabs.repo.erb")
	}
}