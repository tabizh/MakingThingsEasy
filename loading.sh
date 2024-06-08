#** Created By Tabizh to save you time :) **

#!/bin/bash

# Step 1: List files and current date
echo "Listing files:"
ls -lrt
echo "Current date:"
date

# Step 2: Load Docker image from emscli_tab.tar
echo "Loading Docker image from emscli_tab.tar..."
sudo docker load -i emscli_tab.tar

# Step 3: Find and delete the sdponemscli pod using kubectl
echo "Finding and deleting sdponemscli pod..."
pod_name=$(sudo kubectl get pods -l app=sdponemscli -o=jsonpath='{.items[0].metadata.name}')
if [ -n "$pod_name" ]; then
    echo "Deleting pod: $pod_name"
    sudo kubectl delete pod $pod_name
else
    echo "No sdponemscli pod found."
fi

sleep 5

# Step 4: Get the IP address of the new sdponemscli pod
echo "Getting IP address of the new sdponemscli pod..."
new_ip=$(sudo kubectl get pods -l app=sdponemscli -o=jsonpath='{.items[0].status.podIP}')

# Step 5: List pods using kubectl
echo "Listing pods using kubectl:"
sudo kubectl get pods -owide

# Step 6: SSH into pajmapuser@new_ip
if [ -n "$new_ip" ]; then
    echo "SSHing into pajmapuser@$new_ip..."
    ssh pajmapuser@$new_ip
else
    echo "Unable to determine the IP address of the new sdponemscli pod."
fi
