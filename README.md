# Jenkins-AWS-terraform
This repository is for a POC of Jenkins into EC2 instance on AWS, using terraform, template file init and Ansible.

# Terraform
Install Terraform, need version 0.12 or superior.
* Over CentOS7:
```
sudo yum update && sudo yum install wget unzip -y
export VERSION=0.12.25
sudo wget https://releases.hashicorp.com/terraform/${VERSION}/terraform_${VERSION}_linux_amd64.zip -P /tmp
sudo unzip /tmp/terraform_${VERSION}_linux_amd64.zip -d /usr/local/bin/
```

* Over Mac:
```
brew install terraform
```

* Over Ubuntu:
```
sudo apt-get update && sudo apt-get install wget unzip -y
export VERSION=0.12.25
sudo wget https://releases.hashicorp.com/terraform/${VERSION}/terraform_${VERSION}_linux_amd64.zip -P /tmp
sudo unzip /tmp/terraform_${VERSION}_linux_amd64.zip -d /usr/local/bin/
```

* Setup with terraform cli:
```
terraform init && terraform plan
terraform apply -auto-approve
```

# Ansible
Install Ansible

* Over CentOS7:
```
sudo yum install -y epel-release && sudo yum install -y ansible
```

* Over Mac:
```
brew install ansible
```

* Over Ubuntu:
```
sudo apt-get update && sudo apt-get install ansible -y
```

### Once terraform apply was run, send next command for install apache to remote server using Ansible.
* Depending of your AWS AMI will be the user.
* Change the host in the setup.yaml and file hosts
* Change in install_apache.sh bash script the new ServerName
```
ansible-playbook setup.yml --user=ec2-user -i hosts
```

## Important Notes:
* You must create a ssh key pair using ssh ssh-keygen look at the variable "ssh_key" into variables.tf
* This is a POC, try to use a pipeline and service account for the credentials, or use git-crypt.
