# Week -06 #

Terraform & Ansible

## Terraform ##

### Making 2 workspaces with 1 script... ###

* I created 2 workspaces production & Staging
* I created 2 new files: prod.tfvars & Stag.tfvars with them I define which   settings I want for any of my workspaces
* When I want to use them I will first have to see where I am, i will use the command <terraform workspace list>
*  Now, if I want to get to the Terraform what settings I want, I will use the command: <terraform apply -var-file prod.tfvars> for my production workspace


### Inside the script... ###

* I created lb in my two environments, production & Staging
* I created 3 machines and added them to the LB pool
* I added an outboundrule in both so that the lb could access the machines
* I created in my two environments NSG that allows access from port 8080 to the VMs


### Postgresql ###

* I set up a Postgresql server in both environments, production & Staging
* I added NSG to give my VMs access to the Postgresql server
* I set require_secure_transport = false

## Ansible ##

### Install Ansible & Checking ###

* Install ansible with command: sudo apt install ansible
* Change to ansible dir with th command: cd /etc/ansible
* Add Ips to host file and ping to the servers with: ansible WebServers -m ping

### Set-Up the app on servers ###

* install nodejs 14 with shell command
* install npm latest with shell command
* I use playbook for Clone my repo
* I create the .env on the accessVM where i use ansible to control the VMs & copy them to remote servers
* After copy the .env file i changes the "HOST=" to the VM ips
* I created "pm2start.sh" script
* copy "pm2start.sh" script & execute on remote servers

### connect to the PostgreSQL flexible server ###

* I install on my ansible workstation postgresql-client 
* I run: npm run initdb to init my db 



