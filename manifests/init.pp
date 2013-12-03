# Samba Server
class samba (
  $workgroup          = $::domain,
  $server_string      = $::fqdn,
  $server_alias       = $::hostname,
  $log_file           = '/var/log/samba/log.%m',
  $package_ensure     = 'installed',
  $service_enable     = true,
  $service_ensure     = 'running',
  $config_options     = hash([]),
  $share_defaults     = hash([]),
) {

  class { 'samba::params': }
  -> class { 'samba::package': }
  -> class { 'samba::config':  }
  -> class { 'samba::service': }

}
