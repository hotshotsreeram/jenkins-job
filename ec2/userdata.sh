#!/bin/bash -ex
  
sudo apt-get update
sudo apt install nginx -y
echo "<h1>$(curl https://api.prod.rest/?format=text)</h1>" >  /usr/share/nginx/html/index.html 
systemctl enable nginx
systemctl start nginx
cd /home/ubuntu/
git clone https://github.com/hotshotsreeram/jenkins-job.git
sudo -i
cat /home/ubuntu/jenkins-job/ec2/index.html > /var/www/html/index.nginx-debian.html