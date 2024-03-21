CREATE DATABASE IF NOT EXISTS biblio;
USE biblio;

CREATE TABLE IF NOT EXISTS books (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    author VARCHAR(100) NOT NULL,
    published_year INT UNSIGNED,
    reg_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE = InnoDB AUTO_INCREMENT = 100001;

-- Crée un utilisateur 'replicate' pour la réplication
CREATE USER 'replicate'@'%' IDENTIFIED WITH mysql_native_password BY 'password';

-- Autorise l'utilisateur 'replicate' à se connecter à distance
GRANT REPLICATION SLAVE ON *.* TO 'replicate'@'%';

-- Applique les changements immédiatement pour que les changements prennent effet
FLUSH PRIVILEGES;
