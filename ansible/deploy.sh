#!/bin/bash
#ssh-keygen -f C:\Users\usuariox\.ssh\known_hosts -R 10.71.149.89
ansible-galaxy collection install ansible.posix
#Antes de lanzar el primer pllaybook, que va a atodas las máquinas
sudo ssh-keygen -f /home/pedrogsa/known_hosts -R 20.123.180.50
sudo ssh-keygen -f /home/pedrogsa/known_hosts -R 20.23.228.230
sudo ssh-keygen -f /home/pedrogsa/known_hosts -R 20.123.182.147

ansible-playbook -i hosts k8s-01-common.yaml
ansible-playbook -i hosts -l nfs nfs.yaml
ansible-playbook -i hosts -l master,worker k8s-05-master-worker.yaml
#ansible-playbook -i hosts -l worker k8s-05-master-worker.yaml
#con este deploy no va a desplegar. 
#cuando ejecute el pbook que inicializa el cluster(que tengo que poner aquí), me va a decir que 
#haga a mano lo de ejecutar el JOIN (ver "Tareas para desplegar K8s.doc"). Redirigir la salida a un 
#fichero, enla maq lo copiamos a mano, lo metemos en variable de playbook y 
# lanzamos deploy.sh (pag 131)