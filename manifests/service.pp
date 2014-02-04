# == Class: hhvm::service
#
# This class mangaes the hhvm service.  It is not inteded to be called
# directly
class hhvm::service (
) {
    service { 'hhvm':
        ensure    => 'running',
        hasstatus => true,
        enable    => true,
        require   => Exec['Use build-hhvm.sh']
    }
}
