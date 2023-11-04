
CREATE DATABASE TareaCine;
SHOW DATABASES;
use TareaCine;

-- Tabla de Cines
CREATE TABLE Cines (
    Nombre VARCHAR(100) PRIMARY KEY,
    Ciudad VARCHAR(100)
);

-- Tabla de Películas
CREATE TABLE Peliculas (
    Codigo INT PRIMARY KEY,
    Nombre VARCHAR(100)
);

-- Tabla de Funciones
CREATE TABLE Funciones (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Cine VARCHAR(100),
    Pelicula INT,
    FechaHora DATETIME,
    FOREIGN KEY (Cine) REFERENCES Cines(Nombre),
    FOREIGN KEY (Pelicula) REFERENCES Peliculas(Codigo)
);

-- Ingresar datos aleatorios en la tabla de Cines
INSERT INTO Cines (Nombre, Ciudad) VALUES
    ('CineCity 1', 'Ciudad A'),
    ('CineWorld 2', 'Ciudad B'),
    ('CineMax 3', 'Ciudad C');

-- Ingresar datos aleatorios en la tabla de Películas
INSERT INTO Peliculas (Codigo, Nombre) VALUES
    (1, 'Pelicula 1'),
    (2, 'Pelicula 2'),
    (3, 'Pelicula 3');

-- Ingresar datos aleatorios en la tabla de Funciones
INSERT INTO Funciones (Cine, Pelicula, FechaHora) VALUES
    ('CineCity 1', 1, '2023-10-15 18:00:00'),
    ('CineCity 1', 2, '2023-10-15 20:30:00'),
    ('CineWorld 2', 1, '2023-10-15 19:15:00'),
    ('CineMax 3', 3, '2023-10-16 14:00:00');

