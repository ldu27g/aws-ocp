#!/bin/bash -ex

# Create Nutanix VM
#ansible-playbook -i inventory/inventory_nx_vm_clone playbooks/ocp-nutanix/site.yml;

# Configure OS Settings
#ansible-playbook -i inventory/inventory_ls_ocp_os_lb playbooks/ls-ocp-os-lb/site.yml;
ansible-playbook -i inventory/inventory_ls_ocp_os playbooks/ls-ocp-os/site.yml;

# Install OpenShift
pushd playbooks/openshift-ansible
ansible-playbook -i ../../inventory/acom_inventory playbooks/prerequisites.yml;
ansible-playbook -i ../../inventory/acom_inventory playbooks/deploy_cluster.yml;  
popd

sleep 30s;

# Create admin user
#ansible-playbook -i inventory/inventory_ocp_user playbooks/ocp-user/site.yml;

# Custom OpenShift
#ansible-playbook -i inventory/inventory_ocp_all playbooks/ocp-ipfailover/site.yml;
#ansible-playbook -i inventory/inventory_ocp_all playbooks/ocp-docker-registry/site.yml;

#sleep 30s;

# Deploy Grafana
#ansible-playbook -i inventory/acom_inventory playbooks/openshift-ansible/playbooks/openshift-grafana/config.yml 

# Custom PODs
#ansible-playbook -i inventory/inventory_ocp_all playbooks/ocp-fluentd/site.yml;
#ansible-playbook -i inventory/inventory_ocp_all playbooks/ocp-prometheus/site.yml;
#ansible-playbook -i inventory/inventory_ocp_all playbooks/ocp-grafana/site.yml;

# Create kafka/zookeeper pods
#ansible-playbook -i inventory/inventory_kafka_zoo playbooks/ocp-kafka-zoo/site.yml;

# Create zipkin pods
#ansible-playbook -i inventory/inventory_zipkin playbooks/ocp-zipkin/site.yml;

# Change ElasticSearch Volume
#sleep 30s;
#ansible-playbook -i inventory/inventory_ocp_all playbooks/ocp-elasticsearch/site.yml;

