pipeline {
    agent any
    stages {
        stage("build") {
            steps{
                sh "mvn -version"
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