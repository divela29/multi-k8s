docker build -t divela/multi-client-k8s:latest -t divela/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t divela/multi-server-k8s-pgfix:latest -t divela/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t divela/multi-worker-k8s:latest -t divela/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push divela/multi-client-k8s:latest
docker push divela/multi-server-k8s-pgfix:latest
docker push divela/multi-worker-k8s:latest

docker push divela/multi-client-k8s:$SHA
docker push divela/multi-server-k8s-pgfix:$SHA
docker push divela/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=divela/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=divela/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=divela/multi-worker-k8s:$SHA