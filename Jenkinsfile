pipeline {
    agent any

    tools {
        maven "apache-maven-3.6.3"
    }
    stages {
        stage("Build") {
            steps{
                bat "mvn -version"
                bat "mvn clean package"
            }
        }
        stage("Results"){
            steps{
                junit '**/target/surefire-reports/TEST-*.xml'
                archiveArtifacts 'target/*.jar'
            }
        } 
    }
    post {
        always {
            cleanWs()
        }
    }
}
