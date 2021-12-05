docker build -t czekish/multi-client:latest -t czekish/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t czekish/multi-server:latest -t czekish/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t czekish/multi-worker:latest -t czekish/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push czekish/multi-client:latest
docker push czekish/multi-server:latest
docker push czekish/multi-worker:latest

docker push czekish/multi-client:$SHA
docker push czekish/multi-server:$SHA
docker push czekish/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=czekish/multi-server:$SHA
kubectl set image deployments/client-deployment client=czekish/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=czekish/multi-worker:$SHA