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
  $sourceroot = "/var/www/vhosts/magento-capistrano/current",
  $adminpassword = 'UyPutcu9',
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
