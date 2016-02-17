# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus = 2
     v.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
  end

  #ssh configuration
  config.ssh.username = "vagrant"
  config.ssh.password = "vagrant"

  if !ENV['STANDALONE']
    if Vagrant.has_plugin?('vagrant-proxyconf')
      config.proxy.http = "http://buildproxy.nibdom.com.au:3128/"
      config.proxy.https = "http://buildproxy.nibdom.com.au:3128/"
      config.proxy.no_proxy = '"localhost, 127.0.0.*, 10.*, 192.168.*"'
    else
      puts "vagrant-proxyconf missing, please install the vagrant-proxyconf plugin!"
      puts "Run this command in your terminal:"
      puts "vagrant plugin install vagrant-proxyconf"
      exit 1
    end
  else
    if Vagrant.has_plugin?('vagrant-proxyconf')
      config.proxy.http = ""
      config.proxy.https = ""
      config.proxy.no_proxy = '"*"'
    end
  end

  config.vm.provision :shell, privileged: false,  :path => "docker_install.sh"

end
