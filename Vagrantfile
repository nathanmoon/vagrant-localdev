# encoding: utf-8
# -*- mode: ruby -*-
# vi: set ft=ruby :

# Box / OS
VAGRANT_BOX = 'bento/ubuntu-16.04'

# Memorable name for your
VM_NAME = 'localdev2'

# Host folder to sync
HOST_PATH = File.dirname(__FILE__)

# Where to sync to on Guest — 'vagrant' is the default user name
GUEST_PATH = '/home/vagrant/localdev'

# # VM Port — uncomment this to use NAT instead of DHCP
# VM_PORT = 8080

Vagrant.configure(2) do |config|

  # Vagrant box from Hashicorp
  config.vm.box = VAGRANT_BOX
  
  # Actual machine name
  config.vm.hostname = VM_NAME

  # Set VM name in Virtualbox
  config.vm.provider "virtualbox" do |v|
    v.name = VM_NAME
    v.memory = 2048
    v.cpus = 2
  end

  #DHCP — comment this out if planning on using NAT instead
  config.vm.network "private_network", type: "dhcp"

  # # Port forwarding — uncomment this to use NAT instead of DHCP
  # config.vm.network "forwarded_port", guest: 80, host: VM_PORT

  # This is for firebase login, which uses the browser to authenticate
  # config.vm.network "forwarded_port", guest: 9005, host: 9005

  # Disable default Vagrant folder, use a unique path per project
  config.vm.synced_folder '.', '/home/vagrant', disabled: true

  # Sync folder
  config.vm.synced_folder HOST_PATH, GUEST_PATH

  # Bootstrap
  config.vm.provision "shell", privileged: false, inline: <<-SHELL
    cd /home/vagrant/localdev && sh setup.sh
  SHELL

  # forward agent
  config.ssh.forward_agent = true

  # copy ssh keys
  config.vm.provision "file", source: "~/.ssh/id_rsa", destination: "/home/vagrant/.ssh/id_rsa"
  config.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "/home/vagrant/.ssh/id_rsa.pub"

end
