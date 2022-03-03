pipeline {
    agent any
    tools {
        maven 'Maven3'
    }
    stages{
        stage('GIT checkout') {
            steps {
                git credentialsId: 'github_cred', url: 'https://github.com/sam2500/CalTech-PG-DevOps-Final-Capstone-Project.git'
           }
       }
          stage('Build Package') {
            steps {
                sh 'mvn clean install -f CalTech-PG-DevOps-Final-Capstone-Project/pom.xml'
            }
        }
        stage('Docker build and Tag') {
            steps{
                sh 'docker build -t ${JOB_NAME}:v1.${BUILD_NUMBER} .'
                sh 'docker tag ${JOB_NAME}:v1.${BUILD_NUMBER} sam250/${JOB_NAME}:v1.${BUILD_NUMBER} '
                sh 'docker tag ${JOB_NAME}:v1.${BUILD_NUMBER} sam250/${JOB_NAME}:latest '
            }
        }
        stage('push conatiner') {
            steps{
                withCredentials([string(credentialsId: 'dockerhub', variable: 'dockerhubcred')]) {
                  sh 'docker login -u sam250 -p ${dockerhubcred}'
                  sh 'docker push sam250/${JOB_NAME}:v1.${BUILD_NUMBER}'
                  sh 'docker push sam250/${JOB_NAME}:latest'
                  sh 'docker rmi ${JOB_NAME}:v1.${BUILD_NUMBER} tmatin100/${JOB_NAME}:v1.${BUILD_NUMBER} tmatin100/${JOB_NAME}:latest'
                }      
            }
        }
        stage('Docker Deploy') {
            steps{
                ansiblePlaybook credentialsId: 'ansible-host', disableHostKeyChecking: true, installation: 'ansible', inventory: 'inventory.txt', playbook: 'deploy.yml'
            }
        }          
    }
}
