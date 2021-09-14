pipeline {
  agent any
  stages {
    stage('Fetch') {
      steps {
        git(url: 'https://github.com/SpaceBOBY/test.git', branch: 'main')
      }
    }

    stage('Build') {
      steps {
        sh 'docker build -t weather .'
      }
    }

    stage('run') {
      steps {
        sh 'docker run -t weather -p 8081:81 '
      }
    }

  }
}