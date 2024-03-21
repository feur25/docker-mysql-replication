# image de base : mariadb:10.6
FROM mariadb:10.6

# Création de fichier de configuration
RUN touch /tmp/.wsrep-new-cluster && chown -R mysql:mysql /tmp/.wsrep-new-cluster

# Copie des fichiers de configuration
COPY galera.cnf /etc/mysql/conf.d/01-galera.cnf

# Copie du script de démarrage
COPY startup.sh /startup.sh

# Droits d'exécution sur le script de démarrage
USER mysql:mysql

# Exécution du script de démarrage
CMD /startup.sh

