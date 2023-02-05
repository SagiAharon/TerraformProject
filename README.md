
![alt text](https://uploads-ssl.webflow.com/5c9200c49b1194323aff7304/61a4b85516bbd04f7b7fa891_Learn_Terra-570x330.png)

***Staging & Production environments***

**--- All environments are spread over the Azure cloud ---**
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
   After the creation of the two environments i need to use command to see on what workspace we currently are. the command is:
   
   ```
   terraform workspace list
   ```
   
   To select the workspace you need
   
   ```
   terraform workspace select production/staging
   ```

</p>
</details>
   
 ***Next...***
 
 * I added two variable documents that defines my need in each environment calls Prod.tfvars & Stag.tfvars
 
 **The next diagram describes the next steps**
 But first... what the is the product?
 
 **--- The product that is spread over the environments is an application that measures weight and calculates bmi. ---**
 
 ![azure terraform project drawio](https://user-images.githubusercontent.com/47359629/216842242-73133687-f4ce-4e0c-a708-a26d66513e96.png)

What we see?... 

* For each environment as described above I opened a virtual network with two subnets, to each subnet I attached an NSG that contains different rules, for the first subnet that includes the servers has access privileges for outside traffic.

* Within this subnet there are 3 virtual machines, which are under Load balancer which distributes the traffic equally between the three machines.

* In the second subnet there is an NSG that gives permissions only to machines to access it, in the same subnet there is a managed Postgres server. from which information is extracted and stored.                                                      
(Relatively expensive service but helps in certain cases)

   
<details><summary>For practical reasons... </summary>
<p>

   * To use the transform to lay out the entire environment according to the variables document, you need to use the command:
   ```
   terraform apply -var-file prod.tfvars/ stag.tfvars
   ```
   
   (it's important to note which workspace we are currently working on!)


   To access the postgresql server we neet to use the command: 
   
   ```
   sudo apt-get install postgresql-client
   ```
   
   In addition also we need to Install ssl pass with command:
   
   ```
   wget --no-check-certificate https://dl.cacerts.digicert.com/DigiCertGlobalRootCA.crt.pem
   ```
   
   * I set require_secure_transport = false just for this project
   
   
  

