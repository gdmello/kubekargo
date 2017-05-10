run:
	ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ../kargo/inventory/vagrant_ansible_inventory -u ubuntu -b ../kargo/cluster.yml -vvvv

un:
	ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ../kargo2/inventory/vagrant_ansible_inventory -u gavin.dmello --ask-become-pass --tags "helm" -b ../kargo2/cluster.yml -vvvv
