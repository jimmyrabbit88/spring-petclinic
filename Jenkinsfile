pipeline {
    agent {
        docker {
            image "maven:3.6.3-jdk-13"
            label "docker"
        }
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
