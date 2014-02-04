#
# This module manages hhvm packages.
class hhvm::install::package {

  case $operatingsystem {
        debian,ubuntu: {
          include hhvm::install::prerequisites
            
          file { "/usr/local/src/hiphop-php":
              ensure => "directory",
          }
          
          vcsrepo { "/usr/local/src/hiphop-php/hhvm":
					    ensure   => present,
					    provider => git,
					    source   => "git://github.com/facebook/hhvm.git",
					    revision => "master",
					    require  => File["/usr/local/src/hiphop-php"]
					}      
      
          vcsrepo { "/usr/local/src/hiphop-php/libevent":
              ensure => present,
              provider => git,
              source => "git://github.com/libevent/libevent.git",
              revision => 'release-1.4.14b-stable',
              require  => File["/usr/local/src/hiphop-php"]
          } 
        }
        centos,fedora,rhel: {
            fail("Module ${module_name} has no config for ${::operatingsystem}")
        }
  }
}