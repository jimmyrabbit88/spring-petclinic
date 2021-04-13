pipeline {
    agent any


    stages {
        stage("Build") {
            steps{
                bat "mvn -version"
                bat "mvn clean compile"
            }
        }
        stage("Results"){
            steps{
                junit '**/target/surefire-reports/TEST-*.xml'
                archiveArtifacts 'target/*.jar'
            }
        }
        stage("Deploy"){
            steps{
                bat "mvn package"
            }
            post{
                success {
                    archiveArtifacts 'target/*.jar'
                }
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
}
