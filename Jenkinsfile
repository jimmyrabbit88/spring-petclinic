pipeline {
    agent any
    stages {
        stage("Compile") {
            steps{
                bat "mvn -version"
                bat "mvn clean compile"
            }
        }
        stage("Tests"){
            parallel {
                stage('junit'){
                    steps{
                        bat 'mvn test'
                    }
                    post{
                        always{
                            junit '**/target/surefire-reports/TEST-*.xml'
                        }
                    }
                }
                stage('sonar'){
                    steps {
                        withSonarQubeEnv('Sonar8.2') {
                            bat "mvn -Dsonar.qualitygate=true sonar:sonar"
                        }
                    }
                }
            }
        }

        stage("Build Artifact"){
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
                    sh "ssh -o StrictHostKeyChecking=no ec2-user@3.249.231.178 docker stop pet_clinic || true"
                    sh "ssh -o StrictHostKeyChecking=no ec2-user@3.249.231.178 docker rm pet_clinic || true"
                    sh "ssh -o StrictHostKeyChecking=no ec2-user@3.249.231.178 docker rmi \$(docker images -a -q) || true"

                    sh "ssh -o StrictHostKeyChecking=no ec2-user@3.249.231.178 docker run -p 8080:8080 -d --name pet_clinic jimmyrabbit88/pet_clinic_1:2.0.0"
                }
            }
        }
        stage('Email Build Status'){
            steps{
                emailext to: 'jasondowling88@gmail.com', body: "${currentBuild.currentResult}: Job ${env.JOB_NAME} build ${env.BUILD_NUMBER} More info at: ${env.BUILD_URL}", subject: "Jenkins Build ${currentBuild.currentResult}: Job ${env.JOB_NAME}"
            }
        }

    }
    post {
        always {
            cleanWs()
        }
    }
}
