CREATE DATABASE `emadb`;
USE `emadb`;
CREATE TABLE users (
    id INT AUTO_INCREMENT NOT NULL DEFAULT 0 ,
    nombre varchar(255),
    edad int
    PRIMARY KEY (id)
    );   
