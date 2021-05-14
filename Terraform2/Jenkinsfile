pipeline {
    agent any
    stages {
        stage('Terraform init') {
            environment {
            AWS_ACCESS_KEYS = credentials('aws_cred')
            }
            steps {
                sh 'terraform init'   
            }        
        }
        stage('Terraform plan') {
            environment {
            AWS_ACCESS_KEYS = credentials('aws_cred')
            }
            steps {
                sh 'terraform apply --auto-approve'
                sh 'ls -la'   
            }   
        }
    }
}
