## ProblemSolver

> This is my personal Docker image for troubleshooting.

> There are many Docker images like it, but this one is mine.

[rifleman's creed](https://en.wikipedia.org/wiki/Rifleman%27s_Creed)

## Overview

- Based upon `debian:stable-slim`. Why not Alpine? To be sure to not run into [DNS issues](https://stackoverflow.com/a/65593511).
- Straight forward Dockerfile with no shenanigans.
- Distinguishes between `arm64` and `amd64` hosts and builds an image for both architectures.
- Includes plenty of useful tools and Golang 1.18
- [Dockerhub](https://hub.docker.com/r/allaman/problemsolver)
- Blog [post](https://rootknecht.net/blog/multi-arch-docker/) about multi arch Docker images.

## Examples

Start problemsolver in your configured Kubernetes cluster in interactive mode

```sh
kubectl run problemsolver -n <NAMESPACE> --rm -i --tty --image allaman/problemsolver
```

Start problemsolver via Docker in interactive mode

```sh
docker run --name problemsolver --rm -it allaman/problemsolver
```
