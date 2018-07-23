pipeline {
	
    agent { label '10.200.152.50' }
    stages {
                   
        stage ('Checkout Dockerfile') {
          steps {
            git 'https://github.com/felixanto23/gridgain.git'
          }
        }
        stage('Docker Build') {
        
            steps {
                
                sh 'docker build -t gridgain:8.4.5.5 --build-arg ENV=DEV --build-arg NODE=DATA --no-cache=true .'
            }
		}
	stage('Docker Deploy') {
			steps {
    			sh 'docker run --net host -P -p47500:47500 --expose 11211 -e env=DEV -e node=DATA -v /opt:/poc -itd gridgain:8.4.5.5'
			}
		}
        stage('Docker Push') {
			steps {
				sh "docker login -u admin -p admin 10.200.152.50:8081"
				sh "docker tag gridgain 10.200.152.50:8081/docker-repo/gridgain:8.4.5.5"
				sh "docker push 10.200.152.50:8081/docker-repo/gridgain:8.4.5.5"
			}
		}
	}
}
