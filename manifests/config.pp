#
# This module manages hhvm packages.
class hhvm::config {
  file { '/var/log/hhvm':
    ensure => 'directory',
    owner  => $::hhvm_user,
    group  => $::hhvm_user
  }
    
  file { '/var/run/hhvm':
    ensure => 'directory',
    owner  => $::hhvm_user,
    group  => $::hhvm_user
  }
          
  file { '/etc/hhvm':
    ensure => 'directory',
  }
          
  # this is only needed for www-data
  file { '/var/www/.hhvm.hhbc':
    ensure => 'file',
    owner  => $::hhvm_user,
    group  => $::hhvm_user
  }
    
  file { '/etc/hhvm/cli.ini':
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    content => template("${module_name}/etc/hhvm/cli.ini.erb"),
  }
}