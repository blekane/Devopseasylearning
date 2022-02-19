## Readiness and liveness probes [here](https://www.yogihosting.com/kubernetes-liveness-readiness-startup-probes/)

### Types of health checks
Kubernetes gives you two types of health checks, and it is important to understand the differences between the two, and their uses.

### Readiness
Readiness probes are designed to let Kubernetes know when your app is ready to serve traffic. Kubernetes makes sure the readiness probe passes before allowing a service to send traffic to the pod. If a readiness probe starts to fail, Kubernetes stops sending traffic to the pod until it passes.

### Liveness
Liveness probes let Kubernetes know if your app is alive or dead. If you app is alive, then Kubernetes leaves it alone. If your app is dead, Kubernetes removes the Pod and starts a new one to replace it.

### Kubernetes has 3 types of Probes:

- Startup Probe: It is the first probe and is use to find out if the app is initialized.
- Liveness Probe: It is used to find out if the app has crashed/deadlocked.
- Readiness Probe: this probe is used to find out if the app is ready to handle requests.


## Kubernetes Startup Probes
The first probe which kubernetes runs is the `Startup Probe`. This probe is helpful in finding if the app is initialized or not. Normally it may just take a few milli-seconds time for the app to be initialized but some app, which are big enough, can take a few seconds (or more) to be initialized. So `Startup Probe` are used mainly for big apps that take a longer time for initializing.

Few things to note here:

- When the app is in the initializing stage the Startup Probe returns some http error code from 400 to - 599.
- As soon as the app is initialized the Startup Probe will return a http success code from 200 to 299. - This means the probe succeeded, now the startup probe will not run again for the lifetime of that - container.
- You can instruct kubernetes how many tries it should perform for this probe. It startup probe fails - for all these tries then kubernetes will eventually kill the container, and restart the pod.

The `Startup Probe` is defined in the deployment yaml file. In the below given deployment yaml I have added the startupProbe that will configure Kubernetes Startup Probes. 

## Kubernetes Liveness Probes
Kubernetes uses Liveness probes to find out if the app is running correctly or not. Some app running for long periods of time can transition to a broken or deadlock state. So, if kubernetes Liveness probes fail then it kills the pod and starts a new one for the app.
```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: test-dep
  labels:
    app: aspnet-core-app
spec:
  replicas: 1
  selector:
    matchLabels:
      component: web
  template:
    metadata:
      labels:
        component: web
    spec:
      containers:
        - name: csimpleweb
          image: simpleweb
          imagePullPolicy: Never
          ports:
            - containerPort: 80
          startupProbe:
            httpGet:
              path: /health/SP
              port: 80
            failureThreshold: 25
            periodSeconds: 10
```
The Startup probe is defined in the startupProbe field, and calls the URL /health/SP on port 80.

The failureThreshold specifies how many times the probe should be tried. I have given it a value of 25. The periodSeconds field specifies the wait period between checks.

So, it means the Startup Probe will continue for 25*10=250 seconds and when it passes k8s starts the liveness and readiness probes. If it fails for all these 250 seconds then k8s will kill the pod and restart another one.


In the deployment yaml file I have added the configurations for Liveness Probe
```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: test-dep
  labels:
    app: aspnet-core-app
spec:
  replicas: 1
  selector:
    matchLabels:
      component: web
  template:
    metadata:
      labels:
        component: web
    spec:
      containers:
        - name: csimpleweb
          image: simpleweb
          imagePullPolicy: Never
          ports:
            - containerPort: 80
          livenessProbe:
            httpGet:
              path: /health/LP
              port: 80
            initialDelaySeconds: 2
            periodSeconds: 10
            timeoutSeconds: 5
            failureThreshold: 10
```

The livenessProbe field defines this probe. I have provided the endpoint of this liveness check to the path field `/health/LP on port 80.`

The other fields and their descriptions are:
- `initialDelaySeconds` – number of seconds to delay before running the probe.
- `periodSeconds` – the waiting time between 2 consecutive tries.
- `timeoutSeconds` – number of seconds to wait for the response from the app. If the app does not give the - response i.e. you get timeout, then start another try.
- `failureThreshold` – number of tries to perform.

I have provided failureThreshold field the value of `10 so 10` tries will be performed by kubernetes and if all these fails then it will kill the pod and start a new one.

The Liveness Probe runs on the container during its whole lifecycle.


## Kubernetes Readiness Probes
Kubernetes performs `Readiness Probes` to detect if the app is ready to handle request. Note that Readiness probes runs on the container during its whole lifecycle and pods reporting that they are not ready does not receive traffic through Kubernetes Services.

Check the below deployment yaml file where I have added Readiness Probe.
```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: test-dep
  labels:
    app: aspnet-core-app
spec:
  replicas: 1
  selector:
    matchLabels:
      component: web
  template:
    metadata:
      labels:
        component: web
    spec:
      containers:
        - name: csimpleweb
          image: simpleweb
          imagePullPolicy: Never
          ports:
            - containerPort: 80
          readinessProbe:
            httpGet:
              path: /health/RP
              port: 80
            initialDelaySeconds: 2
            periodSeconds: 10
            timeoutSeconds: 5
            failureThreshold: 10
            successThreshold: 5
```

Configuration settings are similar for readiness probes, although there is successThreshold. This field tells kubernetes to consider this probe successful only if the request to the endpoint is successful for the given number of times (here 5) after receiving a failure. Suppose at some point the request to the url – /health/RP timed out. So kubernetes will make 5 tries (as given in the “successThreshhold” value) and all these 5 tries should pass, only then the probe will be considered successful.

```py
endpoints.MapHealthChecks("/health/SP", new HealthCheckOptions()
 {
     Predicate = (check) => check.Tags.Contains("sp_tag")
 });
 endpoints.MapHealthChecks("/health/LP", new HealthCheckOptions()
 {
     Predicate = (check) => check.Tags.Contains("lp_tag")
 });
 endpoints.MapHealthChecks("/health/RP", new HealthCheckOptions()
 {
     Predicate = (check) => check.Tags.Contains("rp_tag")
 });
 ```