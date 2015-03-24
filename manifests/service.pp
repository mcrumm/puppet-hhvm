# == Class: hhvm::service
#
# This class mangaes the hhvm service on multiple ports
define hhvm::service (
  $ensure = 'running',
  $debugger_port = $hhvm::params::debugger_port,
  $admin_server_port = $hhvm::params::admin_server_port,
  $source_root = $hhvm::params::source_root
) {
  require hhvm
  
  $port = $title
    
  # maintain compatibility with existing nginx setups
  $socket = regsubst("/var/run/hhvm/hhvm_$port.sock","(_$hhvm::params::port)",'','G')
  $service = regsubst("hhvm_$port" ,"(_$hhvm::params::port)",'','G')
  $default = regsubst("/etc/default/hhvm_$port" ,"(_$hhvm::params::port)",'','G')
  $init_d = regsubst("/etc/init.d/hhvm_$port" ,"(_$hhvm::params::port)",'','G')
  $init = regsubst("/etc/init/hhvm_$port.conf","(_$hhvm::params::port)",'','G')
  $server_ini = regsubst("/etc/hhvm/server_$port.ini","(_$hhvm::params::port)",'','G')
  $php_ini = regsubst("/etc/hhvm/php_$port.ini","(_$hhvm::params::port)",'','G')
  $config_hdf = regsubst("/etc/hhvm/config_$port.hdf","(_$hhvm::params::port)",'','G')
  $jit_repo = regsubst("/tmp/.hhvm_$port.hhbc","(_$hhvm::params::port)",'','G')
  $error_log = regsubst("/var/log/hhvm/error_$port.log","(_$hhvm::params::port)",'','G')
  $pid = regsubst("/var/run/hhvm/hhvm_$port.pid","(_$hhvm::params::port)",'','G')
  $admin_server_log = regsubst("/var/log/hhvm/admin_$port.log","(_$hhvm::params::port)",'','G')

  file { $default:
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    content => template("${module_name}/etc/default/hhvm.erb"),
  }
  
  file { $init_d:
    ensure  => 'file',
    mode    => '0755',
    owner   => 'root',
    group   => 'root',
    content => template("${module_name}/etc/init.d/hhvm.erb"),
  }
          
  file { $init:
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    content => template("${module_name}/etc/init/hhvm.conf.erb")
  }

  file { $server_ini:
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    content => template("${module_name}/etc/hhvm/server.ini.erb"),
  }
    
  file { $php_ini:
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    content => template("${module_name}/etc/hhvm/php.ini.erb"),
  }
    
  file { $config_hdf:
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    content => template("${module_name}/etc/hhvm/config.hdf.erb"),
  }
  
  if ($hhvm::compile_from_source) {
    service { $service:
        ensure    => $::ensure,
        hasstatus => true,
        enable    => true,
        require   => Exec['Use build-hhvm.sh']
    }
  } else {
    service { $service:
        ensure    => $ensure,
        hasstatus => true,
        enable    => true,
        require   => Package[$hhvm::install::package::hhvm_package_name]
    }
    # stop default hhvm service supplied by the package as is it's configuration is not multi-port aware
    #service { "hhvm":
    #  ensure  => "stopped",
    #  enable  => false,
    #}
  }
}
