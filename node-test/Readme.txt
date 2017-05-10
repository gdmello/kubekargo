Create deployment
-----------------

kubectl create -f deployment.yaml
kubectl get deployments

Modify deployment and rollout changes
-------------------------------------
kubectl edit deployment/node-test 
kubectl rollout status deployment/node-test 

Create service, for external access
-----------------------------------
kubectl expose deployment node-test --type=LoadBalancer 
kubectl get services
