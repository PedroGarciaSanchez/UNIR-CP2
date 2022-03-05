#!/bin/bash
ansible-galaxy collection install ansible.posix
ssh-keygen -f known_hosts x.x.x.master
ssh-keygen -f known_hosts x.x.x.worker1
ssh-keygen -f known_hosts x.x.x.nfs

ansible-playbook -i hosts k8s-01-common.yaml
ansible-playbook -i hosts -l nfs nfs.yaml
#con este deploy no va a desplegar. 
#cuando ejecute el pbook que inicializa el cluster(que tengo que poner aquí), me va a decir que 
#haga a mano lo de ejecutar el JOIN (ver "Tareas para desplegar K8s.doc"). Redirigir la salida a un 
#fichero, enla maq lo copiamos a mano, lo metemos en variable de playbook y 
# lanzamos deploy.sh (pag 131)