# == Class: hhvm::service
#
# This class mangaes the hhvm service on multiple ports
class hhvm::service (
  $ensure = 'running',
  $port = $hhvm::params::port,
  $debugger_port = $hhvm::params::debugger_port,
  $admin_server_port = $hhvm::params::admin_server_port,
  $source_root = $hhvm::params::source_root
) {
  require hhvm
 
  $default="/etc/default/hhvm_$port" 
  $server_ini="/etc/hhvm/server_$port.ini"
  $php_ini="/etc/hhvm/php_$port.ini"
  $config_hdf="/etc/hhvm/config_$port.hdf"
  $jit_repo = "/tmp/.hhvm_$port.hhbc"
  $error_log = "/var/log/hhvm/error_$port.log"
  $socket = "/var/run/hhvm/hhvm_$port.sock"
  $pid = "/var/run/hhvm/hhvm_$port.pid"
  $admin_server_log = "/var/log/hhvm/admin_$port.log"

  file { "/etc/default/hhvm_$::port":
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    content => template("${module_name}/etc/default/hhvm.erb"),
  }
  
  file { "/etc/init.d/hhvm_$::port":
    ensure  => 'file',
    mode    => '0755',
    owner   => 'root',
    group   => 'root',
    content => template("${module_name}/etc/init.d/hhvm.erb"),
  }
          
  file { "/etc/init/hhvm_$::port.conf":
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    content => template("${module_name}/etc/init/hhvm.conf.erb")
  }

  file { "/etc/hhvm/cli_$::port.ini":
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    content => template("${module_name}/etc/hhvm/cli.ini.erb"),
  }
    
  file { "/etc/hhvm/server_$::port.ini":
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    content => template("${module_name}/etc/hhvm/server.ini.erb"),
  }
    
  file { "/etc/hhvm/php_$::port.ini":
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    content => template("${module_name}/etc/hhvm/php.ini.erb"),
  }
    
  file { "/etc/hhvm/config_$::port.hdf":
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    content => template("${module_name}/etc/hhvm/config.hdf.erb"),
  }
  
  if ($hhvm::compile_from_source) {
    service { "hhvm_$::port":
        ensure    => $::ensure,
        hasstatus => true,
        enable    => true,
        require   => Exec['Use build-hhvm.sh']
    }
  } else {
    service { "hhvm_$::port":
        ensure    => $::ensure,
        hasstatus => true,
        enable    => true,
        require   => Package[$hhvm::install::package::hhvm_package_name]
    }
  }
  
  # stop default hhvm service supplied by the package as is it not multi-port aware
  service { "hhvm":
    ensure  => "stopped"
  }
}
