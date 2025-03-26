#!/bin/bash
# Docker Registry Image Delete Script - Must be run on sudo mode
# Made By Lucas Kang(2025-03-27)

echo "------------------------------------ Start Docker Registry Image Delete!! ------------------------------------"

# Variables
imageName=""
imageTag=""

# Input Image Name
echo -n "Input Image Name :"
read imageName

# Input Image Tag
echo -n "Input Image Tag :"
read imageTag

# Get Image Digest
digest_values=$(curl -s --header "Accept: application/vnd.oci.image.manifest.v1+json" \
http://localhost:5000/v2/$imageName/manifests/$imageTag | jq -r '.layers[].digest')

echo "Digest Values : $digest_values"
echo

echo "Delete Digest"
curl -X DELETE http://localhost:5000/v2/$imageName/manifests/$digest_values


echo "Garbage Collect delete"
docker exec -it docker_registry bin/registry garbage-collect /etc/docker/registry/config.yml

# Real File Directory Delete
echo "Real File Directory Delete"
rm -rf /data/services/registry/docker/registry/v2/repositories/$imageName

echo "------------------------------------ Complete ------------------------------------"
