curl -o packer.zip https://releases.hashicorp.com/packer/1.6.0/packer_1.6.0_linux_amd64.zip
unzip packer.zip && sudo mv packer /usr/bin/ && rm packer.zip
packer -autocomplete-install

curl -o vault.zip https://releases.hashicorp.com/vault/1.4.2/vault_1.4.2_linux_amd64.zip
unzip vault.zip && sudo mv vault /usr/bin/ && rm vault.zip
vault -autocomplete-install

wget -O terraform.zip https://releases.hashicorp.com/terraform/0.12.26/terraform_0.12.26_linux_amd64.zip
unzip terraform.zip && sudo mv terraform /usr/bin/ && rm terraform.zip

