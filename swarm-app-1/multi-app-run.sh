docker network create -d overlay frontend
docker network create -d overlay backend
docker service create --name vote --network frontend -p 80:80 --replicas 2 dockersamples/examplevotingapp_vote:before
docker service create --name redis --network frontend --replicas 1 redis:3.2
docker service create --name db --mount type=volume,source=db-data,target=/var/lib/postgresql/data postgres:9.4
docker service create --name worker --network frontend --network backend dockersamples/examplevotingapp_worker
docker service create --name result --network backend -p 5001:80 dockersamples/examplevotingapp_result:before