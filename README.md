# Puppet Samba Module

Module for provisioning Samba

Requires puppetlabs/stdlib

## Usage

This module puts share definitions in an included directory and assumes that
most samba configuration options are defaults.

To set specific options to non-default values put them in the $config_options hash.
$share_options for shares.

Shares must be defined as 'samba::share_file' resources and listed as
'include_files' in the base samba class, with '.share' appended to the
share name. (Samba doesn't support wildcard includes.) See examples below.

## Example

  $config_options = {
    bind interfaces only  => 'yes',
    deadtime              => '15',
    domain master         => 'no',
    dns proxy             => 'no',
    interfaces            => $::ipaddress,
    obey pam restrictions => 'yes',
    socket_options        => 'TCP_NODELAY SO_RCVBUF=8192 SO_SNDBUF=8192',
  }

  $share_defaults = {
    read_only            => 'no',
    create_mask          => '0660',
    directory_mask       => '2770',
    force_create_mode    => '0660',
    force_directory_mode => '2770',
  }

  class { '::samba':
    workgroup       => $::fqdn,
    server_string   => $::hostname,
    server_alias    => 'My Workstation',
    config_options  => $config_options,
    share_defaults  => $share_defaults,
    include_files   => ['My_Home.share','Guest.share'],
  }

  $my_home_share_options = {
    valid_users          => 'me',
  }

  samba::share_file { 'My_Home':
    path          => '/home/me',
    share_options => $my_home_share_options
  }

  $guest_share_options = {
    guest_ok    => 'yes',
    force_user  => 'nobody',
  }

  samba::share_file { 'Guest':
    path          => '/tmp/guest',
    share_options => $guest_share_options
  }

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

This module is released under the MIT license:

* [http://www.opensource.org/licenses/MIT](http://www.opensource.org/licenses/MIT)
