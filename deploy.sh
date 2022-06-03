docker build -t kdt1802/multi-client:latest -t kdt1802/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kdt1802/multi-server:latest -t kdt1802/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kdt1802/multi-worker:latest -t kdt1802/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push kdt1802/multi-client:latest
docker push kdt1802/multi-server:latest
docker push kdt1802/multi-worker:latest

docker push kdt1802/multi-client:$SHA
docker push kdt1802/multi-server:$SHA
docker push kdt1802/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=kdt1802/multi-client:$SHA
kubectl set image deployments/server-deployment server=kdt1802/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=kdt1802/multi-worker:$SHA