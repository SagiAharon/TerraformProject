# Week -07 #

![alt text](https://congdonglinux.com/how-to-create-a-terraform-module/)

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



