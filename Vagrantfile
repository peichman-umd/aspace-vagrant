# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.define 'solr' do |solr|
    solr.vm.box = 'aspace_solr'
    solr.vm.box_url = "file://dist/solr.box"

    solr.vm.hostname = 'aspacesolrlocal'
    solr.vm.network "private_network", ip: "192.168.40.101"
    solr.vm.synced_folder "dist", "/apps/dist"
    solr.vm.synced_folder '/apps/git/archivesspace-core', '/apps/git/archivesspace-core'

    # start Solr (without SSL)
    solr.vm.provision "shell", privileged: false, inline: <<-SHELL
      /apps/solr/scripts/core.sh /apps/git/archivesspace-core archivesspace
      cd /apps/solr/solr && ./control startnossl
    SHELL
  end

  config.vm.define 'aspace' do |aspace|
    aspace.vm.box = "puppetlabs/centos-7.0-64-puppet"
    aspace.vm.box_version = "1.0.1"

    aspace.vm.hostname = 'aspacelocal'
    aspace.vm.network "private_network", ip: "192.168.40.100"

    aspace.vm.synced_folder "dist", "/apps/dist"

    aspace.vm.provider "virtualbox" do |vb|
      # Customize the amount of memory on the VM
      vb.memory = "1024"
    end

    aspace.vm.provision 'shell', inline: 'puppet module install puppetlabs-mysql'

    # system packages
    aspace.vm.provision 'puppet', manifest_file: 'aspace.pp'

    # firewall rules
    aspace.vm.provision 'shell', path: 'scripts/openports.sh', args: [8080, 8081, 8089, 8090]

    # Oracle JDK
    aspace.vm.provision 'shell', path: 'scripts/jdk.sh'

    # ArchivesSpace application
    aspace.vm.provision 'shell', path: 'scripts/aspace.sh'

    # ArchivesSpace config
    aspace.vm.provision 'file', source: 'files/config.rb', destination: '/apps/archivesspace-1.5.2/config/config.rb'
    # Update startup script to write PIDFILE to a configurable location
    # TODO: this should be fixed upstream; see https://issues.umd.edu/browse/LIBASPACE-52
    aspace.vm.provision 'file', source: 'files/archivesspace.sh', destination: '/apps/archivesspace-1.5.2/archivesspace.sh'
    # control script
    aspace.vm.provision 'file', source: 'files/control', destination: '/apps/aspace/aspace/control'

    # set up MySQL database
    aspace.vm.provision 'shell', path: 'scripts/database.sh'

    # start the service
    aspace.vm.provision 'shell', inline: 'cd /apps/aspace/aspace && ./control start', privileged: false
  end
end
