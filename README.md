puppet-hhvm
===========

Build HHVM from source for Ubuntu. This process can take over an hour..

Designed to work in conjuction with a nginx module.

To use in your .pp file:

class { "hhvm": }

To make use of hhvm as fastcgi interface make sure that:

"unix:/var/run/hhvm/hhvm.sock" is your fastcgi interface in your nginx module
