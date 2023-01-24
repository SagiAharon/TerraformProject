
![alt text](https://uploads-ssl.webflow.com/5c9200c49b1194323aff7304/61a4b85516bbd04f7b7fa891_Learn_Terra-570x330.png)

***Staging & Production environments***
 <details><summary>For this Terraform project I created two development environments</summary>
<p>
   
   To creating __staging__ workspace
   ```
   terraform workspace new Staging
   ```
   To creating __production__ workspace
   ```
   terraform workspace new Production
   ```
   After the creation of the two environments we need to use command to see on what workspace we currently are. the command is:
   
   ```
   terraform workspace list
   ```

</p>
</details>
   
   
   * I added a variable document that defines my need in each environment calls Prod.tfvars & Stag.tfvars


   * Now, if I want to tell Terraform what settings I want, I will use the command: <terraform apply -var-file prod.tfvars> for my production workspaces

   
   * I created lb in my two environments, production & Staging
   * I created 3 machines and added them to the LB pool
   * I added an outboundrule in both so that the lb could access the machines
   * I created in my two environments NSG that allows access from port 8080 to the VMs


   
   * Use the <sudo apt-get install postgresql-client> command for install access to the postgresql server
   * Install ssl pass with command <wget --no-check-certificate https://dl.cacerts.digicert.com/DigiCertGlobalRootCA.crt.pem>
   * I set up a Postgresql server in both environments, production & Staging
   * I added NSG to give my VMs access to the Postgresql server
   * I set require_secure_transport = false

