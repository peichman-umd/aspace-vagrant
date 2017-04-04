include '::mysql::server'

mysql::db { 'archivesspace':
  user     => 'as',
  password => 'as',
}

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
