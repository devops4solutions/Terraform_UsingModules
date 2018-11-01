Structure of code -
1. Modules folder - contain the code which is common for all the environment. 
         - IAM
		 - Network
		 - Compute
2. dev/stage folder - Update the variable file as per your environment


How to Run
1. Run Jenkins Job - Terraform

Destroy your Infrastruture
1. Run Jenkins Job - Terraform_Destroy

Run Initial Ansible PlayBook
1. Update ssh.cfg file with the IP address /dev/ansible/ssh.cfg file
2. Update ssh.cfg file on Jenkins server of jenkins user . 

