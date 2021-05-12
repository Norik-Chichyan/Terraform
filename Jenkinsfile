pipeline {
    environment {
        AWS_ACCESS_KEY_ID     = credentials('jenkins-aws-secret-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('jenkins-aws-secret-access-key')
    }
    agent any
    stage('Terraform init') {
       steps {
          sh 'terraform init'
       }
    }
    stage('Terraform plan') {
       steps {
          sh 'terraform plan'
       }
    }       
#    stages {
#       stage('Pull sources') {
#            steps {
#                    git branch: 'main', credentialsId: 'user_pass_github', url: 'https://github.com/Norik-Chichyan/Azure'
#            }  
 #       }
        
}
