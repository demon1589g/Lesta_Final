pipeline {
    agent any

    environment {
        IMAGE_NAME = "flask-api"
	REGISTRY = "docker.io/demon1589g"
        SERVER_IP = "37.9.53.201"
        SSH_CREDENTIALS_ID = 'jenkins-ssh'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                sh "docker build -t ${IMAGE_NAME} ."
            }
        }

	stage('Lint') {
    	    steps {
        	sh "docker run --rm -v \$PWD:/app -w /app flask-api flake8 ."
   	    }
        }

        stage('Push') {
            steps {
                script {
                    docker.withRegistry('', 'dockerhub-credentials') {
                        sh "docker tag ${IMAGE_NAME} ${REGISTRY}/${IMAGE_NAME}:latest"
                        sh "docker push ${REGISTRY}/${IMAGE_NAME}:latest"
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                sshagent(credentials: [SSH_CREDENTIALS_ID]) {
                    sh """
                    ssh -o StrictHostKeyChecking=no ubuntu@${SERVER_IP} '
                        docker stop flask-api || true && docker rm flask-api || true
                        docker pull ${REGISTRY}/${IMAGE_NAME}:latest
                        docker run -d --name flask-api -p 5000:5000 \
  			  -e DATABASE_URL=sqlite:////app/test.db \
                           ${REGISTRY}/${IMAGE_NAME}:latest
                    '
                    """
                }
            }
        }
    }
}

