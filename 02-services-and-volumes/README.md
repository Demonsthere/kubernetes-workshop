# Kubernetes-workshop part 2 - Services and mounted volumes

## Agenda

* Sumarry of the last meeting
	* What is kubernetes
	* Basic concepts
	* How to spin a sample application
* How to access your applicaitons - services
	* What is a service
	* Service types
	* Accessing applicaitons
* Secrets in Kubernetes
	* Secrets overview
	* Creating own secrets
	* Using your secrets	 
* How to access your applications - but drop the ports
	* Ingress controller
	* Ingress manifest
	* Finding your application - the pretty way

## Kubernetes services

!["K8s services"](https://coreos.com/kubernetes/docs/latest/img/rolling-deploy.svg)

### The essentials

* Pods are isolated in the software defined network, and cannot reach out
* Services are a special type of object - not a docker images, that allows outside connections
* Service types:
	* ClusterIP - the pod has a ip in the SDN - default
	* NodePort - a static high port on the cluster is assigned to a specific port of the pod
	* LoadBalancer - the service can serve multiple pods, and pick the one it uses (default round robin)

### Service definition

```yaml
apiVersion: v1
kind: Service
metadata:
  name: my-nginx
  labels:
    run: my-nginx
spec:
  type: NodePort
  ports:
  - port: 8080
    targetPort: 80
    protocol: TCP
    name: http
  - port: 443
    protocol: TCP
    name: https
  selector:
    run: my-nginx
```

## Kubernetes ingress

!["Ingress definition"](https://image.slidesharecdn.com/selection-151119212429-lva1-app6891/95/kubernetes-where-we-are-where-were-going-and-why-15-638.jpg)

### The essentials

* Services are bound on ports, but are global in the cluster
* Ingress is the config map, **not** a application!
* We need a reverse proxy, that will be the engine of the Ingress
* We **still** need services

### Traefik

!["Traefik proxy"](https://pbs.twimg.com/media/CkcZ9xXXIAA3U6J.jpg)

### The essentials

* Universal reverse proxy
* Connects to the kubernetes-api and manages redirections
* Gather information about ingress maps

