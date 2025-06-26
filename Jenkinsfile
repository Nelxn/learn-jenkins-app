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
					if [ -f package-lock.json ]; then
						npm ci
					else
						npm install --legacy-peer-deps
					fi

					echo "Building project..."
					npm run build
				'''
			}
		}

		stage('Test') {
			steps {
				sh '''
					echo "Running tests..."
					npm test
				'''
			}
		}

		stage('Build Docker Image') {
			steps {
				script {
					dockerImage = docker.build("${DOCKER_IMAGE}:${env.BUILD_NUMBER}")
				}
			}
		}

		stage('Deploy') {
			agent {
				docker {
					image 'node:18-slim'
					reuseNode true
				}
			}
			steps {
				script {
					docker.withRegistry("https://${DOCKER_REGISTRY}", "${DOCKER_CREDENTIALS_ID}") {
						dockerImage.push()
					}
				}
			}
		}
	}

	post {
		failure {
			echo 'Pipeline failed. Please check the logs above for details.'
		}
		success {
			echo 'Pipeline completed successfully.'
		}
	}
}