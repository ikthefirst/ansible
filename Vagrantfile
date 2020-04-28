# -*- mode: ruby -*-
# vi: set ft=ruby :

# Pre-requisite:
# SSH keypair generated using ssh-keygen.

# The 'rsync' method is used for synced folders. (ansible project folders)
# This means that after changes within those folders on the host, a folder sync has to be triggered:
# vagrant rsync

# After the provisioning finishes, login to 'control' node:
# vagrant ssh control

# Check if ansible is properly installed:
# ansible --version

# Before start using ansible, add the private key to the keyring. 
# This is needed to be able to ssh to the other nodes from the control node.
# eval $(ssh-agent -s)
# ssh-add ~/.ssh/vagrant

# Test ansible by pinging the other nodes
# cd /ansible/ad-hoc
# ansible -m ping all

VAGRANTFILE_API_VERSION = "2"
SSH_PRIVATE_KEY_PATH = "c:/Data/dev/_keys/vagrant2"
SSH_PUBLIC_KEY_PATH = "c:/Data/dev/_keys/vagrant2.pub"

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
		control.vm.provision :shell, name: "private-key-privileges", privileged: false, path: "vagrantscripts/private-key.sh"
		
		# Install Ansible
		control.vm.provision :shell, name: "install-python3", path: "vagrantscripts/python3.sh"
		control.vm.provision :shell, name: "install-ansible", path: "vagrantscripts/ansible.sh"
		
		# Add synced folders for ansible projects
		control.vm.synced_folder "ad-hoc", "/ansible/ad-hoc", type: "rsync"

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

