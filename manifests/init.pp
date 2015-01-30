# == Class: consul_alerts
#
# The consul_alerts class currently contains installation and configuration for the consul_alerts
# puppet module. This will install a binary release of the consul-alerts service and
# launch it with upstart init system.
#
# === Parameters
#
# [*enabled*]
#   Enable the class as installed or not
#   Can be true or false (bool)
# [*binary_path*]
#   The system path in which to install the consul-alerts binary download
# [*version*]
#   A string containing the release version to install
# [*repo_url*]
#   Default repository URL from which to download the binary release
# [*arch*]
#   Server architecture version amd64/i386
# [*default_url*]
#   Use the default repository and download url either true or false (bool)
# [*custom_url*]
#   If you want to specify a custom download filename/location, specify it here
# [*data_center*]
#   Specify the data-center name in which to run the consul-alerts checks and k/v lookups
# [*watch_events*]
#   Boolean value for if event notifications from consul should be watched
# [*watch_checks*]
#   Boolean value for check update notifications from consul
#
# === Examples
#
#  class { 'consul_alerts':
#    data_center => 'dc1',
#  }
#
# === Authors
#
# Justice London <jlondon@syrussystems.com>
#
# === Copyright
#
# Copyright 2015 Justice London
#
class consul_alerts (
  $enabled      = true,
  $binary_path  = '/usr/local/bin',
  $version      = '0.2.0',
  $repo_url     = 'https://github.com/AcalephStorage/consul-alerts/releases/download',
  $arch         = $::architecture,
  $default_url  = true,
  $custom_url   = undef,
  $data_center  = 'dc1',
  $watch_events = true,
  $watch_checks = true,
) {

  #Build the full download URL
  $filename     = "consul-alerts-${version}-linux-${arch}.tar"
  $download_url = $default_url ? {
    false   => $custom_url,
    default => "${repo_url}/v${version}/${filename}",
  }

  #Download consul-alerts binary
  include ::wget

  wget::fetch { 'download_consul_alerts':
    source      => $download_url,
    destination => "/tmp/${filename}",
    cache_dir   => '/var/tmp',
    notify      => Exec['extract_consul_alerts'],
  }

  #Install binary
  exec { 'extract_consul_alerts':
    command     => "tar -xf /tmp/${filename}",
    cwd         => $binary_path,
    refreshonly => true,
    path        => ['/bin', '/sbin', '/usr/bin', '/usr/sbin'],
    notify      => Service['consul-alerts'],
  }

  #Define present/absent as true/false. Still don't understand why this isn't a builtin.
  $file_ensure = $enabled ? {
    false   => absent,
    default => present,
  }
  #Build init file
  file { '/etc/init/consul-alerts.conf':
    ensure  => $file_ensure,
    content => template('consul_alerts/initfile.erb'),
    notify  => Service['consul-alerts'],
  }

  service { 'consul-alerts':
    ensure  => $enabled,
    enable  => $enabled,
    require => [
      Exec['extract_consul_alerts'],
      File['/etc/init/consul-alerts.conf'],
    ],
  }

}
