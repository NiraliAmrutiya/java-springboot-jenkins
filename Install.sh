#Step-1
1. Configure Ubuntu Node for Jenkisn
2. Run below

    sudo apt update
    sudo apt install openjdk-17-jdk -y
3. Install Jenkins

sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins -y
sudo systemctl enable jenkins

4. Configure Jenkins (userid, install plugins)

5. Plugins to be Installed
   a. Pipeline: Stage View


6. Create Pipeline JOb

7. Generate a Token in GIT for authentication from Jenkins to Git

8. Configure Github Webhook for jenkins

9. Maven Build
    1. Configure Maven in tools section of Jenkins -> Manage

10. Install Trivy
 sudo apt-get install wget gnupg
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | gpg --dearmor | sudo tee /usr/share/keyrings/trivy.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb generic main" | sudo tee -a /etc/apt/sources.list.d/trivy.list
sudo apt-get update
sudo apt-get install trivy -y

11. Go to Ubuntu user
  run--> sudo visudo
  jenkins ALL=(ALL) NOPASSWD: ALL

12. Docker Install
#Docker
curl https://get.docker.com | bash
sudo usermod -aG docker $USER
newgrp docker
sudo systemctl stop docker 
sudo systemctl enable --now docker 
sudo systemctl start docker

Login with jenkins user and run as below

sudo usermod -aG docker $USER


stop jenkins and start jenkins

use root
systemctl stop jenkins
systemctl start jenkins
systemctl enable docker

13. Run Sonarqube as a Container

mkdir sonar
sudo chown -R 1000:1000 /home/ubuntu/sonar
sudo chmod -R 755 /home/ubuntu/sonar

 docker run -d \
  --name sonar \
  -p 9000:9000 \
  -v /home/ubuntu/sonar:/opt/sonarqube/data \
  -v /home/ubuntu/sonar/extensions:/opt/sonarqube/extensions \
  -v /home/ubuntu/sonar/logs:/opt/sonarqube/logs \
  sonarqube:lts-community

