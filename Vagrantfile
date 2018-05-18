# -*- mode: ruby -*-
# vi: set ft=ruby :

git_username = `git config user.name`.chomp
git_email = `git config user.email`.chomp

copy_dont_git = true 
base_directory='/home/chrisfitzpatrick/Code/umd/' 

Vagrant.configure("2") do |config|

  config.vm.define 'solr' do |solr|
    solr.vm.box = 'aspace_solr'
    solr.vm.box_url = "file://dist/solr.box"

    solr.vm.hostname = 'aspacesolrlocal'
    solr.vm.network "private_network", ip: "192.168.40.101"
    solr.vm.synced_folder "dist", "/apps/dist"
    solr.vm.synced_folder "#{base_directory}/archivesspace-core", '/apps/git/archivesspace-core'

    # start Solr (without SSL)
    solr.vm.provision "shell", privileged: false, inline: <<-SHELL
       /apps/solr/scripts/core.sh /apps/git/archivesspace-core archivesspace
       cd /apps/solr/solr && ./control startnossl
     SHELL
  end

  config.vm.define 'aspace' do |aspace|
    aspace.vm.box = "puppetlabs/centos-7.2-64-puppet" 
    aspace.vm.box_version = "1.0.1"

    aspace.vm.hostname = 'aspacelocal'
    aspace.vm.network "private_network", ip: "192.168.40.100"
    aspace.vm.network "private_network", ip: "192.168.40.102"

    aspace.vm.synced_folder "dist", "/apps/dist"
    aspace.vm.synced_folder "#{base_directory}/aspace-env", "/apps/git/aspace-env"

    aspace.vm.provider "virtualbox" do |vb|
      # Customize the amount of memory on the VM
      vb.memory = "1280"
    end

    aspace.vm.provision 'shell', path: 'scripts/fix_puppet_gpg.sh'
    aspace.vm.provision 'shell', inline: 'yum update -y'
    aspace.vm.provision "shell", inline: <<-SHELL
      puppet module install puppetlabs-firewall --version 1.10.0
      puppet module install puppetlabs-docker 
    SHELL

    # system packages
    aspace.vm.provision 'puppet', manifest_file: 'aspace.pp'

    # configure Git
    aspace.vm.provision 'shell', path: 'scripts/git.sh', args: [git_username, git_email], privileged: false
    # install runtime env
    if copy_dont_git
      aspace.vm.provision "shell", path: "scripts/env_no_git.sh"
    else
      aspace.vm.provision "shell", path: "scripts/env.sh"
    end

    aspace.vm.provision 'shell', inline: <<-SHELL
      cp /apps/aspace/docker-compose-vagrant.yml /apps/aspace/docker-compose.yml
    SHELL

    # HTTPS certificates for Apache
    aspace.vm.provision 'shell', path: 'scripts/https-cert.sh', args: %w(aspacelocal 192.168.40.100)
    aspace.vm.provision 'shell', path: 'scripts/https-cert.sh', args: %w(archiveslocal 192.168.40.102)
    aspace.vm.provision 'shell', inline: <<-SHELL
      openssl dhparam -out /apps/aspace/ssl/dhparam.pem 2048
    SHELL

    # start the service
    aspace.vm.provision 'shell', inline: 'cd /apps/aspace && ./control start'
  end
end
