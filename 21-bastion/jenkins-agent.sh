#!/bin/bash
ARCH=amd64
PLATFORM=$(uname -s)_$ARCH
HOME=/root

growpart /dev/nvme0n1 4
lvextend -l +40%FREE /dev/RootVG/rootVol
lvextend -l +30%FREE /dev/RootVG/varVol
xfs_growfs /
xfs_growfs /var
 

dnf -y install dnf-plugins-core
dnf config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo
dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
systemctl start docker
systemctl enable docker
usermod -aG docker ec2-user

#kubectl installation
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.32.0/2024-12-20/bin/linux/amd64/kubectl
chmod +x ./kubectl
mv kubectl /usr/local/bin/kubectl

#eksctl
curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$PLATFORM.tar.gz"
tar -xzf eksctl_$PLATFORM.tar.gz -C /tmp && rm eksctl_$PLATFORM.tar.gz
mv /tmp/eksctl /usr/local/bin

#helm
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh

#kubens
git clone https://github.com/ahmetb/kubectx /opt/kubectx
ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
ln -s /opt/kubectx/kubens /usr/local/bin/kubens

#k9s monitoring
curl -sS https://webinstall.dev/k9s | bash

# mysql
dnf install mysql -y

 
#for jenkins 
yum install java-17-openjdk -y
yum install -y yum-utils
yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
yum -y install terraform
dnf module disable nodejs -y
dnf module enable nodejs:20 -y
dnf install nodejs -y
yum install zip -y

# docker
yum install -y yum-utils
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
systemctl start docker
systemctl enable docker
usermod -aG docker ec2-user

# Maven for Java projects
dnf install maven -y

# Python for python projects
dnf install python3.11 gcc python3-devel -y

# install Java
dnf install java-17-openjdk -y

################################################################
# Need do manual steps
# dnf install java-17-openjdk -y

# lvextend -l +30%FREE /dev/RootVG/homeVol
# xfs_growfs /home

# for npm 
# curl -fsSL https://rpm.nodesource.com/setup_20.x | sudo bash -
# sudo dnf install -y nodejs