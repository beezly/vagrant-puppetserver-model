node default {

  include puppetlabs_apt
 
  package {['puppet','puppetserver']:
    ensure  => 'latest',
    require => Class['puppetlabs_apt'],
  }
  
  file {'/var/run/puppet': 
    ensure  => 'directory',
    owner   => 'puppet',
    group   => 'puppet',
    require => Package['puppetserver'],
  }
  
  augeas {'puppet dns_alt_names':
    context => '/files/etc/puppet/puppet.conf', 
    changes => 'set main/dns_alt_names localhost',
    require => Package['puppet'],
  }
  
  augeas {'puppet server':
    context => '/files/etc/puppet/puppet.conf',
    changes => 'set agent/server localhost',
    require => Package['puppet'],
  }
  
  service {'puppetserver':
    ensure  => 'running',
    enable  => 'true',
    require => [Package['puppetserver'],File['/var/run/puppet'],Augeas['puppet dns_alt_names']],
  }
  
}
