echo Enter Web01 IP:
read web01ip
ansible-playbook playbooks/apache/apache.yml --inventory inventory  --extra-vars "web01ip=$web01ip" #--ask-pass --ask-become-pass