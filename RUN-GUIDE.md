# Running Docker Swarm with Docker Compose

## Prerequisites

- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)

## Setup

1. **Clone the repository:**

   ```bash
   git clone https://adamcanray/Private-IPFS-Cluster-Data-Replication.git
   cd Private-IPFS-Cluster-Data-Replication
   ```

2. **Cleanup (optional)**

   ```bash
   docker container prune
   docker volume prune
   docker image prune
   ```

   This command will remove all stopped containers, unused volumes, and unused images.

3. **Build and deploy the Docker stack:**

   ```bash
   docker compose build --no-cache
   docker-compose up -d
   ```

   This command will create and deploy the Docker stack with a manager node (`n0`) and two worker nodes (`n1`, `n2`).

4. **Monitor the deployment:**

   - Check the status of the deployed services:

     ```bash
     docker-compose ps
     ```

   - View the logs of a specific service (replace `<service-name>` with the actual service name):

     ```bash
     docker-compose logs <service-name>
     ```

## Cleanup

To stop and remove the Docker Swarm stack:

```bash
docker-compose down
```

This command will stop and remove the containers, networks, and volumes created by the Docker Compose setup.
