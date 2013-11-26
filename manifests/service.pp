# Samba Server Service
class samba::service (
  $ensure = $samba::service_ensure,
  $enable = $samba::service_enable,
) {
  include $samba::params

  $service_name   = $samba::params::service_name
  $testparm_bin   = $samba::params::testparm_bin
  $conf_directory = $samba::params::conf_directory
  $conf_file      = $samba::params::conf_file

  exec {'test-samba-configuration':
    command     => "${testparm_bin} -s ${conf_directory}/${conf_file}",
    refreshonly => true,
    subscribe   => Class['samba::config']
  }

  service { $service_name :
    ensure      => $ensure,
    hasstatus   => true,
    hasrestart  => true,
    enable      => $enable,
    require     => Exec['test-samba-configuration']
  }

}
