# Class: testing
#
#
class testing {
    include puppetpassenger::params

    $pathname = "${puppetpassenger::params::apache_conf_dir}/puppetmaster.conf"
    
    
        file { "/tmp/${puppetpassenger::params::core_gems}":
        #content => "$pathname, $gems",
        ensure => file,
        }
    
}

include testing