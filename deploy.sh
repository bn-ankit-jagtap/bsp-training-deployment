#!/bin/bash
set -x
set -e

cd infra/
sudo gyro up
aws eks update-kubeconfig --region ap-south-1 --name aj-gyro-poc-cluster
kubectl apply -k "github.com/kubernetes-sigs/aws-ebs-csi-driver/deploy/kubernetes/overlays/stable/ecr/?ref=release-1.14"

kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/download/v0.6.1/components.yaml

cd ../deployment_manifests
kubectl apply -f gp2-storageclass.yaml 
kubectl apply -f persistent-volumes.yaml 
kubectl apply -f tomcat-deployment.yaml
kubectl apply -f mysql-deployment.yaml 
kubectl apply -f service.yaml
kubectl apply -f solr-deployment.yaml
kubectl apply -f greenmail-deployment.yaml
kubectl apply -f apache-deployment.yaml 


