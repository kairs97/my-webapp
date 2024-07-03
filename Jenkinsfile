pipeline {
    agent any

    environment {
        TOMCAT_SERVER = '192.168.56.102'
    }

    stages {
        stage('Build') {
            steps {
                echo 'Building with Maven...'
                sh 'mvn clean package'
                archiveArtifacts artifacts: '**/target/*.war', fingerprint: true
            }
        }
        stage('Deploy') {
            when {
                expression {
                    currentBuild.result == null || currentBuild.result == 'SUCCESS'
                }
            }
            steps {
                echo 'Deploying to Tomcat...'
                deployWarEarToContainer container: 'Tomcat Server'
                war: '**/target/hello-world.war'
            }
        }
    }

    post {
        always {
            fingerprintArtifacts
            archiveArtifacts artifacts: '**/target/hello-world.war'
        }  
        success {
            echo 'Pipeline succeeded!'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}