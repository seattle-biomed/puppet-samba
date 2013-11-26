# Samba Server Configuration
#
class samba::config (
  $workgroup          = $::domain,
  $server_string      = $::fqdn,
  $server_alias       = $::hostname,
  $log_file           = '/var/log/samba/log.%m',
  $config_options     = $samba::config_options,
  $include_files      = [],
){
  include $samba::params

  $conf_directory = $samba::params::conf_directory
  $conf_file      = $samba::params::conf_file

  file { $conf_directory:
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
  }

  file { "${conf_directory}/${conf_file}":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => [File[$conf_directory], Class['samba::package']],
    notify  => Class['samba::service']
  }

}
