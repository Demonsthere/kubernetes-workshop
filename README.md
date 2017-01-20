# kubernetes-workshop
Workshop description for the Kubernetes

SET SAIL to K8s
===============

# Namespaces
## Display all namespaces
```
GET http://foo.yrdci.fra.hybris.com:8000/api/v1/namespaces
```
## Create new namespace
REST API
```
POST http://foo.yrdci.fra.hybris.com:8000/api/v1/namespaces/
```
JSON
```
{
  "apiVersion": "v1",
  "kind": "Namespace",
  "metadata": {
          "name": "heflik"
  }
}
```
## Delete namespace
```
DELETE http://foo.yrdci.fra.hybris.com:8000/api/v1/namespaces/heflik/
```
# K8s PODs

## Display PODs for namespace
```
GET http://foo.yrdci.fra.hybris.com:8000/api/v1/namespaces/heflik/pods/
```

## Create single application pod
REST API
```
http://foo.yrdci.fra.hybris.com:8000/api/v1/namespaces/heflik/pods/
```
JSON
```
{
  "kind": "Pod",
  "apiVersion": "v1",
  "metadata": {
    "name": "single-pod",
    "labels": {
      "app": "node-js"
    }
  },
  "spec": {
    "containers": [
      {
        "name": "single-pod-app",
        "image": "jonbaier/node-express-info:latest",
        "ports": [
          {
            "containerPort": 80
          }
        ]
      }
    ]
  }
}
```
Delete
```
DELETE http://foo.yrdci.fra.hybris.com:8000/api/v1/namespaces/heflik/pods/single-pod/
```
## Display pod information
```
GET http://foo.yrdci.fra.hybris.com:8000/api/v1/namespaces/heflik/pods/single-pod
```
## Create Service (LB)
```
POST http://foo.yrdci.fra.hybris.com:8000/api/v1/namespaces/heflik/services/
```
JSON
```
{
	"apiVersion": "v1",
	"kind": "Service",
	"metadata": {
		"name": "node-js",
		"labels": {
			"name": "node-js"
		}
	},
	"spec": {
		"type": "LoadBalancer",
		"ports": [
			{
				"port": 80
			}
		],
		"selector": {
			"app": "node-js"
		}
	}
}
```
Delete service (LB)
```
DELETE http://foo.yrdci.fra.hybris.com:8000/api/v1/namespaces/heflik/services/node-js/
```
# Replication Controller (RC)
## Create RC
```
POST http://foo.yrdci.fra.hybris.com:8000/api/v1/namespaces/heflik/replicationcontrollers/
```
JSON
```
{
	"apiVersion": "v1",
	"kind": "ReplicationController",
	"metadata": {
		"name": "node-js"
	},
	"spec": {
		"replicas": 3,
		"selector": {
			"name": "node-js"
		},
		"template": {
			"metadata": {
				"labels": {
					"name": "node-js"
				}
			},
			"spec": {
				"containers": [
					{
						"name": "node-js",
						"image": "jonbaier/node-express-info:latest",
						"ports": [
							{
								"containerPort": 80
							}
						]
					}
				]
			}
		}
	}
}
```
Delete (RC)
```
DELETE http://foo.yrdci.fra.hybris.com:8000/api/v1/namespaces/heflik/replicationcontrollers/node-js/
```
Create service (LB)
```
{
	"apiVersion": "v1",
	"kind": "Service",
	"metadata": {
		"name": "node-js",
		"labels": {
			"name": "node-js"
		}
	},
	"spec": {
		"type": "LoadBalancer",
		"ports": [
			{
				"port": 80
			}
		],
		"selector": {
			"name": "node-js"
		}
	}
}
```

# Links
https://kubernetes.io/docs/user-guide/pods/multi-container/

https://kubernetes.io/docs/api-reference/v1.5/#service-v1
