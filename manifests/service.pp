# == Class: hhvm::service
#
# This class mangaes the hhvm service.  It is not inteded to be called
# directly
class hhvm::service (
) {
  if ($hhvm::compile_from_source) {
    service { 'hhvm':
        ensure    => 'running',
        hasstatus => true,
        enable    => true,
        require   => Exec['Use build-hhvm.sh']
    }
  } else {
    service { 'hhvm':
        ensure    => 'running',
        hasstatus => true,
        enable    => true,
        require   => Package[$hhvm::install::package::hhvm_package_name]
    }
  }
}
