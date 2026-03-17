# Docker Hub Push Practical

## Objective
To successfully authenticate with Docker Hub via the CLI, tag a local Docker image with a repository namespace, and push the image to a public Docker Hub repository.

## Steps Completed
1. **CLI Authentication:** Executed `docker login` to authenticate the local Ubuntu server with Docker Hub credentials.
2. **Image Tagging:** Used `docker tag` to rename a locally built image (`task-image`) to match the required Docker Hub namespace format (`username/repository:tag`).
3. **Pushed to Registry:** Executed `docker push` to upload the image layers to the remote Docker Hub repository.
4. **Verification:** Verified the image's availability via the Docker Hub web UI.