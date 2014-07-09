#
# This module manages hhvm packages.
class hhvm::install::package {

  case $operatingsystem {
    debian,ubuntu: {
      include hhvm::install::prerequisites
          
      if($hhvm::compile_from_source) {
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
			  
			  # Get Package from apt - this has not been tested
			  include apt
			  apt::key { "2048R/1BE7A449": url => 'http://dl.hhvm.com/conf/hhvm.gpg.key' }
        apt::source { "hhvm":
          url => "http://dl.hhvm.com",
          distro => "ubuntu",
          release => "trusty",
          repository => "main"
        }

        package { "hhvm": 
          ensure => installed
        }
        #echo deb http://dl.hhvm.com/ubuntu trusty main | sudo tee /etc/apt/sources.list.d/hhvm.list
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