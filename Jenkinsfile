pipeline {
    agent any

    environment {
        NETLIFY_SITE_ID = '5624414d-a7fc-4d4e-b3fe-8854b947c776'
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
                    image 'node:18-alpine'
                    reuseNode true
                }
            }
            steps {
                sh '''
                    npm install netlify-cli
                    node_modules/netflify --version
                    echo "Deploying to production. Site ID: $NETLIFY_SITE_ID"
                    '''       
            }
        }
    }
}