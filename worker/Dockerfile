FROM docker:dind

RUN echo "Dockerfile for Swarm Worker"

# Install packages
RUN echo "Install Packages"
RUN apk --no-cache add openrc git bash nano go go-ipfs

# Copy the swarm-join.sh script from the current directory to the root directory of the image
COPY swarm-join.sh /swarm-join.sh

# Set execute permissions for the script
RUN chmod +x /swarm-join.sh

# Define the entry point to be the swarm-join.sh script
ENTRYPOINT ["/swarm-join.sh"]
