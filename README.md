## ProblemSolver

> This is my personal Docker image for troubleshooting.

> There are many Docker images like it, but this one is mine.

[rifleman's creed](https://en.wikipedia.org/wiki/Rifleman%27s_Creed)

## Overview

- Based upon `debian:stable-slim`. Why not Alpine? To be sure to not run into [DNS issues](https://stackoverflow.com/a/65593511).
- Straight forward Dockerfile.
- Distinguishes between `arm64` and `amd64` hosts and offers an image for both architectures.
- [Dockerhub](https://hub.docker.com/r/allaman/problemsolver)
