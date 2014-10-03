node default {

  include puppetlabs_apt
 
  package {['puppet','puppetserver']:
    ensure  => 'latest',
    require => Class['puppetlabs_apt'],
  }
  
  file {'/var/run/puppet': 
    ensure  => 'directory',
    owner   => 'puppet',
    group   => 'puppet'
    require => Package['puppetserver'],
  }
  
  service {'puppetserver':
    ensure  => 'running',
    enable  => 'true',
    require => [Package['puppetserver'],File['/var/run/puppet']],
  }
  
}
