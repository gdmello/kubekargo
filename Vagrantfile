$num_instances = 3
$instance_name_prefix = "k8s"
$etcd_instances = $num_instances
$local_release_dir = "/vagrant/temp"
$kube_master_instances = $num_instances == 1 ? $num_instances : ($num_instances - 1)
$kube_node_instances = $num_instances
host_vars = {}
$inventory='/home/gavin.dmello/new_wk_spc/kargo/inventory'


Vagrant.configure(2) do |config|
	(1..$num_instances).each do |i|
		node_id = "#{$instance_name_prefix}-0#{i}"
		config.vm.define node_id do |node|
			hostname = node_id
			node.vm.box = "ubuntu/xenial64"
			node.vm.hostname = $hostname
			node.vm.box_url = "ubuntu/xenial64"

			ip = "192.168.77.#{i+100}"
			host_vars["#{hostname}"] = {
		        "ip": ip,
		        "flannel_interface": ip,
		        "flannel_backend_type": "host-gw",
		        "local_release_dir" => $local_release_dir,
		        "download_run_once": "False",
		        "kube_network_plugin": "flannel",
		      }
			node.vm.network :private_network, ip: ip

			node.vm.provider "virtualbox" do |v|
				v.customize ["modifyvm", :id, "--memory", 1024]
      			v.customize ["modifyvm", :id, "--name", "#{hostname}"]
				v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
   				v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
			end
			if i == $num_instances
		        config.vm.provision "ansible" do |ansible|
		          ansible.playbook = "../kargo/cluster.yml"
		          if File.exist?(File.join(File.dirname($inventory), "hosts"))
		            ansible.inventory_path = $inventory
		          end
		          ansible.sudo = true
		          ansible.limit = "all"
		          ansible.host_key_checking = false
		          ansible.raw_arguments = ["--forks=#{$num_instances}"]
		          ansible.host_vars = host_vars
		          #ansible.tags = ['download']
		          ansible.groups = {
		            "etcd" => ["#{$instance_name_prefix}-0[1:#{$etcd_instances}]"],
		            "kube-master" => ["#{$instance_name_prefix}-0[1:#{$kube_master_instances}]"],
		            "kube-node" => ["#{$instance_name_prefix}-0[1:#{$kube_node_instances}]"],
		            "k8s-cluster:children" => ["kube-master", "kube-node"],
		          }
		        end
	    	end
		end
		puts i
		puts $num_instances
	end
end