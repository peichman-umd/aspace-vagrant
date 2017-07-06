# -*- mode: ruby -*-
# vi: set ft=ruby :

git_username = `git config user.name`.chomp
git_email = `git config user.email`.chomp

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
    aspace.vm.box = "puppetlabs/centos-6.6-64-puppet"
    aspace.vm.box_version = "1.0.1"

    aspace.vm.hostname = 'aspacelocal'
    aspace.vm.network "private_network", ip: "192.168.40.100"
    aspace.vm.network "private_network", ip: "192.168.40.102"

    aspace.vm.synced_folder "dist", "/apps/dist"
    aspace.vm.synced_folder "/apps/git/aspace-env", "/apps/git/aspace-env"

    aspace.vm.provider "virtualbox" do |vb|
      # Customize the amount of memory on the VM
      vb.memory = "1280"
    end

    aspace.vm.provision 'shell', inline: 'puppet module install puppetlabs-firewall'

    # system packages
    aspace.vm.provision 'puppet', manifest_file: 'aspace.pp'

    # configure Git
    aspace.vm.provision 'shell', path: 'scripts/git.sh', args: [git_username, git_email], privileged: false
    # install runtime env
    aspace.vm.provision "shell", path: "scripts/env.sh"

    # Oracle JDK
    aspace.vm.provision 'shell', path: 'scripts/jdk.sh'

    # ArchivesSpace application
    aspace.vm.provision 'shell', path: 'scripts/aspace.sh'

    # server-specific values
    aspace.vm.provision 'file', source: 'files/env', destination: '/apps/aspace/config/env'

    # Apache runtime setup
    aspace.vm.provision 'shell', path: 'scripts/apache.sh'
    # HTTPS certificates for Apache
    aspace.vm.provision 'shell', path: 'scripts/https-cert.sh', args: %w(aspacelocal 192.168.40.100)
    aspace.vm.provision 'shell', path: 'scripts/https-cert.sh', args: %w(archiveslocal 192.168.40.102)

    # configure MySQL service
    aspace.vm.provision 'shell', path: 'scripts/mysql.sh'
    # install JDBC driver and setup database
    aspace.vm.provision 'shell', path: 'scripts/database.sh', privileged: false
    
    # install plugins 
    aspace.vm.provision 'shell', inline: '/apps/aspace/scripts/plugins.sh', privileged: false
    
    # tweak the archivesspace.sh script 
    aspace.vm.provision 'shell', inline: '/apps/aspace/scripts/append_log.sh', privileged: false
    # add log rotate configuration 
    aspace.vm.provision 'shell' do |s|
      s.inline = 'cp /apps/git/aspace-env/config/etc/logrotate.d/aspace /etc/logrotate.d/aspace'
      s.privileged = true
    end

    # start the service
    aspace.vm.provision 'shell', inline: 'cd /apps/aspace && ./control start', privileged: false
  end
end
