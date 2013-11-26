# Samba Package
#
class samba::package (
  $ensure = $samba::package_ensure,
){

  package { 'samba':
    ensure => $ensure
  }

}
