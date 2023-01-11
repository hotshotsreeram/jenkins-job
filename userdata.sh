#!/bin/bash -ex
  
sudo apt-get update
sudo apt install nginx -y
echo "<h1>$(curl https://api.prod.rest/?format=text)</h1>" >  /usr/share/nginx/html/index.html 
systemctl enable nginx
systemctl start nginx
cd /home/ubuntu/
git clone https://github.com/hotshotsreeram/jenkins-job.git