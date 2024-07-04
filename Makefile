make setup:
	make -C terraform setup
	make -C ansible setup

ansible-generate-terraform-vars:
	make -C ansible play-generate-terraform-vars

terraform-plan:
	make -C terraform plan

terraform-apply:
	make -C terraform apply

terraform-destroy:
	make -C terraform destroy

ansible-prepare-infrastructure:
	make -C ansible play-prepare-infrastructure

ansible-deploy:
	make -C ansible play-deploy

create-infrastructure: ansible-generate-terraform-vars terraform-apply

destroy-infrastructure: ansible-generate-terraform-vars terraform-destroy
