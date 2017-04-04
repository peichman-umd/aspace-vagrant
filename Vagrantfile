# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "puppetlabs/centos-7.0-64-puppet"
  config.vm.box_version = "1.0.1"

  config.vm.network "private_network", ip: "192.168.40.100"

  config.vm.synced_folder "dist", "/apps/dist"

  config.vm.provider "virtualbox" do |vb|
     # Customize the amount of memory on the VM
     vb.memory = "1024"
  end

  # system packages
  config.vm.provision 'puppet'

  # firewall rules
  config.vm.provision 'shell', path: 'scripts/openports.sh', args: [8080, 8081, 8089, 8090]

  # Oracle JDK
  config.vm.provision 'shell', path: 'scripts/jdk.sh'

  # ArchivesSpace application
  config.vm.provision 'shell', path: 'scripts/aspace.sh'

  # ArchivesSpace config
  config.vm.provision 'file', source: 'files/config.rb', destination: '/apps/archivesspace-1.5.2/config/config.rb'
  # control script
  config.vm.provision 'file', source: 'files/control', destination: '/apps/aspace/aspace/control'
end
