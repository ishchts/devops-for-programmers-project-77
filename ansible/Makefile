setup:
	make install
	touch vault-password

install:
	ansible-galaxy collection install -r requirements.yml
	ansible-galaxy role install -r requirements.yml

vault-view-file:
	ansible-vault view --vault-password-file vault-password $(FILE)

vault-encrypt-file:
	ansible-vault encrypt --vault-password-file vault-password $(FILE)

vault-decrypt-file:
	ansible-vault decrypt --vault-password-file vault-password $(FILE)

play-prepare-infrastructure:
	ansible-playbook playbook.yml -i production.ini -vv --vault-password-file=vault-password -t setup

play-generate-terraform-vars:
	ansible-playbook playbook.yml -i production.ini -vv --vault-password-file=vault-password -t terraform

play-deploy:
	ansible-playbook playbook.yml -i production.ini -vv --vault-password-file=vault-password -t deploy
