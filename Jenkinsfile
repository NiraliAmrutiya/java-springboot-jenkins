pipeline {
    agent any
    tools {
        maven 'maven3'
        jdk 'jdk17'
    }
    environment {
        SCANNER_HOME= tool 'sonar-scanner'
    }
    stages {
        stage('Git Checkout') {
            steps {
                git branch: 'main' , url: 'https://github.com/NiraliAmrutiya/java-springboot-jenkins.git'

            }
        }

        stage('Maven Compile') {
            steps {
                echo 'Maven COmpile Started'
                sh 'mvn compile'
                echo 'Maven COmpile Finished'
            }
        }
        stage('Maven Test') {
            steps {
                echo 'Maven Test Started'
                sh 'mvn test'
                echo 'Maven Test Finished'
            }
        }
        stage('File System Scan') {
            steps {
                echo 'Trivy Scan Started'
                sh 'trivy fs --format table --output trivy-fs-output.html .'
                echo 'Trivy Scan Finished'
            }
        }
        stage ('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('sonar') {
                    sh ''' 
                        $SCANNER_HOME/bin/sonar-scanner \
                        -Dsonar.projectName=BoardGame \
                        -Dsonar.projectKey=BoardGame \
                        -Dsonar.java.binaries=target/classes \
                        -Dsonar.java.libraries="target/dependency/*.jar" \
                        -Dsonar.nodejs.executable=/usr/bin/node \
                        -Dsonar.exclusions="**/trivy-image-report.html"
                    '''
                }
            }
        }
        stage('Quality Gate') {
            steps {
                script {
                timeout(time: 1, unit: 'MINUTES') {
                waitForQualityGate abortPipeline: true, credentialsId: 'sonar'
                }
              }
            }
        }
        stage('Publish to Nexus') {
            steps {
                withMaven(globalMavenSettingsConfig: 'global-settings', jdk: 'jdk17', maven: 'maven3', mavenSettingsConfig: '', traceability: true) {
                    sh 'mvn deploy -X'
            }
        }
     }
    }
}