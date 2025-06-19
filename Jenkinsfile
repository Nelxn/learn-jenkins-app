pipeline {
    agent any

    environment {
        NETLIFY_SITE_ID = '5624414d-a7fc-4d4e-b3fe-8854b947c776'
        NETLIFY_AUTH_TOKEN = credentials('netlify-token')
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
                    npm ci || npm install --legacy-peer-deps

                    echo "Building project..."
                    npm run build
                '''
            }
        }

        stage('Test') {
            steps {
                echo 'Testing stage'
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
                sh '''
                    echo "Installing Netlify CLI locally..."
                    npm install --no-audit --no-fund --legacy-peer-deps netlify-cli || true

                    echo "Verifying Netlify CLI..."
                    npx netlify --version || true

                    echo "Checking Netlify status..."
                    npx netlify status || true

                    echo "Deploying to Netlify production..."
                    npx netlify deploy --dir=build --prod || true
                '''
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
