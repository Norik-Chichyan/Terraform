pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID     = credentials('jenkins-aws-secret-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('jenkins-aws-secret-access-key')
    stages {
        stage('Pull sources') {
            steps {
                    git branch: 'main', credentialsId: 'user_pass_github', url: 'https://github.com/Norik-Chichyan/Azure'
            }
        }
    }    
}
