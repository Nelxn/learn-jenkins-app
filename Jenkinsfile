pipeline {
    agent any

    environment {
        DOCKER_REGISTRY = 'docker.io'
        DOCKER_IMAGE = 'nelxn/nodejs-app'
        DOCKER_CREDENTIALS_ID = 'docker-hub-credentials-id'
    }

    stages {
        stage('Build') {
            agent {
                docker {
                    image 'node:18-slim'
                    reuseNode true
                }
            }
            steps {
                sh '''
                    echo "Checking environment..."
                    node --version
                    npm --version

                    echo "Installing dependencies..."
                    npm ci
                '''
                sh '''
                    echo "Building project..."
                    npm run build
                '''
            }
        }

        stage('Test') {
            agent {
                docker {
                    image 'node:18-slim'
                    reuseNode true
                }
            }
            steps {
                sh '''
                    echo "Running tests..."
                    npm test
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                    echo "Building Docker image..."
                    docker build -t $DOCKER_REGISTRY/$DOCKER_IMAGE:latest .
                '''
            }
        }

        stage('Push Docker Image') {
            steps {
                withDockerRegistry([credentialsId: "$DOCKER_CREDENTIALS_ID", url: "https://index.docker.io/v1/"]) {
                    sh '''
                        echo "Pushing Docker image to registry..."
                        docker push $DOCKER_REGISTRY/$DOCKER_IMAGE:latest
                    '''
                }
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                    echo "Deploying application..."
                    docker rm -f nodejs-app || true
                    docker run -d --name nodejs-app -p 3000:3000 $DOCKER_REGISTRY/$DOCKER_IMAGE:latest
                '''
            }
        }
    }

    post {
        always {
            echo 'Cleaning up workspace...'
            cleanWs()
        }
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed. Please check the logs.'
        }
    }
}



// This Jenkinsfile defines a pipeline for building, testing, and deploying a Node.js application using Docker.