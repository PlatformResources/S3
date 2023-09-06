#!/bin/bash

CONTAINER_NAME="vscode"

# Check if the container with the specified name exists
if docker ps -a --format '{{.Names}}' | grep -q "^$CONTAINER_NAME$"; then
  echo "Removing existing container: $CONTAINER_NAME"
  docker stop $CONTAINER_NAME
  docker rm $CONTAINER_NAME
fi

# Run the new container
docker run -d -p 8084:8080 --name $CONTAINER_NAME codercom/code-server

# Sleep for 10 seconds to allow the container to start
sleep 10s

# Execute the desired commands inside the container
docker exec $CONTAINER_NAME /bin/bash -c "cat ~/.config/code-server/config.yaml"
docker exec $CONTAINER_NAME /bin/bash -c "git init"
docker exec $CONTAINER_NAME /bin/bash -c "git pull https://github.com/PlatformResources/S3/"
