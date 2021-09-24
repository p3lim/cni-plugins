# cni-plugins

This repository builds a container image containing [cni plugins](https://github.com/containernetworking/plugins), ready to be mounted on a host system.  
The plugins reside in `/opt/cni/bin`.

Image builds can be found under [packages](https://github.com/p3lim/cni-plugins/pkgs/container/cni-plugins).

### Reliability

Steps have been taken to ensure the longevity of this repository and its image:

- A [workflow](https://github.com/p3lim/cni-plugins/blob/master/.github/workflows/cni_version.yml) watches for upstream releases of CNI plugins and automatically creates a pull request.
- A [workflow](https://github.com/p3lim/cni-plugins/blob/master/.github/workflows/build.yml) watches for changes to the Dockerfile, then builds and pushes the image.
- [Dependabot](https://github.com/dependabot) watches for updates to the base image and creates pull requests when there's a new version.

### Usage

Example usage where we use this image to mount CNI plugins to a Kubernetes host:

```yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: cni-plugins
  namespace: kube-system
spec:
  selector:
    matchLabels:
      name: cni-plugins
  template:
    metadata:
      labels:
        name: cni-plugins
    spec:
      tolerations:
        - operator: Exists
          effect: NoSchedule
      containers:
        - name: cni-plugins
          image: ghcr.io/p3lim/cni-plugins:v1.0.1
          resources:
            requests:
              cpu: "100m"
              memory: "50Mi"
            limits:
              cpu: "100m"
              memory: "50Mi"
          securityContext:
            privileged: true
          volumeMounts:
            - name: cni-bin
              mountPath: /opt/cni/bin
        volumes:
          - name: cni-bin
            hostPath:
              path: /opt/cni/bin
```

This is useful for Kubernetes distributions like [Talos](https://talos.dev), which don't supply this themselves, allowing usage of arcane CNIs like [Multus](https://github.com/k8snetworkplumbingwg/multus-cni).

