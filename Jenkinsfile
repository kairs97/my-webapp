pipeline {
    agent any
    stages {
        stage('Hello') {
            steps {
                echo 'Hello World'
            }
        }
        stage('print "now"') {
	        steps {
	            echo "The date is ${new Date().format('yyyy-MM-dd HH:mm:ss')}"
	        }   
        }
    }
    post {
        always {
            echo 'I will always say Hello again!'
        }
    }
}