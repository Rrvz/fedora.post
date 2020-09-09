# list all containers
# toolbox list
_container_0=`toolbox list| grep "running" | grep "fedora-toolbox-32" | awk -F ' ' '{ print $2 }'`

# stop the container
# podman container stop `toolbox list| grep "running" | grep "fedora-toolbox-32" | awk -F ' ' '{ print $2 }'`
podman container stop "${_container_0}"

# make the backup
_container_backup=bind_backup
podman container commit -p "${_container_0}" ${_container_backup}

# make a tar
podman save -o "$HOME/containers/${_container_backup}".tar "${_container_backup}"

