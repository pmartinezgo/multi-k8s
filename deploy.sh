docker build -t solamnia/multi-client-k8s:latest -t solamnia/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t solamnia/multi-server-k8s-pgfix:latest -t solamnia/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t solamnia/multi-worker-k8s:latest -t solamnia/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push solamnia/multi-client-k8s:latest
docker push solamnia/multi-server-k8s-pgfix:latest
docker push solamnia/multi-worker-k8s:latest

docker push solamnia/multi-client-k8s:$SHA
docker push solamnia/multi-server-k8s-pgfix:$SHA
docker push solamnia/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=solamnia/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=solamnia/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=solamnia/multi-worker-k8s:$SHA