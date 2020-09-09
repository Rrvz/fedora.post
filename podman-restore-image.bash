_container_backup=bind_backup
_container_name=fedora-toolbox-32
# delete container
podman rmi "${_container_backup}"
# restore container
podman load -i "$HOME/containers/${_container_backup}".tar

toolbox list
# restore to toolbox
toolbox create --container "${_container_name}" --image "${_container_backup}"
