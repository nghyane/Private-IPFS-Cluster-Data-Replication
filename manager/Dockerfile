# Dockerfile for Swarm Manager

FROM alpine:3.14

RUN apk --no-cache add docker

# Initialize Docker Swarm
RUN docker swarm init --advertise-addr eth0

# Set environment variables for worker nodes
ENV SWARM_JOIN_TOKEN=$(docker swarm join-token -q worker)
ENV MANAGER_IP=$(docker node inspect self --format '{{ .Status.Addr  }}')

# Log SWARM_JOIN_TOKEN and MANAGER_IP
RUN echo "SWARM_JOIN_TOKEN: $SWARM_JOIN_TOKEN" >> /var/log/swarm.log
RUN echo "MANAGER_IP: $MANAGER_IP" >> /var/log/swarm.log

# Additional setup for the manager node, if needed

CMD ["dockerd", "--host=unix:///var/run/docker.sock", "--host=tcp://0.0.0.0:2375", "--swarm"]
