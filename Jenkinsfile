pipeline {
    agent any
    stages {
        stage("Build") {
            steps{
                bat "mvn -version"
                bat "mvn clean package"
            }
        }
        stage("Results"){
            junit '**/target/surefire-reports/TEST-*.xml'
            archiveArtifacts 'target/*.jar'
        } 
    }
    post {
        always {
            cleanWs()
        }
    }
}