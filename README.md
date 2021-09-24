# cni-plugins

This repository builds a container image containing [cni plugins](https://github.com/containernetworking/plugins), ready to be mounted on a host system.  
The plugins reside in `/opt/cni/bin`.

Image builds can be found under [packages](https://github.com/p3lim/cni-plugins/pkgs/container/cni-plugins).

### updates

Steps have been taken to ensure the longevity of this repository and its image:

- A [workflow](https://github.com/p3lim/cni-plugins/blob/master/.github/workflows/cni_version.yml) watches for upstream releases of CNI plugins and automatically creates a pull request.
- A [workflow](https://github.com/p3lim/cni-plugins/blob/master/.github/workflows/build.yml) watches for changes to the Dockerfile, then builds and pushes the image.
- [Dependabot](https://github.com/dependabot) watches for updates to the base image and creates pull requests when there's a new version.

