#!/bin/bash
kubectl delete -f frontend.yaml -n v1
kubectl delete -f frontend-service.yaml -n v1
kubectl delete -f ingress.yaml -n v1
kubectl get all -n v1