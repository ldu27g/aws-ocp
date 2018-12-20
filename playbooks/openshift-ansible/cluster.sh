#!/bin/bash

docker run -t -u `id -u` \
    -v /etc/hosts:/etc/hosts:Z \
    -v $HOME/.ssh/id_rsa:/opt/app-root/src/.ssh/id_rsa:Z \
    -v $HOME/openshift-ansible/inventory/acom_inventory:/tmp/inventory:Z \
    -e INVENTORY_FILE=/tmp/inventory \
    -e PLAYBOOK_FILE=playbooks/prerequisites.yml \
    -e OPTS="-v" \
    registry.redhat.io/openshift3/ose-ansible:v3.11&


docker run -t -u `id -u` \
    -v /etc/hosts:/etc/hosts:Z \
    -v $HOME/.ssh/id_rsa:/opt/app-root/src/.ssh/id_rsa:Z \
    -v $HOME/openshift-ansible/inventory/acom_inventory:/tmp/inventory:Z \
    -e INVENTORY_FILE=/tmp/inventory \
    -e PLAYBOOK_FILE=playbooks/deploy_cluster.yml \
    -e OPTS="-v" \
    registry.redhat.io/openshift3/ose-ansible:v3.11


