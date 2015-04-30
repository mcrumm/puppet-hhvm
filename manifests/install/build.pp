#
# This module builds hhvm.
class hhvm::install::build {

  file { 'build-hhvm.sh':
    ensure  => present,
    path    => '/tmp/build-hhvm.sh',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template("${module_name}/build-hhvm.sh.erb")
  }
  
  # compile hhvm
  if ($hhvm::compile_from_source) {
    exec { 'Use build-hhvm.sh':
      require => File['build-hhvm.sh'],
      command => '/tmp/build-hhvm.sh',
      creates => $hhvm::params::path_to_source_hhvm,
      notify  => Class['hhvm::service']
    }
    
    # Ensures that the file is created before running the command
    File['build-hhvm.sh'] -> Exec['Use build-hhvm.sh']
  }
}
