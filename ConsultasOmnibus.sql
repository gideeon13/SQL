
CREATE DATABASE ConsultasOmnibus;
SHOW DATABASES;
use ConsultasOmnibus;

-- Tabla de Ómnibus
CREATE TABLE Omnibus (
    Matricula VARCHAR(10) PRIMARY KEY,
    Marca VARCHAR(50),
    Modelo VARCHAR(50),
    CapacidadAsientos INT
);

-- Crear la tabla de Comodidades con ID autoincremental
CREATE TABLE Comodidades (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(50)
);

-- Crear la tabla de Rutas con ID autoincremental
CREATE TABLE Rutas (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    NombreRuta VARCHAR(100)
);

-- Tabla de Paradas
CREATE TABLE Paradas (
    ID INT PRIMARY KEY,
    NombreParada VARCHAR(100),
    Coordenadas VARCHAR(50),
    RutaID INT,
    Kilometro INT
);

-- Tabla de Líneas de Ómnibus
CREATE TABLE LineasOmnibus (
    ID INT PRIMARY KEY,
    NombreLinea VARCHAR(100),
    EmpresaID INT
);

-- Tabla de Ómnibus por Línea
CREATE TABLE OmnibusPorLinea (
    ID INT PRIMARY KEY,
    OmnibusMatricula VARCHAR(10),
    LineaID INT
);

-- Tabla de Empresas de Ómnibus
CREATE TABLE EmpresasOmnibus (
    ID INT PRIMARY KEY,
    NombreEmpresa VARCHAR(100)
);

-- Tabla de Destinos
CREATE TABLE Destinos (
    ID INT PRIMARY KEY,
    NombreDestino VARCHAR(100)
);

-- Tabla de Paradas por Destino (si es necesario)
CREATE TABLE ParadasPorDestino (
    ID INT PRIMARY KEY,
    DestinoID INT,
    ParadaID INT
);

-- Ingresar datos en la tabla de Comodidades
INSERT INTO Comodidades (ID, Nombre) VALUES
    (1, 'Aire Acondicionado'),
    (2, 'Comida a Bordo'),
    (3, 'Asientos Cama');

-- Ingresar datos en la tabla de Rutas
INSERT INTO Rutas (ID, NombreRuta) VALUES
    (1, 'Ruta A'),
    (2, 'Ruta B');

-- Ingresar datos en la tabla de Paradas
INSERT INTO Paradas (ID, NombreParada, Coordenadas, RutaID, Kilometro) VALUES
    (1, 'Parada 1', '12.3456, -78.9012', 1, 5),
    (2, 'Parada 2', '12.6789, -78.3456', 1, 10),
    (3, 'Parada 3', '12.9876, -78.6789', 2, 3);

-- Ingresar datos en la tabla de Empresas de Ómnibus
INSERT INTO EmpresasOmnibus (ID, NombreEmpresa) VALUES
    (1, 'Empresa A'),
    (2, 'Empresa B');

-- Ingresar datos en la tabla de Destinos
INSERT INTO Destinos (ID, NombreDestino) VALUES
    (1, 'Destino X'),
    (2, 'Destino Y');

-- Ingresar datos en la tabla de Ómnibus
INSERT INTO Omnibus (Matricula, Marca, Modelo, CapacidadAsientos) VALUES
    ('ABC123', 'Marca1', 'Modelo1', 50),
    ('DEF456', 'Marca2', 'Modelo2', 40);

-- Ingresar datos en la tabla de Líneas de Ómnibus
INSERT INTO LineasOmnibus (ID, NombreLinea, EmpresaID) VALUES
    (1, 'Línea 1', 1),
    (2, 'Línea 2', 2);

-- Ingresar datos en la tabla de Ómnibus por Línea proporcionando un valor para ID
INSERT INTO OmnibusPorLinea (ID, OmnibusMatricula, LineaID) VALUES
    (1, 'ABC123', 1),
    (2, 'DEF456', 2);

-- 1) Linea con menos omnibus.
SELECT LineaID, COUNT(*) AS CantidadOmnibus
FROM OmnibusPorLinea
GROUP BY LineaID
ORDER BY CantidadOmnibus ASC
LIMIT 1;

-- 2) Ruta con más paradas.
SELECT RutaID, COUNT(*) AS CantidadParadas
FROM Paradas
GROUP BY RutaID
ORDER BY CantidadParadas DESC
LIMIT 1;

-- 3) Promedio de destinos por empresa.
SELECT e.NombreEmpresa, AVG(subquery.CantidadDestinos)
FROM EmpresasOmnibus e
LEFT JOIN (
    SELECT d.DestinoID, COUNT(*) AS CantidadDestinos
    FROM ParadasPorDestino d
    GROUP BY d.DestinoID
) subquery ON e.ID = subquery.DestinoID
GROUP BY e.NombreEmpresa;

-- 4) Linea con mayor capacidad en asientos entre todos sus omnibus.
SELECT l.NombreLinea, MAX(o.CapacidadAsientos) AS CapacidadMaxima
FROM LineasOmnibus l
JOIN OmnibusPorLinea ol ON l.ID = ol.LineaID
JOIN Omnibus o ON ol.OmnibusMatricula = o.Matricula
GROUP BY l.NombreLinea
ORDER BY CapacidadMaxima DESC
LIMIT 1;

-- 5) Rutas que NO pasen por una parada en particular.  (reemplazar 'Parada 1' con el nombre de la parada que se desea verificar)
SELECT R.NombreRuta
FROM Rutas R
WHERE R.ID NOT IN (SELECT RutaID FROM Paradas WHERE NombreParada = 'Parada 1');
