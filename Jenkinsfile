pipeline{

agent any

tools {
  maven 'Maven'
}

environment{
   registry = "109722177373.dkr.ecr.us-east-1.amazonaws.com/myecrrepo"
}

//checkout
//prepare a jar
//build the image 
//connect to ecr
//push the image to ecr
//deploy to k8s
    stages{

        //checkout
        stage("checkout from git"){
            steps{
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/eswari795/springboot-app.git']]])
            }
            
        }

        //prepare a jar
        stage("create a jar"){
            steps{
            sh "mvn clean install"
            }
        }

        //build the image
        stage("build the image"){
            steps{
            script{
                docker.build registry
            }
            }
        }

        //push the image to ecr
        stage("Push the image to ECR"){
            steps{
                sh "aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 109722177373.dkr.ecr.us-east-1.amazonaws.com"
                sh "docker push 109722177373.dkr.ecr.us-east-1.amazonaws.com/myecrrepo:latest"
            }
        }

        //deploy to k8s

        stage("Deploy to K8s"){
            steps{
                withKubeConfig(caCertificate: '', clusterName: '', contextName: '', credentialsId: 'k8s', namespace: '', serverUrl: '') {
                    sh "kubectl create -f eks-deploy-from-ecr.yaml"
        }
            }
        }
    }
}