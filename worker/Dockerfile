# Dockerfile for Swarm Worker

FROM alpine:3.14

RUN apk --no-cache add go go-ipfs git nano docker

# Environment variables for worker nodes
ENV SWARM_JOIN_TOKEN=${SWARM_JOIN_TOKEN}
ENV MANAGER_IP=${MANAGER_IP}

# Log SWARM_JOIN_TOKEN and MANAGER_IP
RUN echo "SWARM_JOIN_TOKEN: $SWARM_JOIN_TOKEN" >> /var/log/swarm.log
RUN echo "MANAGER_IP: $MANAGER_IP" >> /var/log/swarm.log

# CMD to join the swarm
CMD ["sh", "-c", "docker swarm join --token ${SWARM_JOIN_TOKEN} ${MANAGER_IP}:2377"]
