pipeline {
    agent any

    stages {

        stage('Clone Repository') {
            steps {
                git 'https://github.com/kbenhaida8598-cloud/tp-jenkins-security.git'
            }
        }

        stage('Setup Python Environment') {
            steps {
                sh '''
                python3 -m venv venv
                source venv/bin/activate
                pip install --upgrade pip
                pip install -r requirements.txt
                pip install pytest
                '''
            }
        }

        stage('Run Tests') {
            steps {
                sh '''
                source venv/bin/activate
                pytest
                '''
            }
        }

        stage('SCA Scan') {
            steps {
                sh '''
                dependency-check.sh \
                --project "TP-Jenkins-Security" \
                --scan . \
                --format HTML \
                --failOnCVSS 7
                '''
            }
        }

    }

    post {
        success {
            echo 'Pipeline executed successfully'
        }

        failure {
            echo 'Build failed due to errors or vulnerabilities'
        }
    }
}
