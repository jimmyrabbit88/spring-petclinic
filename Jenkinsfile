pipeline {
    agent any


    stages {
        stage("Build") {
            steps{
                bat "mvn -version"
                bat "mvn clean package"
            }
        }
        stage("Test"){
            steps{
                bat 'mvn test'
            }
            post{
                always{
                    junit '**/target/surefire-reports/TEST-*.xml'
                }
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
