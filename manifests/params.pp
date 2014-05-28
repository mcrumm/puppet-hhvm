class hhvm::params {

  $hhvm_user  = $operatingsystem ? { centos => 'nginx', ubuntu => 'www-data', default => 'nginx' }
  $jit_repo = "/tmp/.hhbc.hhvm"
  $port = 9000
  $socket = "/var/run/hhvm/hhvm.sock"
  $pid = "/var/run/hhvm/hhvm.pid"
  $error_log = "/var/log/hhvm/error.log"
  $timezone = "Europe/London"
}