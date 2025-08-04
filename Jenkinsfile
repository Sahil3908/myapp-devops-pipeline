pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "sahilc08/myapp"
        DOCKER_TAG = "latest"
    }

    stages {

        stage('Checkout Code') {
            steps {
                echo "Checking out code from GitHub..."
                git branch: 'main', url: 'https://github.com/Sahil3908/myapp-devops-pipeline.git'
            }
        }

        stage('Provision Infrastructure') {
            steps {
                dir('infra') {
                sh 'terraform init'
                sh 'terraform plan'
                sh 'terraform apply -auto-approve'
            }
          }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker image..."
                sh 'docker build -t $DOCKER_IMAGE:$DOCKER_TAG .'
            }
        }

        stage('Push Docker Image') {
            steps {
                echo "Logging into Docker Hub and pushing image..."
                withCredentials([
                    usernamePassword(
                        credentialsId: 'dockerhub-creds',
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_PASS'
                    )
                ]) {
                    sh '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker push $DOCKER_IMAGE:$DOCKER_TAG
                        docker logout
                    '''
                }
            }
        }
    }

    post {
        success {
            echo "Pipeline completed successfully!"
        }
        failure {
            echo "Pipeline failed. Check the logs for details."
        }
    }
}

