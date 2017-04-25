### Secrets in K8s  

#### What is secret
A secret is an object that contains small amount of sensitive information sych as password, a token or a key. This information can be put in a Pod specification or in  an image **(alow to pull image from private repository)** . Secret object allows for more control over the how it is used, and reduce the risk of accidential exposure.

#### Using secrets
To use a secret Pod needs to reference the secret. Pod can use secrets in two ways, as a file in a volume mounted, or used by kubelet when pulling image for the pod from protected repository.


##### Creating namespace
URL: `-XPOST https://workshop-master.k8s.rot.hybris.com:8000/api/v1/namespaces/`

```json
{
  "apiVersion": "v1",
  "kind": "Namespace",
  "metadata": {
          "name": "w-secrets"
  }
}
```

##### Creating secret
URL: `-XPOST https://workshop-master.k8s.rot.hybris.com:8000/api/v1/namespaces/w-secrets/secrets/`

You have to base64 encode your secrets, this is K8s requirement.  

```bash
$ echo -n "hybris" | base64
aHlicmlz

$ echo -n "MySecretPasswd" | base64
TXlTZWNyZXRQYXNzd2Q=
```

Deploy json  

```json
{
	"apiVersion": "v1",
	"kind": "Secret",
	"metadata": {
		"name": "mysecret"
	},
	"type": "Opaque",
	"data": {
		"username": "aHlicmlz",
		"password": "TXlTZWNyZXRQYXNzd2Q="
	}
}
```
To read stored secrets from cluster you heve to use this api endpoint (v1.6)
URL: `-XGET https://workshop-master.k8s.rot.hybris.com:8000/api/v1/namespaces/w-secrets/secrets/mysecret`
Yo heve to remember that api server will return values base64 encoded.

```
{
  "kind": "Secret",
  "apiVersion": "v1",
  "metadata": {
    "name": "mysecret",
    "namespace": "w-secrets",
    "selfLink": "/api/v1/namespaces/w-secrets/secrets/mysecret",
    "uid": "3d8797f1-28ee-11e7-b09a-02000a1bf395",
    "resourceVersion": "21761",
    "creationTimestamp": "2017-04-24T13:02:15Z"
  },
  "data": {
    "password": "TXlTZWNyZXRQYXNzd2Q=",
    "username": "aHlicmlz"
  },
  "type": "Opaque"
}
```

##### Passing secret to Pod

1. Passing secrets to container as a mounted files

Pod definition we use nginx image because it is very lightweight
URL: `-XPOST https://workshop-master.k8s.rot.hybris.com:8000/api/v1/namespaces/w-secrets/pods`

```
{
 "apiVersion": "v1",
 "kind": "Pod",
  "metadata": {
    "name": "mypod",
    "namespace": "w-secrets"
  },
  "spec": {
    "containers": [{
      "name": "mypod",
      "image": "nginx",
      "volumeMounts": [{
        "name": "myvolume",
        "mountPath": "/etc/secrety",
        "readOnly": true
      }]
    }],
    "volumes": [{
      "name": "myvolume",
      "secret": {
        "secretName": "mysecret"
      }
    }]
  }
}
```
>Yoy can project only one secret to container by specifying a key
>
>```
> "volumes": [{
      "name": "foo",
      "secret": {
        "secretName": "mysecret",
        "items": [{
          "key": "username",
          "path": "my-group/my-username"
        }]
      }
    }]
> ```
> In this case only username will be projected to container and stored under `/etc/secrety/my-group/my-username`
 


2. Passing secrets to container as ENV's

In this case wi will use wery similiar Pod definition as in previous example but with different way of passing secrets

URL: `-XPOST https://workshop-master.k8s.rot.hybris.com:8000/api/v1/namespaces/w-secrets/pods`

```json
{
	"apiVersion": "v1",
	"kind": "Pod",
	"metadata": {
		"name": "secret-env-pod"
	},
	"spec": {
		"containers": [
			{
				"name": "mycontainer",
				"image": "nginx",
				"env": [
					{
						"name": "SECRET_USERNAME",
						"valueFrom": {
							"secretKeyRef": {
								"name": "mysecret",
								"key": "username"
							}
						}
					},
					{
						"name": "SECRET_PASSWORD",
						"valueFrom": {
							"secretKeyRef": {
								"name": "mysecret",
								"key": "password"
							}
						}
					}
				]
			}
		],
		"restartPolicy": "Never"
	}
}
```

#### Risks
 - API server secrets data is stored as plain text in etcd
 - etcd stors data on the disk, therefore access should be limited only to admins
 - User who can create the Pod that uses a secret can read it even if apiserver policy does not allow user to read secret object  

 
 	
