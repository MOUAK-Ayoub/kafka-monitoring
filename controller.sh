
# install terraform
# install python3

# Not necessary
sudo yum install -y  gcc openssl-devel libffi-devel python-devel
sudo pip3 install --upgrade pip

# It takes some time
python3 -m pip install --user ansible

# work after reboot, maybe because I installed ansible with yum before 
ansible --version


pip install boto3 botocore