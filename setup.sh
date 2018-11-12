#!/bin/bash

K8S_DIR="./k8s"

# Check if env vars exist
if [[ -z $DB_PASSWORD ]]; then
  echo "Required environment variables not set"
  exit 1
fi

# Submit PV claims
kubectl apply -f $K8S_DIR/mysql-volumeclaim.yaml
kubectl apply -f $K8S_DIR/wordpress-volumeclaim.yaml

# Create Mysql secret
kubectl create secret generic mysql-creds --from-literal=password=$DB_PASSWORD

# Create mysql Deployment and Service
kubectl apply -f $K8S_DIR/mysql.yaml
kubectl apply -f $K8S_DIR/mysql-service.yaml

# Create wordpress Deployment and Service
kubectl apply -f $K8S_DIR/wordpress.yaml
kubectl apply -f $K8S_DIR/wordpress-service.yaml
