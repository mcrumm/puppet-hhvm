puppet-hhvm
===========

Build HHVM from source for Ubuntu. This process can take over an hour.. Only tested on Ubuntu 13.10

Designed to work in conjuction with a nginx module.

To use in your .pp file:

class { "hhvm": }

To make use of hhvm as fastcgi interface make sure that:

"unix:/var/run/hhvm/hhvm.sock" is your fastcgi interface in your nginx module

Credits:

Me for building it into a puppet module!

Facebook - https://github.com/facebook/hhvm/wiki/Building-and-installing-HHVM-on-Ubuntu-13.10

Cyrill Schumacher - https://gist.github.com/SchumacherFM/6204170

Vadim Borodavko - https://github.com/javer/hhvm-vagrant-vm/blob/master/etc/init.d/hhvm
