puppet-hhvm
===========

This module installs HHVM (the Facebook HipHop Virtual Machine) on your web server.

The default settings are to listen on a socket at: /var/run/hhvm/hhvm.pid. You can use this via FastCGI in nginx or Apache to connect to it.

Usage:
======

The module by default will compile HipHop VM from source.

Puppet will most likely time out but the compilation will continue in the background.

class { "hhvm": }

To use a package instead (not tested yet):

class { "hhvm": 
	compile_from_source => false,
}

Additional options are supported, take a look at init.pp:

class { "hhvm": 
	number_of_processor_cores => 2, # Use how many cores for compilation, default is all
	date_timezone => "Europe/London", # Change your timezone (see PHP setting)
	jit_warmup_requests => 5 # Reduce the number of jit warm up requests
}

Connecting to HHVM:
===================

In your nginx configuration, set:

fastcgi_pass   unix:/var/run/hhvm/hhvm.sock;

Restarting HHVM
===============

sudo service hhvm restart or sudo /etc/init.d/hhvm restart

Supported Operating Systems:
============================

Ubuntu 14.04

Additional puppet modules
=========================

vcsrepo if building from source
https://github.com/puppetlabs/puppetlabs-vcsrepo

puppet-apt if using package
https://github.com/example42/puppet-apt

Contributing
============

Feel free to submit a PR for further options or more operating system support!