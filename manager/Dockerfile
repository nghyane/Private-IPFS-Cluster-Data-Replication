FROM alpine:latest

RUN echo "Dockerfile for Swarm Manager"

# Install packages
RUN echo "Install Packages"
RUN apk --no-cache add openrc git bash nano jq go go-ipfs

# Copy necessary files
COPY swarm.key /swarm.key
COPY dicom-files /vol/swarm/dicom-files
COPY pdf-files /vol/swarm/pdf-files

# Copy scripts from the current directory to the root directory of the image
COPY services/ipfs /etc/init.d/ipfs
COPY manager-setup.sh /manager-setup.sh
COPY ipfs-setup-manager.sh /ipfs-setup-manager.sh
COPY ipfs-update-config.sh /ipfs-update-config.sh
COPY ipfs-update-bootstrap.sh /ipfs-update-bootstrap.sh
COPY ipfs-daemon.sh /ipfs-daemon.sh

# Set execute permissions for the script
RUN chmod +x /etc/init.d/ipfs
RUN chmod +x /manager-setup.sh
RUN chmod +x /ipfs-setup-manager.sh
RUN chmod +x /ipfs-update-config.sh
RUN chmod +x /ipfs-update-bootstrap.sh
RUN chmod +x /ipfs-daemon.sh

# Define the entry point to be the manager-setup.sh script
ENTRYPOINT ["/manager-setup.sh"]
