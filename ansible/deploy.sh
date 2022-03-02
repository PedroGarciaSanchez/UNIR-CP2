#!/bin/bash
ansible-playbook -i hosts.azuremio 01-playbook.yaml
ansible-playbook -i hosts.azuremio -l master 02-playbook.yaml
#con este deploy no va a desplegar. 
#cuando ejecute el pbook que inicializa el cluster(que tengo que poner aquí), me va a decir que 
#haga a mano lo de ejecutar el JOIN (ver "Tareas para desplegar K8s.doc"). Redirigir la salida a un 
#fichero, enla maq lo copiamos a mano, lo metemos en variable de playbook y 
# lanzamos deploy.sh (pag 131)