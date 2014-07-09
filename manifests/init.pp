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
  $compile_from_source = true,
  
  $sourceroot = $hhvm::params::source_root,
  
  $jit_enabled = $hhvm::params::jit_enabled,
  $jit_warmup_requests = $hhvm::params::jit_warmup_requests,
  
  $timezone = $hhvm::params::timezone,
  $max_post_size = $hhvm::params::max_post_size,
  $upload_max_file_size = $hhvm::params::upload_max_file_size, 
  
  $enable_debugger = $hhvm::params::enable_debugger,
  $enable_debugger_server = $hhvm::params::enable_debugger_server,
  $debugger_port = $hhvm::params::debugger_port,
  $admin_server_password = $hhvm::params::admin_server_password,
) {
    class { 'hhvm::config': }
	  class { 'hhvm::install::package': }
	  class { 'hhvm::install::build': }
	  class { 'hhvm::service': }
	
	  anchor { 'hhvm::begin': }
	  anchor { 'hhvm::end': }
	
	  Anchor['hhvm::begin'] ->
	  Class['hhvm::config'] ->
	  Class['hhvm::install::package'] ->
	  Class['hhvm::install::build'] ->
	  Class['hhvm::service'] ->
	  Anchor['hhvm::end']
}
