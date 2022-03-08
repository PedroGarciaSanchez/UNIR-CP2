#!/bin/bash
#ssh-keygen -f C:\Users\usuariox\.ssh\known_hosts -R 10.71.149.89
sudo ansible-galaxy collection install ansible.posix
#Antes de lanzar el primer pllaybook, que va a atodas las máquinas
#entrar en las máquinas y salir con logout, para que quedeen registradas en known_hosts
sudo ssh adminUsername@40.68.119.5
sudo ssh adminUsername@20.107.7.92
sudo ssh adminUsername@13.95.17.175




sudo ansible-playbook -i hosts k8s-01-common.yaml
sudo ansible-playbook -i hosts -l nfs nfs.yaml
sudo ansible-playbook -i hosts -l master,worker k8s-05-master-worker.yaml
sudo ansible-playbook -i hosts -l master k8s-02-master.yaml
sudo ansible-playbook -i hosts -l master k8s-02-master_after_manual.yaml
sudo ansible-playbook -i hosts -l worker k8s-02-worker_after_manual.yaml
sudo ansible-playbook -i hosts -l master k8s-02-master_after_reboot.yaml

#ansible-playbook -i hosts -l worker k8s-05-master-worker.yaml
#con este deploy no va a desplegar. 
#cuando ejecute el pbook que inicializa el cluster(que tengo que poner aquí), me va a decir que 
#haga a mano lo de ejecutar el JOIN (ver "Tareas para desplegar K8s.doc"). Redirigir la salida a un 
#fichero, enla maq lo copiamos a mano, lo metemos en variable de playbook y 
# lanzamos deploy.sh (pag 131)