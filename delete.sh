#!/bin/bash
set -x
cd deployment_manifests/
kubectl delete -f service.yaml
kubectl delete -f mysql-deployment.yaml
kubectl delete -f apache-deployment.yaml 
kubectl delete -f persistent-volumes.yaml
cd ../infra/

sed -i 's/^/# /' eks.gyro
sed -i 's/^/# /' vpc.gyro
sudo gyro up
