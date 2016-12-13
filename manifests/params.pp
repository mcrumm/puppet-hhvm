# hhvm::params - set default options
class hhvm::params {

  $path_to_source_hhvm = '/usr/local/src/hiphop-php/hhvm/hphp/hhvm/hhvm'
  
  # What user should hhvm run as?
  $hhvm_user  = $::operatingsystem ? {
    centos => 'nginx',
    ubuntu => 'www-data',
    default => 'nginx'
  }

  # What group should hhvm run as?
  $hhvm_group  = $::operatingsystem ? {
    centos => 'nginx',
    ubuntu => 'www-data',
    default => 'nginx'
  }
  
  # Used in upstart/restart
  $pid = '/var/run/hhvm/hhvm.pid'
  
  # This needs to be read/writeable by the hhvm process
  $jit_repo = '/var/run/hhvm/hhvm.hhbc'
  
  # What port and socket to listen to
  $port = 9000
  $socket = '/var/run/hhvm/hhvm.sock'
  $server_type = 'fastcgi'
  
  # These settings might not be required anymore
  $source_root = '/var/www/html'
  $default_document = 'index.php'
  
  # Debug settings
  $enable_debugger = false
  $enable_debugger_server = false
  $debugger_port = undef
  
  # Error log for cli
  $error_log = '/var/log/hhvm/error.log'
  
  # Admin server
  $admin_server_port = 0
  $admin_server_thread_count = 1
  $admin_server_password = 'UyPutcu9'
  
  # Jit settings
  $jit_enabled = true
  $jit_warmup_requests = 5
  
  # Compatability settings - for Magento
  $allow_duplicate_cookies = 0
  
  # APC
  $enable_apc = true
  
  # Logging
  $use_log_file = true
  $log_level = 'Warning'
  $always_log_unhandled_exceptions = true
  $runtime_error_reporting_level = 8191
  $typed_results = false

  # PHP Settings
  $date_timezone = undef
  
  $limit = 131072
  
  # Further settings to translate?
  #   display_errors      => 'On', # no such setting?
  #   max_execution_time  => '600', # no such setting?
  #   max_input_vars      => '3000', # no such setting?
  $disable_zend_ini_compat = ''
}
