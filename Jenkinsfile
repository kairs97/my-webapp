pipeline {
    agent any

    triggers {
        pollSCM('* * * * *')
    }

    environment {
        TOMCAT_SERVER = '192.168.56.102'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                url: 'https://github.com/kairs97/my-webapp'
            }
        }
        stage('Build') {
            steps {
                echo 'Building with Maven...'
                sh 'mvn clean package -Dmaven.test.skip=true'
                archiveArtifacts artifacts: '**/target/*.war', fingerprint: true
            }
        }
        stage('Test') {
            steps {
                echo 'Testing with Maven...'
                sh 'mvn test'
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
                deploy adapters: [
                    tomcat9(
                        credentialsId: 'tomcat-manager',
                        path: '',
                        url: 'http://192.168.56.102:8080'
                        )
                    ],
                contextPath: null, 
                war: 'target/hello-world.war'
            }
        }
    }

    post {
        always {
            fingerprintArtifacts,
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