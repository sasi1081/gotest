pipeline {
    agent any
    
    environment {
        dockerImage = ''
        registry = 'sasi1081/gotestsasi'
        registryCredential = 'dockerhub_id'
    }
    stages{
        
        stage('checkout') {
            
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'sasi1081', url: 'https://github.com/sasi1081/gotest.git']]])
            }
        }
        stage('Build Docker Image') {
            
            steps {
                script {
                    dockerImage = docker.build registry
                }
                
            }
        }
        
        stage (' Upload Docker image to docker hub'){
            
            steps {
                script {
                    
                    docker.withRegistry('',registryCredential){
                        dockerImage.push()
                    }
                    
                }
            }
        }

         stage('Stop containers') {
            steps {

                sh 'docker ps -f name=gosasitest -q | xargs --no-run-if-empty docker container stop || true'
                sh 'docker container ls -a -fname=gosasitest -q | xargs -r docker container rm || true'
            }
         }

        stage('Run the container') {
            steps{
                script{
                    dockerImage.run("-p 80:80 --rm --name gosasitest")
                    
                    
                }
            }
        }
        stage ( "Deploy the infra via terraform") {

            steps{

            withAWS(role:'IAMProvisioningRole'){
               sh '''
               pwd
               chmod +x deploy_go_infra.sh
               ./deploy_go_infra
               '''
            }
            }

        }

    }
       
         
}
