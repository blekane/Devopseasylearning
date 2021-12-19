# Persistent Volumes Demo [HERE](Persistent Volumes on Kubernetes for beginners)

## Container Storage 

By default containers store their data on the file system like any other process.
Container file system is temporary and not persistent during container restarts
When container is recreated, so is the file system


```
# run postgres
docker run -d --rm -e POSTGRES_DB=postgresdb -e POSTGRES_USER=admin -e POSTGRES_PASSWORD=admin123 postgres:10.4

# enter the container 
docker exec -it <container-id> bash
docker exec -it 8f2f56fd11ee bash

# login to postgres
psql --username=admin postgresdb

#create a table
CREATE TABLE COMPANY(
   ID INT PRIMARY KEY     NOT NULL,
   NAME           TEXT    NOT NULL,
   AGE            INT     NOT NULL,
   ADDRESS        CHAR(50),
   SALARY         REAL
);

#show table
\dt

# quit 
\q
```

Restarting the above container with `docker run -d --rm -e POSTGRES_DB=postgresdb -e POSTGRES_USER=admin -e POSTGRES_PASSWORD=admin123 postgres:10.4` and check the table, it will return no tables.
Since data is lost.

## Persist data Docker

```
docker volume create postges
docker run -d --rm -v postges:/var/lib/postgresql/data -e POSTGRES_DB=postgresdb -e POSTGRES_USER=admin -e POSTGRES_PASSWORD=admin123 postgres:10.4
```

## Same can be demonstrated using Kubernetes
```
kubectl create ns postgres
kubectl apply -n postgres -f ./postgres-no-pv.yaml
kubectl -n postgres get pods 
kubectl -n postgres exec -it postgres-0 bash
```

## Persist data Kubernetes
```
kubectl apply -f persistentvolume.yaml or kubectl apply -n postgres -f persistentvolume.yaml 
kubectl apply -n postgres -f persistentvolumeclaim.yaml
kubectl apply -n postgres -f postgres-with-pv.yaml
kubectl -n postgres get pv
kubectl -n postgres get pvc
kubectl -n postgres get pods

kubectl -n postgres exec -it postgres-0 bash
psql --username=admin postgresdb


#create a table
CREATE TABLE COMPANY(
   ID INT PRIMARY KEY     NOT NULL,
   NAME           TEXT    NOT NULL,
   AGE            INT     NOT NULL,
   ADDRESS        CHAR(50),
   SALARY         REAL
);

#show table
\dt

# quit 
\q
```

