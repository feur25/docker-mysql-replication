#!/bin/bash

# Lancement du serveur MySQL en mode démon
CMD="/usr/local/bin/docker-entrypoint.sh mysqld"

# Si le fichier /tmp/.wsrep-new-cluster existe, on ajoute l'option --wsrep-new-cluster pour forcer la création d'un nouveau cluster
if test -n "$GALERA_NEW_CLUSTER" -a -f /tmp/.wsrep-new-cluster; then
  CMD="$CMD --wsrep-new-cluster"
fi

# Suppression du fichier /tmp/.wsrep-new-cluster
rm -f /tmp/.wsrep-new-cluster

# Exécution de la commande
exec $CMD

