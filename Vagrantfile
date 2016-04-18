VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |fitnesse_config|

    fitnesse_config.vm.box = "puppetlabs/ubuntu-14.04-64-puppet"

    fitnesse_config.vm.provider :virtualbox do |vb|
        vb.customize [
                "modifyvm", :id,
                "--memory", "2048"
               ]
        vb.customize ["modifyvm", :id, "--cpus", "2"]
        vb.customize ["modifyvm", :id, "--vram", "32"]
    end

    fitnesse_config.vm.network "private_network", ip: "192.168.10.10"
    
    # Enable the Puppet provisioner
    fitnesse_config.vm.provision :puppet, run: "always" do |puppet|
      puppet.environment_path = "environment"
      puppet.environment = "production"
    end

end
