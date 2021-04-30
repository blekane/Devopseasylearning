#!/bin/bash
kubectl create -f frontend-configmap.yaml -n v3
kubectl create -f frontend-service.yaml -n v3
kubectl create -f frontend.yaml -n v3
kubectl create namespace v3
kubectl create -f backend-secret.yaml -n v3
kubectl create -f backend-service.yaml -n v3
kubectl create -f backend.yaml -n v3
kubectl create -f ingress.yaml -n v3
kubectl create -f mongodb-persistent-volume.yaml -n v3
kubectl create -f mongodb-persistent-volume-claim.yaml -n v3
kubectl create -f mongodb-secret.yaml -n v3
kubectl create -f mongodb-service.yaml -n v3
kubectl create -f mongodb.yaml -n v3
kubectl get all -n v3

