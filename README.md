puppet-hhvm
===========

Build HHVM from source for Ubuntu 14.04. This process can take over an hour..

Designed to work in conjuction with a nginx module.

To use in your .pp file:

class { "hhvm": }

To make use of hhvm as fastcgi interface make sure that:

"unix:/var/run/hhvm/hhvm.sock" is your fastcgi interface in your nginx module

Requirements:

Ubuntu 14.04

Additional puppet modules - vcsrepo if building from source
https://github.com/puppetlabs/puppetlabs-vcsrepo

puppet-apt if using package
https://github.com/example42/puppet-apt

Credits:

Me for building it into a puppet module!

Facebook - https://github.com/facebook/hhvm/wiki/Building-and-installing-HHVM-on-Ubuntu-13.10

Cyrill Schumacher - https://gist.github.com/SchumacherFM/6204170

Vadim Borodavko - https://github.com/javer/hhvm-vagrant-vm/blob/master/etc/init.d/hhvm

Yermo Lamers - http://stackoverflow.com/questions/19013516/upstart-script-for-hhvm-hiphop
