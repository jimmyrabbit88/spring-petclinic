pipeline {
    agent any
    stages {
        stage("build") {
            steps{
                bat "mvn -version"
                //sh "mvn clean package/"
            }
        }  
    }
    post {
        always {
            cleanWs()
        }
    }
}