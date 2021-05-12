pipeline {
    agent any

    stages {
        stage('Pull sources') {
            steps {
                    git branch: 'main', credentialsId: 'user_pass_github', url: 'https://github.com/Norik-Chichyan/Azure'
            }
        }
    }    
}
