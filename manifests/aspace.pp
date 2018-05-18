Package {
  allow_virtual => false,
}

package { "lsof":
  ensure => present,
}
package { "tree":
  ensure => present,
}
package { "vim-enhanced":
  ensure => present,
}
package { "unzip":
  ensure => present,
}
package { 'git':
  ensure => present,
}
package { 'httpd':
  ensure => present,
}
package { 'mod_ssl':
  ensure  => present,
  require => Package['httpd'],
}

include 'docker'
class { 'docker::compose':
  ensure => present,
}

firewall { '100 allow http and https access':
  dport  => [80, 443],
  proto  => tcp,
  action => accept,
}
