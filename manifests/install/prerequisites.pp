# Class: hhvm::prerequisites
#
# This module manages HHVM prerequisites installation
class hhvm::install::prerequisites(
) {
  # build-essential already defined in gcc
  #require gcc
  
  $ubuntu_packages = [
    
      'autoconf', 'automake', 'binutils-dev', 'build-essential', 'cmake', 'g++', 'git',
		  'libboost-dev', 'libboost-filesystem-dev', 'libboost-program-options-dev', 'libboost-regex-dev',
		  'libboost-system-dev', 'libboost-thread-dev', 'libbz2-dev', 'libc-client-dev',
		  'libc-client2007e-dev', 'libcap-dev', 'libcurl4-openssl-dev', 'libdwarf-dev libelf-dev',
		  'libexpat-dev', 'libgd2-xpm-dev', 'libgoogle-glog-dev', 'libgoogle-perftools-dev', 'libicu-dev',
		  'libjemalloc-dev', 'libmcrypt-dev', 'libmemcached-dev', 'libmysqlclient-dev', 'libncurses-dev',
		  'libonig-dev', 'libpcre3-dev', 'libreadline-dev', 'libtbb-dev libtool', 'libxml2-dev', 'zlib1g-dev', 'libevent-dev',
		  'libmagickwand-dev', 'libxslt1-dev', 'ocaml-native-compilers'
  ]
  
  package { $ubuntu_packages:
    ensure => 'present',
  } 
}