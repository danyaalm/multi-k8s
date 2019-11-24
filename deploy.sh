docker build -t dmastech/multi-client:latest -t dmastech/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dmastech/multi-server:latest -t dmastech/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dmastech/multi-worker:latest -t dmastech/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push dmastech/multi-client:latest
docker push dmastech/multi-server:latest
docker push dmastech/multi-worker:latest
docker push dmastech/multi-client:$SHA
docker push dmastech/multi-server:$SHA
docker push dmastech/multi-worker:$SHA
kubectl apply -f ./k8s
kubectl set image deployments/client-deployment client=dmastech/multi-client:$SHA
kubectl set image deployments/server-deployment server=dmastech/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=dmastech/multi-worker:$SHA