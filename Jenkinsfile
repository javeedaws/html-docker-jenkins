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
        GIT_URL = "https://github.com/javeedaws/html-docker-jenkins.git"
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

        stage("Auto Merge Dev → Main") {
            when {
                branch "dev"
            }
            steps {
                sh '''
                git config user.email "javeedaws60@gmail.com"
                git config user.name "Jenkins"

                git checkout main
                git pull $GIT_URL main
                git merge dev
                git push $GIT_URL main
                '''
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
            echo "✅ Pipeline SUCCESS for branch: ${BRANCH_NAME}"
            sh "docker images | grep $IMAGE_NAME || true"
        }

        failure {
            echo "❌ Pipeline FAILED for branch: ${BRANCH_NAME}"
        }

        always {
            echo "🧹 Pipeline finished for ${BRANCH_NAME}"
        }
    }
}
