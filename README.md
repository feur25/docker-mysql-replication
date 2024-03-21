﻿﻿﻿﻿# docker-mysql-replication
# Mise à jour du gestionnaire de paquets et installation de Git
    sudo apt update
    sudo apt install git

# Ajout de la clé GPG officielle de Docker
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

# Ajout du référentiel Docker aux sources APT
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"

# Mise à jour du cache des paquets et installation de Docker
    sudo apt update
    sudo apt install docker-ce docker-ce-cli containerd.io

# Ajout de votre utilisateur au groupe Docker pour exécuter des commandes Docker sans sudo
    sudo usermod -aG docker $USER

# Téléchargement de la dernière version stable de Docker Compose
    sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# Application des permissions d'exécution au binaire Docker Compose
    sudo chmod +x /usr/local/bin/docker-compose

# Vérification de la version de Docker Compose
    docker-compose --version

# Clonage du référentiel Docker MySQL Replication
    git clone https://github.com/feur25/docker-mysql-replication.git

# Accès au répertoire cloné
    cd docker-mysql-replication

# Démarrage des conteneurs MySQL avec Docker Compose
    sudo docker-compose up -d

![image](https://github.com/feur25/docker-mysql-replication/assets/39668417/ed7c541d-00be-4aef-b9e7-02c625300197)


Mise en place d'un cluster Galera. 
-------------------------

    docker build -t galera .

Lancement des cluster Galera basée sur une image
---------------------------------------


	docker network create --subnet 172.20.0.0/16 galera

cette partie devra se trouver dans les fichiers nodeX.cnf.

	[mysqld]
	wsrep_cluster_address = "gcomm://172.20.0.101,172.20.0.102,172.20.0.103,172.20.0.104"
	wsrep_cluster_name    = "galera-cluster"
	wsrep_node_name       = "node1"
	wsrep_node_address    = "172.20.0.101"

	mkdir /srv/galera/node{1,2,3,4}
	chown 999:999 /srv/galera/node{1,2,3,4}
 
Lancer chaque nœud en utilisant Docker, en ajoutant un sleep infinity pour maintenir le conteneur en cours d'exécution, si vous voulez vérifier qu'il sont en cours d'éxecution faite la commande sudo docker ps

	docker run -d --restart=unless-stopped --net galera \
		--name node1 -h node1 --ip 172.20.0.101 \
		-p 3311:3306 \
		-v /srv/galera/node1.cnf:/etc/mysql/conf.d/galera.cnf \
		-v /srv/galera/node1:/var/lib/mysql \
		-e MYSQL_ROOT_PASSWORD=secret_galera_password \
		-e GALERA_NEW_CLUSTER=1 \
		galera
		sleep infinity
  
	docker run -d --restart=unless-stopped --net galera \
		--name node2 -h node2 --ip 172.20.0.102 \
		-p 3312:3306 \
		-v /srv/galera/node2.cnf:/etc/mysql/conf.d/galera.cnf \
		-v /srv/galera/node2:/var/lib/mysql \
		-e MYSQL_ALLOW_EMPTY_PASSWORD=1 \
		galera
  		sleep infinity
	
	docker run -d --restart=unless-stopped --net galera \
		--name node3 -h node3 --ip 172.20.0.103 \
		-p 3313:3306 \
		-v /srv/galera/node3.cnf:/etc/mysql/conf.d/galera.cnf \
		-v /srv/galera/node3:/var/lib/mysql \
		-e MYSQL_ALLOW_EMPTY_PASSWORD=1 \
		galera
		sleep infinity
  
  	docker run -d --restart=unless-stopped --net galera \
		--name node4 -h node4 --ip 172.20.0.104 \
		-p 3314:3306 \
		-v /srv/galera/node4.cnf:/etc/mysql/conf.d/galera.cnf \
		-v /srv/galera/node4:/var/lib/mysql \
		-e MYSQL_ALLOW_EMPTY_PASSWORD=1 \
		galera
		sleep infinity

	mysql -h 127.0.0.1 -P 3311 -u root -psecret_galera_password
[Projet_Replication_BDD_Quentin_CC (1).pdf](https://github.com/feur25/docker-mysql-replication/files/14692649/Projet_Replication_BDD_Quentin_CC.1.pdf)
