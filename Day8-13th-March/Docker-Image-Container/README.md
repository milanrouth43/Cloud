# Docker Image vs. Container Practical

## Objective
To demonstrate the creation of a custom Docker image using a Dockerfile, deploying it as a live container, and interacting with the container's environment via the CLI.

## Steps Completed
1. **Created a Dockerfile:** Built a custom template based on the `ubuntu:latest` image and permanently baked the `vim` text editor into it.
2. **Built the Image:** Executed `docker build -t task-image .` to compile the Dockerfile into a local image.
3. **Ran the Container:** Executed `docker run -it --name task-container task-image` to launch an interactive terminal session inside a live container.
4. **Modified the Live Container:** Updated the package manager and manually installed `curl` (`apt update && apt install curl -y`) directly inside the running container, proving that active containers can be modified independently of their base image.