pipeline {
    agent any
	
 stages {
        stage('Docker Build and Tag image') {
            steps {
                sh 'docker build -t ferencmolnar/gowebapp:latest .' 
                //sh 'docker tag gowebapp:latest ferencmolnar/gowebapp:latest'
                //sh 'docker tag samplewebapp ferencmolnar/gowebapp:$BUILD_NUMBER'
                echo "Jenkins build id is: $BUILD_ID"
            }
        }
     
        stage('Publish image to Docker Hub') {
            steps {
		        withDockerRegistry(credentialsId: 'dockerhub', url: '') {
		        //sh 'docker login --username username --password-stdin < ~/my_passwd'
		        sh 'docker push ferencmolnar/gowebapp:latest'
		}
        }
    }
     
        stage('Run Docker container on Jenkins Agent') {
            steps {
		timeout(time: 3, unit: 'SECONDS') {
                sh "docker run -d -p 80:80 ferencmolnar/gowebapp"
            }
        }
	}
	 stage('List running containers') {
            steps {
	    	//sh './docker_container_rm.sh'
		script {
   			DOCKER_CONTAINER_NAME = sh (
        			script: 'docker ps',
        			returnStdout: true
    				).trim()
    				echo "Docker container name: ${DOCKER_CONTAINER_NAME}"
		}
            }
        }
    }
}
