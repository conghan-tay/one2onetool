pipeline {
  environment {
    registry = "cohanitay/one2onetool-staging"
    registryCredential = 'dockerhub'
    dockerImage = ''
  }
  agent any
  stages {
    stage('Cloning Git') {
      steps {
        git 'https://github.com/conghan-tay/one2onetool.git'
      }
    }
    stage('Build') {
       steps {
         sh 'npm install'
       }
    }
    stage('Test') {
      steps {
        sh 'npm test'
      }
    }
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }
    stage('Deploy Image to Repo') {
      steps{
         script {
            docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
          }
        }
      }
    }
    stage('Remove Unused docker image') {
      steps{
        sh "docker rmi $registry:$BUILD_NUMBER"
        sh 'docker rm -vf $(docker ps -a -q)'
        sh 'docker rmi -f $(docker images -a -q)'
        sh 'docker run --rm -p 4000:4000 cohanitay/one2onetool-staging:$BUILD_NUMBER'
      }
    }
  }
}
