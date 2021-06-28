pipeline {
    agent any
	
   environment {
        DOCKER_IMAGE_LABEL = 'ferencmolnar/gowebapp:latestl'
    }
	
 stages {
        stage('Docker Build and Tag image') {
            steps {
		 echo "$DOCKER_IMAGE_LABEL"
		 dockerfile {
        		filename 'Dockerfile.build'
        		dir 'build'
        		label '$DOCKER_IMAGE_LABEL'
        		//additionalBuildArgs  '--build-arg version=1.0.2'
        		//args '-v /tmp:/tmp'
		}
            }
        }
     
        stage('Publish image to Docker Hub') {
            steps {
		   withDockerRegistry(credentialsId: 'dockerhub', url: '') {
		   sh 'docker push $DOCKER_IMAGE_LABEL'
		}
            }
    	}
     
        stage('Run Docker container on Jenkins Agent') {
            steps {
		timeout(time: 3, unit: 'SECONDS') {
                sh "docker run -d -p 80:80 $DOCKER_IMAGE_LABEL"
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
