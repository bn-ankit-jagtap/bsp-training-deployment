#!/bin/bash
set -x
set -e

cd infra/
sed -i '/^#/s/^#//' eks.gyro
sed -i '/^#/s/^#//' vpc.gyro
sudo gyro up
aws eks update-kubeconfig --region ap-south-1 --name aj-gyro-poc-cluster

kubectl apply -k "github.com/kubernetes-sigs/aws-ebs-csi-driver/deploy/kubernetes/overlays/stable/ecr/?ref=release-1.14"

kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/download/v0.6.1/components.yaml

cd ../deployment_manifests
kubectl apply -f namespace.yaml
kubectl apply -f gp2-storageclass.yaml 
kubectl apply -f persistent-volumes.yaml 
sleep 60
kubectl apply -f dummy-pod.yaml
sleep 240
kubectl apply -f tomcat-deployment.yaml
sleep 60
kubectl apply -f mysql-deployment.yaml 
sleep 60
kubectl apply -f service.yaml
kubectl apply -f solr-deployment.yaml
kubectl apply -f greenmail-deployment.yaml
kubectl apply -f apache-deployment.yaml 


