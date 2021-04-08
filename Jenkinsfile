pipeline {
    agent any

    stages {
        // def mnvHome
        // stage('prepare'){
        //     mvnHome = tool 'apache-maven-3.6.3'
        }
        stage("build") {
            steps{
                sh "mvn -version"
                sh "mvn clean install"
            }
            // withEnv(["MVN_HOME=$mvnHome"]) {
            //     if (isUnix()) {
            //         sh '"$MVN_HOME/bin/mvn" -Dmaven.test.failure.ignore clean package'
            //     }
            //     else {
            //         bat(/"%MVN_HOME%\bin\mvn" -Dmaven.test.failure.ignore clean package/)
            //     }
            // }
        }
        // stage('Results') {
        //     junit '**/target/surefire-reports/TEST-*.xml'
        //     archiveArtifacts 'target/*.jar'
	    // }
    }

    post {
        always {
            cleanWs()
        }
    }
}