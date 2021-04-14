pipeline {
    agent any


    stages {
        stage("Build") {
            steps{
                sh "mvn -version"
                sh "mvn clean package"
            }
        }
        stage("Test"){
            steps{
                sh 'mvn test'
            }
            post{
                always{
                    junit '**/target/surefire-reports/TEST-*.xml'
                }
            }
        }
        stage("Deploy"){
            steps{
                sh "mvn package"
            }
            post{
                success {
                    archiveArtifacts 'target/*.jar'
                }
            }
        }
        stage("Build Docker Image"){
            steps{
                sh 'docker build -t jimmyrabbit88/pet_clinic_1:2.0.0 .'
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
}
