# -*- mode: ruby -*-
# vi: set ft=ruby :

# Pre-requisite:
# SSH keypair generated using ssh-keygen.

# After provision: test the 'control' node:
# vagrant ssh control
# python --version
# pyhon3 --version
# ansible --version

VAGRANTFILE_API_VERSION = "2"
SSH_PRIVATE_KEY_PATH = "c:/Data/dev/_keys/vagrant"
SSH_PUBLIC_KEY_PATH = "c:/Data/dev/_keys/vagrant.pub"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
	config.vm.box = "geerlingguy/centos7"

	config.vm.provider :virtualbox do |vbox|
		vbox.cpus = 1
		vbox.memory = 1024
		vbox.linked_clone = true
	end

	# Inject SSH public keys
	config.ssh.insert_key = true

	config.vm.provision "copy-ssh-public-key", type: "file", source: SSH_PUBLIC_KEY_PATH, destination: "~/.ssh/vagrant.pub"
	config.vm.provision "attach-ssh-key", type: "shell", privileged: false, inline: <<-SHELL
		cat ~/.ssh/vagrant.pub >> ~/.ssh/authorized_keys
	SHELL

	# Control Node
	config.vm.define "control" do |control|
		control.vm.hostname = "control.test"
		control.vm.network :private_network, ip: "192.168.100.100"

		# Inject SSH private  key
		control.vm.provision "copy-ssh-private-key", type: "file", source: SSH_PRIVATE_KEY_PATH, destination: "~/.ssh/vagrant"
		
		# Install Ansible
		control.vm.provision :shell, name: "install-python3", path: "vagrantscripts/python3.sh"
		control.vm.provision :shell, name: "install-ansible", path: "vagrantscripts/ansible.sh"
	end

	# Node#1
	config.vm.define "node1" do |node|
		node.vm.hostname = "node1.test"
		node.vm.network :private_network, ip: "192.168.100.101"
	end

	# Node#2
	config.vm.define "node2" do |node|
		node.vm.hostname = "node2.test"
		node.vm.network :private_network, ip: "192.168.100.102"
	end

	# Node#3
	config.vm.define "node3" do |node|
		node.vm.hostname = "node3.test"
		node.vm.network :private_network, ip: "192.168.100.103"
	end

	# Node#4
	config.vm.define "node4" do |node|
		node.vm.hostname = "node4.test"
		node.vm.network :private_network, ip: "192.168.100.104"
	end

end

