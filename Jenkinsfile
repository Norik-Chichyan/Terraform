pipeline {
    agent any

    stages {
        stage('Pull sources') {
            steps {
                    git branch: 'main', credentialsId: 'user_pass_github', url: 'https://github.com/Norik-Chichyan/Azure'
            }
        }
        stage('Bulid Artifact') {
            steps {
                    nexusArtifactUploader artifacts: [[artifactId: 'Azure', classifier: '', file: 'Azure.zip', type: 'zip']], credentialsId: 'nexus_login', groupId: 'Azure-project', nexusUrl: '192.168.1.11:8080', nexusVersion: 'nexus3', protocol: 'http', repository: 'Azure_project', version: '1.$BUILD_NUMBER'
            }
        }    
        
    }
}
