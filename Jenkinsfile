pipeline {
    agent {
        node {
            label 'gcc'
        }
    }

    stages {
        stage ('Compile') {
            steps {
                sh "make -j4"
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}