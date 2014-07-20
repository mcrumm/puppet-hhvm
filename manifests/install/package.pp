#
# This module manages hhvm packages.
class hhvm::install::package {

  case $operatingsystem {
    debian,ubuntu: {
      if($hhvm::compile_from_source) {
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
			} else {
			  
			  include apt
			  apt::key { "1BE7A449": key_source => 'http://dl.hhvm.com/conf/hhvm.gpg.key' }
        
        apt::source { "hhvm":
            location	=> "http://dl.hhvm.com/ubuntu/",
            release	=> 'trusty',
            repos 	=> 'main',
            require 	=> Apt::Key["1BE7A449"]
        }

        package { "hhvm": 
          ensure => installed,
          require => Apt::Source["hhvm"]
        }
			}   
    }
    centos,fedora,rhel: {
      fail("Module ${module_name} has no config for ${::operatingsystem}")
    }
  }
  
  # at the moment hiphop does not load php.ini/server.ini by default and we need these for running hhvm from bash
  file { '/usr/local/bin/hhvm-cli':
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template("${module_name}/usr/local/bin/hhvm-cli.erb"),
  }
}
