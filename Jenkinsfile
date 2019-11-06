pipeline {
  environment {
    registry = "cohanitay/one2onetool-release"
    registryCredential = 'dockerhub'
    dockerImage = ''
    DATA_FILE = 'Questions.json'
  }
  agent any
  stages {
    stage('Cloning Git') {
      steps {
        git branch: 'one2onetool-release', url:'https://github.com/conghan-tay/one2onetool.git'
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
        sh 'echo $registry:$BUILD_NUMBER'
        sh 'chmod 777 ./checkRunning.sh'
        sh './checkRunning.sh'
      }
    }
  }
  post {
    always {
        emailext body: 'A Test EMail', recipientProviders: [[$class: 'DevelopersRecipientProvider'], [$class: 'RequesterRecipientProvider']], subject: 'Test'
    }
  }
}
