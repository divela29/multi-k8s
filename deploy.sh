docker build -t stephengrider/multi-client-k8s:latest -t stephengrider/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t stephengrider/multi-server-k8s:latest -t stephengrider/multi-server-k8s:$SHA -f ./server/Dockerfile ./server
docker build -t stephengrider/multi-worker-k8s:latest -t stephengrider/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push stephengrider/multi-client-k8s:latest
docker push stephengrider/multi-server-k8s:latest
docker push stephengrider/multi-worker-k8s:latest

docker push stephengrider/multi-client-k8s:$SHA
docker push stephengrider/multi-server-k8s:$SHA
docker push stephengrider/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=stephengrider/multi-server-k8s:$SHA
kubectl set image deployments/client-deployment client=stephengrider/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=stephengrider/multi-worker-k8s:$SHA