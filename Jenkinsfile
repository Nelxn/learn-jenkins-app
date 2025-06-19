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
                    image 'node:18-alpine'
                    reuseNode true
                }
            }
            steps {
                sh '''
                    ls -la
                    node --version
                    npm --version
                    npm ci
                    npm run build
                    ls -la
                '''              
            }
        }

        stage('test') {
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
                    npm install --no-audit --no-fund netlify-cli

                    echo "Checking Netlify CLI version..."
                    npx netlify --version

                    echo "Exporting auth variables..."
                    export NETLIFY_AUTH_TOKEN=$NETLIFY_AUTH_TOKEN
                    export NETLIFY_SITE_ID=$NETLIFY_SITE_ID

                    echo "Checking Netlify site status..."
                    npx netlify status || true

                    echo "Deploying to Netlify production..."
                    npx netlify deploy --dir=build --prod
                '''
            }
        }
    }
}