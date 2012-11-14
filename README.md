rockpapergoat-puppet-passenger
==============================

this is a work in progress.

it's a modified version of the rack config bootstrap puppetlabs includes under /usr/share/puppet/ext/rack with bits to install and configure passenger in a puppet master + passenger setup.

the problem with the manifest.pp puppetlabs ships for rack config is that it's debian specific, so this version is centos/rhel specific. it's not portable yet.
