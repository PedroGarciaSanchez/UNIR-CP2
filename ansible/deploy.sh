#!/bin/bash

#Antes de lanzar el primer pllaybook, que va a atodas las máquinas
#entrar en las máquinas y salir con logout, para que quedeen registradas en known_hosts
#sudo ssh adminUsername@40.68.119.5
#sudo ssh adminUsername@20.107.7.92
#sudo ssh adminUsername@13.95.17.175




sudo ansible-playbook -i hosts k8s-01-common.yaml
sudo ansible-playbook -i hosts -l nfs nfs.yaml
sudo ansible-playbook -i hosts -l master,worker k8s-02-master-worker.yaml
sudo ansible-playbook -i hosts -l master k8s-03-master.yaml

#parte manual en master:
# sudo kubeadm init --pod-network-cidr 192.169.1.0/16


#output: 
# las instrucciones que salen las ejecuto después en k8s-03-workers.yaml
# Guardo el comando kubeadm que sale al final, ya que lo necesitaré para unir los workers al clúster.
#Cambio en group_vars/k8s-worker.yaml los valores:
#-token
#-hash
#por los que me devuelve el output



# y ejecutar deploy_after_manual_task.sh

 

