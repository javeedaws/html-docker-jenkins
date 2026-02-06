// pipeline{
//     agent any 

//     environment {
//         IMAGE_NAME="html-app"
//     }

//     stages{
//         stage("checkout"){
//             steps {
//                 checkout scm
//             }
//         }
        
// stage("Build Docker Image") {
//             steps {
//                 sh "docker build -t $IMAGE_NAME:$BRANCH_NAME ."
//             }
//         }

//         stage("Test") {
//             steps {
//                 sh "docker run --rm $IMAGE_NAME:$BRANCH_NAME ls /usr/share/nginx/html"
//             }
//         }

//         stage("Deploy") {
//             when {
//                 branch "main"
//             }
//             steps {
//                 sh '''
//                  docker rm -f html-prod || true
//                  docker run -d -p 80:80 --name html-prod $IMAGE_NAME:main
//                 '''
//             }
//         }
//     }
// }

pipeline {
    agent any

    environment {
        IMAGE_NAME = "html-app"
    }

    stages {

        stage("Checkout") {
            steps {
                checkout scm
            }
        }

        stage("Build") {
            steps {
                sh "docker build -t $IMAGE_NAME:$BRANCH_NAME ."
            }
        }

        stage("Test") {
            steps {
                sh "docker run --rm $IMAGE_NAME:$BRANCH_NAME ls /usr/share/nginx/html"
            }
        }

        stage("Deploy") {
            when {
                branch "main"
            }
            steps {
                sh '''
                docker rm -f html-prod || true
                docker run -d -p 80:80 --name html-prod $IMAGE_NAME:main
                '''
            }
        }
    }

    post {
        success {
            echo "✅ ${BRANCH_NAME} passed"
        }
        failure {
            echo "❌ ${BRANCH_NAME} failed"
        }
    }
}


