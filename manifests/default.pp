node default {

  include puppetlabs_apt
 
  package {['puppet','puppetserver']:
    ensure => 'latest',
    require => Class['puppetlabs_apt'],
  }
  
  service {'puppetserver':
    ensure => 'running',
    enable => 'true',
    require => Package['puppetserver'],
  }
  
}
