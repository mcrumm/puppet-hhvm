class hhvm::params {

  $hhvm_user  = $operatingsystem ? { centos => 'nginx', ubuntu => 'www-data', default => 'nginx' }
}