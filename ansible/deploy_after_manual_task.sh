#!/bin/bash

ansible-playbook -i hosts -l master k8s-02-master_after_manual.yaml
ansible-playbook -i hosts -l worker k8s-03-workers.yaml
