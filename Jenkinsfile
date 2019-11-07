pipeline {
  environment {
    registry = "cohanitay/one2onetool-staging"
    registryCredential = 'dockerhub'
    dockerImage = ''
    DATA_FILE = 'Questions-test.json'
  }
  agent any
  stages {
    stage('Cloning Git') {
      steps {
        git branch: 'one2onetool-staging', url:'https://github.com/conghan-tay/one2onetool.git'
      }
    }
    stage('Build') {
       steps {
         sh "cp ./data/Questions-test.json ./data/Questions.json"
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
        sh 'echo $registry:$BUILD_NUMBER'
        sh 'chmod 777 ./checkRunning.sh'
        sh './checkRunning.sh'
      }
    }
  }
  post {
    failure {
        sh 'echo $registry:$BUILD_NUMBER FAILED | mail -s "FINISH BUILD STAGING" cohanitay@gmail.com '
    }
  }
}
