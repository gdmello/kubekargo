Vagrant.configure(2) do |config|
	(1..3).each do |i|
		node_id = "node_vm#{i}"
		config.vm.define node_id do |node|
			node.vm.box = "precise64"
			node.vm.hostname = "nodevm#{i}"
			node.vm.box_url = "ubuntu/precise64"

			node.vm.network :private_network, ip: "192.168.77.1#{i}"

			node.vm.provider "virtualbox" do |v|
				v.customize ["modifyvm", :id, "--memory", 1024]
      			v.customize ["modifyvm", :id, "--name", "node_vm#{i}"]
				v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
   				v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
			end
		end
	end
end