#!/bin/bash

sudo ansible-playbook -i hosts -l master k8s-02-master_after_manual.yaml
sudo ansible-playbook -i hosts -l master k8s-02-master_after_reboot.yaml
sudo ansible-playbook -i hosts -l worker k8s-03-workers.yaml
sudo ansible-playbook -i hosts -l worker,master k8s-02-worker_after_manual.yaml

#[root@kubemaster ~]# kubectl get pods -A -o wide : para ver las 169 y el haproxy running
#[root@kubemaster ~]# kubectl get svc -A
#De aquí cogeremos el puerto que se corresponde con haproxy-kubernetes-ingress (es el mapeao del 80). Por ejemplo:
#haproxy-controller   haproxy-kubernetes-ingress                   NodePort    10.104.187.186   <none>        80:32489
#Con este Puerto crearemos una nueva regla de seguridad con Terraform. En el archivo terraform/security_master.tf 
#y hago terraform plan + apply
#luego ejecuto playbook de jenkins y sigo estos pasos
#https://www.digitalocean.com/community/tutorials/how-to-install-jenkins-on-kubernetes 
#y cambio el etc/hosts de windows
# y poner en navegador: foo.bar:32489/webapp-routed 

#y lo automatizo en playbook de jenkins y cambio el etc/hosts de windows
