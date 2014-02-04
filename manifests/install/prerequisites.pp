# Class: hhvm::prerequisites
#
# This module manages HHVM prerequisites installation
class hhvm::install::prerequisites(
) {
  # build-essential already defined in gcc
  require gcc
  
  $ubuntu_packages = [
    
		  'git', 'cmake', 'g++', 'libboost-dev', 'libmysqlclient-dev', 'libxml2-dev',
		  'libmcrypt-dev', 'libicu-dev', 'binutils-dev', 'libcap-dev', 'libgd2-xpm-dev',
		  'zlib1g-dev', 'libtbb-dev', 'libonig-dev', 'libpcre3-dev', 'autoconf', 'libtool', 'libcurl4-openssl-dev',
		  'libboost-system-dev', 'libboost-program-options-dev', 'libboost-filesystem-dev', 'libboost-thread-dev',
		  'libreadline-dev', 'libncurses-dev', 'libmemcached-dev', 'libbz2-dev', 'libc-client2007e-dev',
		  'libgoogle-perftools-dev', 'libelf-dev', 'libdwarf-dev', 'libboost-regex-dev', 'libgoogle-glog-dev',
		  'libjemalloc-dev'
  ]
  
  package { $ubuntu_packages:
    ensure => 'present',
  } 
}