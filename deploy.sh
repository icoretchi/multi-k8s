docker build -t icoretchi/multi-client:latest -t icoretchi/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t icoretchi/multi-server:latest -t icoretchi/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t icoretchi/multi-worker:latest -t icoretchi/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push icoretchi/multi-client:latest
docker push icoretchi/multi-server:latest
docker push icoretchi/multi-worker:latest

docker push icoretchi/multi-client:$SHA
docker push icoretchi/multi-server:$SHA
docker push icoretchi/multi-worker:$SHA

kubectl apply -f k8s/

kubectl set image deployments/server-deployment server=icoretchi/multi-server:$SHA
kubectl set image deployments/client-deployment client=icoretchi/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=icoretchi/multi-worker:$SHA