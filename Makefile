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