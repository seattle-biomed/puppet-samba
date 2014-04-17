# Samba Default Parameters
class samba::params {

  $testparm_bin = '/usr/bin/testparm'
  $conf_file    = 'smb.conf'

  case $::osfamily {
    'RedHat': {
      $conf_directory = '/etc/samba'
      $service_name = 'smb'
    }
    'Debian': {
      $conf_directory = '/etc/samba'
      $service_name = 'smbd'
    }
    'Gentoo': {
      $conf_directory = '/etc/samba'
      $service_name = 'samba'
    }
    'FreeBSD': {
      $conf_directory = '/usr/local/etc'
      $service_name = 'samba'
    }
    default: {
      fail("Module ${module_name} is not supported on ${::operatingsystem}")
    }
  }

}
