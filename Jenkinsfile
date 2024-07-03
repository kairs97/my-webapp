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
                withCredentials([usernamePassword(credentialsId: 'tomcat-manager', usernameVariable: 'TOMCAT_USER', passwordVariable: 'TOMCAT_PASSWORD')]) {
                    script {
                        sh """
                            curl --upload-file target/*.war "http://${TOMCAT_USER}:${TOMCAT_PASSWORD}@${TOMCAT_SERVER}:8080/manager/text/deploy?path=/yourapp&update=true"
                        """
                    }
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline succeeded!'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}