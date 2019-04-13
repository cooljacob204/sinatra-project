pipeline {
  agent {
    node {
      label 'master'
    }

  }
  stages {
    stage('Checkout Code') {
      steps {
        checkout scm
      }
    }
    stage('build') {
      steps {
        sh 'docker build -t cooljacob204/videogame-tracker:${env.BUILD_ID} .'
      }
    }
    stage('Deploy Dockerhub') {
      steps {
        sh 'docker push cooljacob204/videogame-tracker:${env.BUILD_ID}'
      }
    }
  }
}