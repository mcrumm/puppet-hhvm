#
# This module builds hhvm.
class hhvm::install::build {
          
    # compile libevent and hhvm
    file {'build-hhvm.sh':
        ensure => present,
        path   => '/tmp/build-hhvm.sh',
        owner  => 'root',
        group  => 'root',
        mode   => '755',
        source => 'puppet:///modules/hhvm/build-hhvm.sh',
    }
          
    exec {"Use build-hhvm.sh":
        require => File['build-hhvm.sh'],
        command => "/tmp/build-hhvm.sh",
        creates => "/usr/local/src/hiphop-php/hhvm/hphp/hhvm/hhvm",
        notify  => Class['hhvm::service']
    }      
     
    # Ensures that the file is created before running the command
    File['build-hhvm.sh'] -> Exec['Use build-hhvm.sh']
}