# Samba Server
class samba (
  $package_ensure     = 'installed',
  $service_enable     = true,
  $service_ensure     = 'running',
  $config_options     = hash([]),
  $share_defaults     = hash([]),
) {

  class { 'samba::params': }
  -> class { 'samba::package': }
  -> class { 'samba::config': config_options => $config_options }
  -> class { 'samba::service': }

}
