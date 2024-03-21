CREATE DATABASE IF NOT EXISTS employees;
USE employees;

-- Crée un utilisateur pour la réplication de la base de données.
CREATE USER 'replicate'@'%' IDENTIFIED WITH mysql_native_password BY 'password';
-- Donne les droits de réplication à l'utilisateur.
GRANT REPLICATION SLAVE ON *.* TO 'replicate'@'%';
-- Applique les changements.
FLUSH PRIVILEGES;

-- Configure le serveur pour qu'il soit un esclave du serveur slave.
CHANGE MASTER TO MASTER_HOST='slave',
-- Utilisateur pour la réplication.
MASTER_USER='replicate',
MASTER_PASSWORD='password',
-- Active la réplication automatique.
MASTER_AUTO_POSITION=1;

-- Démarre la réplication.
START SLAVE;
