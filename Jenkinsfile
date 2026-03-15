pipeline {
    agent any

    environment {
        // Token SonarQube stocké dans Jenkins Credentials
        SONAR_TOKEN = credentials('jenkis-token')  
    }

    stages {

        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Setup Python Environment') {
            steps {
                sh '''
                 sonar-scanner \
                -Dsonar.projectKey=TP-Jenkins-Security \
                -Dsonar.projectName="TP-Jenkins-Security" \
                -Dsonar.sources=. \
                -Dsonar.python.version=3
                '''
            }
        }

      stage('SAST Scan') {
    steps {
        withSonarQubeEnv('SonarQube Server') {
            sh 'sonar-scanner'
        }
    }
}

        stage('Run Tests') {
            steps {
                sh './venv/bin/pytest --maxfail=1 --disable-warnings -q'
            }
        }

        stage('SCA Scan - Dependency Check') {
            steps {
                sh '''
                ./dependency-check/bin/dependency-check.sh \
                --project "tp-jenkins-security" \
                --scan . \
                --format HTML \
                --failOnCVSS 7
                '''
            }
        }

    }

    post {
        success {
            echo 'Pipeline executed successfully ✅'
        }
        failure {
            echo 'Build failed due to errors or vulnerabilities ❌'
        }
    }
}
