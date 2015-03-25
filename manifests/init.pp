#
# This module manages hhvm.
#
# Sample Usage:
#
# node default {
#   include hhvm
# }
#
class hhvm(
  $number_of_processor_cores = $hhvm::params::number_of_processor_cores,
  $compile_from_source = false,
  $use_nightly = false,
  
  $jit_enabled = $hhvm::params::jit_enabled,
  $jit_warmup_requests = $hhvm::params::jit_warmup_requests,
  
  $date_timezone = $hhvm::params::date_timezone,
  $max_post_size = $hhvm::params::max_post_size,
  $upload_max_file_size = $hhvm::params::upload_max_file_size,
  
  $enable_debugger = $hhvm::params::enable_debugger,
  $enable_debugger_server = $hhvm::params::enable_debugger_server,
  $admin_server_password = $hhvm::params::admin_server_password,

  $limit = $hhvm::params::limit,

  $php_ini_cfg_append             = {},
  $server_ini_cfg_append          = {},
  
  $config_hdf_env_append          = {},
  $config_hdf_dyn_ext_append      = {},

  # service (port) specific
  $port = undef,
  $source_root = undef,
  $admin_server_port = undef,
  $debugger_port = undef,
  $ensure = 'running'
) {
  include hhvm::params
  
  $port_final = $port ? {
    undef => $hhvm::params::port,
    default => $port
  }
  
  $source_root_final = $source_root ? {
    undef => $hhvm::params::source_root,
    default => $source_root
  }
  
  $admin_server_port_final = $admin_server_port ? {
    undef => $hhvm::params::admin_server_port,
    default => $admin_server_port
  }
  
  $debugger_port_final = $debugger_port ? {
    undef => $hhvm::params::debugger_port,
    default => $debugger_port
  }
  
  if($compile_from_source) {
    $path_to_hhvm = '/usr/local/bin/hhvm'
  } else {
    $path_to_hhvm = '/usr/bin/hhvm'
  }
  
  #if ($php_ini_cfg_append != undef) {
  #  validate_hash($php_ini_cfg_append)
  #}
    
  #if ($config_hdf_env_append != undef) {
  #  validate_hash($config_hdf_env_append)
  #}
    
  #if ($config_hdf_dyn_ext_append != undef) {
  #  validate_hash($config_hdf_dyn_ext_append)
  #}
    
  class { 'hhvm::config': }
  class { 'hhvm::install::package': }
  class { 'hhvm::install::build': }
  
  # create default server, port 9000
  hhvm::service { $port_final:
    ensure            => $ensure,
    debugger_port     => $debugger_port_final,
    admin_server_port => $admin_server_port_final,
    source_root       => $source_root_final
  }

  anchor { 'hhvm::begin': }
  anchor { 'hhvm::end': }
  
  Anchor['hhvm::begin'] ->
  Class['hhvm::config'] ->
  Class['hhvm::install::package'] ->
  Class['hhvm::install::build'] ->
  Anchor['hhvm::end']
}
