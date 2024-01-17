FROM docker:dind

RUN echo "Dockerfile for Swarm Manager"

# Install packages
RUN echo "Install Packages"
RUN apk --no-cache add openrc git bash nano jq go go-ipfs

# Copy the swarm-setup.sh script from the current directory to the root directory of the image
# RUN mkdir -p /vol/swarm/manager
COPY swarm-setup.sh /swarm-setup.sh
COPY ./ipfs-setup.sh /ipfs-setup.sh
COPY ./ipfs-update-config.sh /ipfs-update-config.sh
COPY ./ipfs-update-bootstrap.sh /ipfs-update-bootstrap.sh

# Set execute permissions for the script
RUN chmod +x /swarm-setup.sh
RUN chmod +x /ipfs-setup.sh
RUN chmod +x /ipfs-update-config.sh
RUN chmod +x /ipfs-update-bootstrap.sh

# Define the entry point to be the swarm-setup.sh script
ENTRYPOINT ["/swarm-setup.sh"]
