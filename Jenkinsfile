pipeline {
    agent any
     
    stages {
      stage('checkout') {
          steps {
                git url: 'git@git.kpd-i.com:devops/terraform-workspaces/kpdi-terraform.git'
             
          }
        }
  stage('Set Terraform path') {
            steps {
                script {
                    def tfHome = tool name: 'Terraform'
                    env.PATH = "${tfHome}:${env.PATH}"
                }
                sh 'terraform --version'
               
               
            }
        }
        
         stage('Provision infrastructure') {
             
            steps {
                sh 'terraform init'
               // sh 'terraform plan -out=plan'
                // sh 'terraform apply plan'
              
             
            }
        }
        
      
      
    }
}