pipeline {
    agent any
    stages {
        stage("build") {
            steps{
                bat "mvn -version"
                bat "mvn clean package/"
            }
        }  
    }
    post {
        always {
            cleanWs()
        }
    }
}