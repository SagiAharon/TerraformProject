
![alt text](https://bootcamp.rhinops.io/images/terraform-intro.gif)

<details><summary>Making 2 workspaces with 1 script</summary>
<p>
   
   * I created 2 workspaces production & Staging
   * I created 2 new files: prod.tfvars & Stag.tfvars with them I define which   settings I want for any of my workspaces
   * When I want to use them I will first have to see where I am, i will use the command <terraform workspace list>
   * Now, if I want to tell Terraform what settings I want, I will use the command: <terraform apply -var-file prod.tfvars> for my production workspaces
   * 
</p>
</details>

<details><summary>Inside the script</summary>
<p>
   
   * I created lb in my two environments, production & Staging
   * I created 3 machines and added them to the LB pool
   * I added an outboundrule in both so that the lb could access the machines
   * I created in my two environments NSG that allows access from port 8080 to the VMs


</p>
</details>

<details><summary>Postgresql</summary>
<p>
   
   * Use the <sudo apt-get install postgresql-client> command for install access to the postgresql server
   * Install ssl pass with command <wget --no-check-certificate https://dl.cacerts.digicert.com/DigiCertGlobalRootCA.crt.pem>
   * I set up a Postgresql server in both environments, production & Staging
   * I added NSG to give my VMs access to the Postgresql server
   * I set require_secure_transport = false

</p>
</details>


![alt text](https://d7umqicpi7263.cloudfront.net/img/product/207dabbc-00a2-4b99-a49e-220e0b49239f/40dc4893-92c4-4f4f-9304-3f0c60e6b400.png)
