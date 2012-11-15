# Class: puppet-passenger::params
# variables for core packages, service names, etc.
#
class puppet-passenger::params {
  case $osfamily {
		"redhat": {
			$core_packages = ["httpd-itk",  "httpd", "mod_ssl", "httpd-devel", 
		    "apr-util", "apr-util-devel", "openssl-devel", "libcurl-devel", 
		    "zlib-devel", "gcc-c++", "ruby-devel", "rubygem-rake", "rubygem-passenger"]
			$apache_name = "httpd"
			$passenger_gem_version = undef
			$core_gems = ["rack", "passenger"]
			$puppetmaster_service = "puppetmaster"
		}
		"debian": {
			$core_packages = undef
			$apache_name = "apache"
			$passenger_gem_version = undef
			$core_gems = undef
			$puppetmaster_service = undef
		}

		default: {
			notify {"a default message":
				message => "you're running something other than a RHEL or Debian distribution. patches are welcome."
			}
		}
	}
}