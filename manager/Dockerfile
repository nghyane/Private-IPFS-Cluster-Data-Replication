FROM docker:dind

RUN echo "Dockerfile for Swarm Manager"

# Install packages
RUN echo "Install Packages"
RUN apk --no-cache add openrc git bash nano go go-ipfs

# Copy the swarm-setup.sh script from the current directory to the root directory of the image
COPY swarm-setup.sh /swarm-setup.sh

# Set execute permissions for the script
RUN chmod +x /swarm-setup.sh

# Define the entry point to be the swarm-setup.sh script
ENTRYPOINT ["/swarm-setup.sh"]
