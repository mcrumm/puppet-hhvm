class hhvm::params {

  # Used in compilation, not in run time
  $number_of_processor_cores = $::physicalprocessorcount

  # Various settings for the server
  $hhvm_user  = $operatingsystem ? { centos => 'nginx', ubuntu => 'www-data', default => 'nginx' }
  $jit_repo = "/tmp/.hhvm.hhbc"
  $port = 9000
  $socket = "/var/run/hhvm/hhvm.sock"
  $pid = "/var/run/hhvm/hhvm.pid"
  $error_log = "/var/log/hhvm/error.log"
  
  # PHP Settings
  $timezone = "Europe/London"
  
  # Further settings to translate?
  #   memory_limit        => '256M', - No such setting in hiphop?
  #   hhvm.log.runtime_error_reporting_level # php setting - error_reporting     => 'E_ALL & ~E_NOTICE | E_DEPRECATED'
  #   display_errors      => 'On', # no such setting?
  #   hhvm.server.max_post_size  # PHP post_max_size       => '40M', 
  #   hhvm.server.upload.upload_max_file_size # PHP upload_max_filesize => '32M',
  #   max_execution_time  => '600', # no such setting?
  #   max_input_vars      => '3000', # no such setting?     
}