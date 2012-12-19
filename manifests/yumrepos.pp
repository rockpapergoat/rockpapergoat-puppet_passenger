# Class: repos
#
#
class yumrepos {
    
    # uses puppetlabs-epel module
    include epel
    
    file { "/etc/yum.repos.d/puppetlabs.repo":
	   ensure => file,
	   content => template("puppetpassenger/puppetlabs.repo.erb")
	}
}