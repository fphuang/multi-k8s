docker build -t huangfp/multi-client:latest -t huangfp/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t huangfp/multi-server:latest -t huangfp/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t huangfp/multi-worker:latest -t huangfp/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push huangfp/multi-client:latest
docker push huangfp/multi-server:latest
docker push huangfp/multi-worker:latest

docker push huangfp/multi-client:$SHA 
docker push huangfp/multi-server:$SHA 
docker push huangfp/multi-worker:$SHA 

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=huangfp/multi-server:$SHA 
kubectl set image deployments/client-deployment client=huangfp/multi-client:$SHA 
kubectl set image deployments/worker-deployment worker=huangfp/multi-worker:$SHA 
