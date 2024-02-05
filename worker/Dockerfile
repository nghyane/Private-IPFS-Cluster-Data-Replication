FROM docker:dind

RUN echo "Dockerfile for Swarm Worker"

# Install packages
RUN echo "Install Packages"
RUN apk --no-cache add openrc git bash nano jq go go-ipfs

# Copy scripts from the current directory to the root directory of the image
COPY services/ipfs /etc/init.d/ipfs
COPY swarm.key /swarm.key
COPY worker-setup.sh /worker-setup.sh
COPY ipfs-setup-worker.sh /ipfs-setup-worker.sh
COPY ipfs-update-config.sh /ipfs-update-config.sh
COPY ipfs-update-bootstrap.sh /ipfs-update-bootstrap.sh
COPY ipfs-daemon.sh /ipfs-daemon.sh

# Set execute permissions for the script
RUN chmod +x /etc/init.d/ipfs
RUN chmod +x /worker-setup.sh
RUN chmod +x /ipfs-setup-worker.sh
RUN chmod +x /ipfs-update-config.sh
RUN chmod +x /ipfs-update-bootstrap.sh
RUN chmod +x /ipfs-daemon.sh

# Define the entry point to be the worker-setup.sh script
ENTRYPOINT ["/worker-setup.sh"]
