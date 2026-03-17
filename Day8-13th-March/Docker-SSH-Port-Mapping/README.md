# Docker SSH Port Mapping Practical

## Objective
Configure a Docker container to run an SSH daemon, map a custom host port to the container's SSH port, and successfully connect to the container via SSH.

## Steps Completed
1. **Created a Custom Image:** Wrote a `Dockerfile` based on Ubuntu that installs `openssh-server`, configures the SSH daemon to allow root login, and exposes container port 22.
2. **Deployed with Port Mapping:** Ran the container in detached mode using `docker run -p 2323:22`. This mapped port 2323 on the local host to port 22 inside the container.
3. **Verified Access:** Executed `ssh root@localhost -p 2323` from the host machine and successfully established an SSH session directly into the running Docker container.