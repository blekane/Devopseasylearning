#!/bin/bash
kubectl create namespace v2 
kubectl apply -f frontend.yaml -n v2 --validate=false
kubectl apply -f frontend-service.yaml -n v2 --validate=false
kubectl apply -f ingress.yaml -n v2 --validate=false
kubectl get all -n v2 