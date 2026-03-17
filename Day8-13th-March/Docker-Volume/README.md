# Docker Volume Practical

## Objective
To create a named Docker Volume, locate its physical Mountpoint on the local host machine, attach it to a container, and verify data persistence.

## Steps Completed
1. **Created Docker Volume:** Executed `docker volume create my-task-volume`.
2. **Located Local Path:** Used `docker volume inspect my-task-volume` to discover the local host path (`/var/lib/docker/volumes/my-task-volume/_data`).
3. **Attached Volume:** Ran an Ubuntu container mapping the named volume to the `/app` directory inside the container (`-v my-task-volume:/app`).
4. **Verified Persistence:** Created a text file inside the container's `/app` directory, exited the container, and successfully read the file directly from the local host's volume Mountpoint.