-- Crée la base de données employees et la table users
CREATE DATABASE IF NOT EXISTS employees;
USE employees;

CREATE TABLE IF NOT EXISTS users (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    firstname VARCHAR(30) NOT NULL,
    lastname VARCHAR(30) NOT NULL,
    email VARCHAR(50),
    reg_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE = InnoDB AUTO_INCREMENT = 100000;

-- Crée un utilisateur 'replicate' pour la réplication
CREATE USER 'replicate'@'%' IDENTIFIED WITH mysql_native_password BY 'password';

-- Autorise l'utilisateur 'replicate' à se connecter à distance
GRANT REPLICATION SLAVE ON *.* TO 'replicate'@'%';

-- Applique les changements immédiatement pour que les changements prennent effet
FLUSH PRIVILEGES;
