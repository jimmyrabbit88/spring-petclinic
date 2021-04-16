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
        stage('SonarQube') {
            steps {
                withSonarQubeEnv('Sonar8.2') {
                    bat "mvn -Dsonar.qualitygate=true sonar:sonar"
                }
            }
        }
        stage("Deploy"){
            steps{
                bat "mvn clean package"
            }
            post{
                success {
                    archiveArtifacts 'target/*.jar'
                }
            }
        }
        stage("Build Docker Image"){
            steps{
                bat 'docker build -t jimmyrabbit88/pet_clinic_1:2.0.0 .'
            }
        }
        stage("Push Docker Image"){
            steps{
                withCredentials([string(credentialsId: 'docker-pwd', variable: 'dockerHubPwd')]) {
                    bat "docker login -u jimmyrabbit88 -p ${dockerHubPwd}"
                }
                bat 'docker push jimmyrabbit88/pet_clinic_1:2.0.0'

            }
        }

        stage("Deploy Container"){
            steps{
                sshagent(['aws-rem']){
                    sh "ssh -o StrictHostKeyChecking=no ec2-user@34.244.114.135 docker stop pet_clinic || true"
                    sh "ssh -o StrictHostKeyChecking=no ec2-user@34.244.114.135 docker rm pet_clinic || true"
                    sh "ssh -o StrictHostKeyChecking=no ec2-user@34.244.114.135 docker rmi \$(docker images -a -q) || true"

                    sh "ssh -o StrictHostKeyChecking=no ec2-user@34.244.114.135 docker run -p 8080:8080 -d --name pet_clinic jimmyrabbit88/pet_clinic_1:2.0.0"
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
