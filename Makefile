run:
	ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ../kargo/inventory/vagrant_ansible_inventory -u ubuntu -b ../kargo/cluster.yml -vvvv
