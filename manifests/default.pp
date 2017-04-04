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
