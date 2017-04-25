### Volumes

#### Types of volumes
- emptyDir, hostPath
- gcePersistentDisk, awsElasticBlockStore
- nfs, iscsi, flocker, gluster, cephfs
- secrets


##### emptyDir

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
##### Creating Pod with emptyDir

URL: `-XPOST https://workshop-master.k8s.rot.hybris.com:8000/api/v1/namespaces/w-secrets/pods`


```
{
  "apiVersion": "v1",
  "kind": "Pod",
  "metadata": {
    "name": "test-pd"
  },
  "spec": {
    "containers": [
      {
        "image": "nginx",
        "name": "test-container",
        "volumeMounts": [
          {
            "mountPath": "/hybris-cache",
            "name": "cache-volume"
          }
        ]
      }
    ],
    "volumes": [
      {
        "name": "cache-volume",
        "emptyDir": {}
      }
    ]
  }
}

```

##### Creating Pod with hostPath
URL: `-XPOST https://workshop-master.k8s.rot.hybris.com:8000/api/v1/namespaces/w-secrets/pods`

Directory /hybris was created no workshop-slave-devoted-shark

```
{
  "apiVersion": "v1",
  "kind": "Pod",
  "metadata": {
    "name": "test-hybrisDir"
  },
  "spec": {
    "containers": [
      {
        "image": "gcr.io/google_containers/test-webserver",
        "name": "test-container",
        "volumeMounts": [
          {
            "mountPath": "/test-pd",
            "name": "test-volume"
          }
        ]
      }
    ],
    "volumes": [
      {
        "name": "test-volume",
        "hostPath": {
          "path": "/hybris"
        }
      }
    ]
  }
}
```

