pipeline {
    environment {
        AWS_ACCESS_KEY_ID     = credentials('jenkins-aws-secret-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('jenkins-aws-secret-access-key')
    }
    agent any
    stages {
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
    }
}
