make setup:
	make -C terraform setup

validate:
	make -C terraform validate

plan:
	make -C terraform plan

apply:
	make -C terraform apply

destroy:
	make -C terraform destroy

list:
	ansible-inventory -i ./ansible/inventory.ini --list

ping:
	ansible-playbook -i ./ansible/inventory.ini ./ansible/playbook.yml --tags ping

playbook:
	ansible-playbook -i ./ansible/inventory.ini ./ansible/playbook.yml