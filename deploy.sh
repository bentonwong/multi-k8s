docker build -t bentonwong/multi-client:latest -t bentonwong/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t bentonwong/multi-server:latest -t bentonwong/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t bentonwong/multi-worker:latest -t bentonwong/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push bentonwong/multi-client:latest
docker push bentonwong/multi-server:latest
docker push bentonwong/multi-worker:latest

docker push bentonwong/multi-client:$SHA
docker push bentonwong/multi-server:$SHA
docker push bentonwong/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=bentonwong/multi-server:$SHA
kubectl set image deployments/client-deployment client=bentonwong/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=bentonwong/multi-worker:$SHA
