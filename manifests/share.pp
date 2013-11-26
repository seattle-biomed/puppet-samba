# Samba Share Definition
#
define samba::share_file (
  $name                 = undef,
  $path                 = undef,
  $ensure               = 'present',
  $share_options        = [],
) {
  include samba::params

  validate_string($name)
  validate_absolute_path($path)

  $conf_directory = $::samba::params::conf_directory

  $share_defaults = $samba::share_defaults

  file { "${conf_directory}/${name}.share":
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('samba/share.erb'),
    require => [File[$conf_directory], Class['samba::package']],
    notify  => Class['samba::service']
  }

}
