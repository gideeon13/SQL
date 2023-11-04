CREATE DATABASE ConsultasPUB;

use ConsultasPUB;

CREATE TABLE Localidad (
    Cod_Localidad INT PRIMARY KEY,
    Nombre_L CHAR(50) NOT NULL
);

CREATE TABLE PUB (
    COD_PUB CHAR(10) PRIMARY KEY,
    Nombre_P CHAR(50) NOT NULL,
    Licencia_Fiscal CHAR(50) NOT NULL,
    Domicilio_P CHAR(50),
    Fecha_Apertura DATE NOT NULL,
    Horario CHAR(5) NOT NULL CHECK (Horario IN ('HOR1', 'HOR2', 'HOR3')),
    Cod_Localidad INT NOT NULL,
    FOREIGN KEY (Cod_Localidad) REFERENCES Localidad(Cod_Localidad)
);

CREATE TABLE Titular (
    DNI_TITULAR CHAR(10) PRIMARY KEY,
    Nombre_T CHAR(50) NOT NULL,
    Domicilio_T CHAR(50),
    COD_PUB CHAR(10) NOT NULL,
    FOREIGN KEY (COD_PUB) REFERENCES PUB(COD_PUB)
);

CREATE TABLE Empleado (
    DNI_EMPLEADO CHAR(10) PRIMARY KEY,
    Nombre_E CHAR(50) NOT NULL,
    Domicilio_E CHAR(50)
);

CREATE TABLE Existencias (
    COD_ARTICULO CHAR(10) PRIMARY KEY,
    Nombre_EX CHAR(50) NOT NULL,
    Cantidad INT NOT NULL,
    Precio FLOAT NOT NULL CHECK (Precio > 0),
    COD_PUB CHAR(10) NOT NULL,
    FOREIGN KEY (COD_PUB) REFERENCES PUB(COD_PUB)
);

CREATE TABLE Pub_Empleado (
    COD_PUB CHAR(10) NOT NULL,
    DNI_EMPLEADO CHAR(10) NOT NULL,
    FUNCION CHAR(20) NOT NULL CHECK (FUNCION IN ('CAMARERO', 'SEGURIDAD', 'LIMPIEZA')),
    PRIMARY KEY (COD_PUB, DNI_EMPLEADO),
    FOREIGN KEY (COD_PUB) REFERENCES PUB(COD_PUB),
    FOREIGN KEY (DNI_EMPLEADO) REFERENCES Empleado(DNI_EMPLEADO)
);

-- Inserción de datos aleatorios en la tabla Localidad
INSERT INTO Localidad (COD_LOCALIDAD, Nombre_L)
VALUES
    (1, 'Localidad1'),
    (2, 'Localidad2'),
    (3, 'Localidad3');

-- Inserción de datos aleatorios en la tabla Pub
INSERT INTO Pub (COD_PUB, Nombre_P, Licencia_Fiscal, Domicilio_P, Fecha_Apertura, Horario, COD_LOCALIDAD)
VALUES
    (1, 'Pub1', 'Licencia1', 'Domicilio1', '2023-01-15', 'HOR1', 1),
    (2, 'Pub2', 'Licencia2', 'Domicilio2', '2023-02-20', 'HOR2', 2),
    (3, 'Pub3', 'Licencia3', 'Domicilio3', '2023-03-25', 'HOR3', 3);

-- Inserción de datos aleatorios en la tabla Titular
INSERT INTO Titular (DNI_TITULAR, Nombre_T, Domicilio_T, COD_PUB)
VALUES
    ('DNI001', 'Titular1', 'Domicilio1', 1),
    ('DNI002', 'Titular2', 'Domicilio2', 2),
    ('DNI003', 'Titular3', 'Domicilio3', 3);

-- Inserción de datos aleatorios en la tabla Empleado
INSERT INTO Empleado (DNI_EMPLEADO, Nombre_E, Domicilio_E)
VALUES
    ('DNI101', 'Empleado1', 'Domicilio1'),
    ('DNI102', 'Empleado2', 'Domicilio2'),
    ('DNI103', 'Empleado3', 'Domicilio3');

-- Inserción de datos aleatorios en la tabla Existencias
INSERT INTO Existencias (COD_ARTICULO, Nombre_EX, Cantidad, Precio, COD_PUB)
VALUES
    (101, 'Articulo1', 100, 10.5, 1),
    (102, 'Articulo2', 200, 15.0, 2),
    (103, 'Articulo3', 150, 12.5, 3);

-- Inserción de datos aleatorios en la tabla Pub_Empleado
INSERT INTO Pub_Empleado (COD_PUB, DNI_EMPLEADO, FUNCION)
VALUES
    (1, 'DNI101', 'Camarero'),
    (2, 'DNI102', 'Seguridad'),
    (3, 'DNI103', 'Limpieza');

-- 1) Titular con mayor cantidad de empleados

SELECT T.DNI_TITULAR, T.Nombre_T AS Nombre_Titular, COUNT(PE.DNI_EMPLEADO) AS Cantidad_Empleados
FROM Titular AS T
LEFT JOIN Pub_Empleado AS PE ON T.DNI_TITULAR = PE.DNI_EMPLEADO
GROUP BY T.DNI_TITULAR, T.Nombre_T
ORDER BY Cantidad_Empleados DESC
LIMIT 1;

-- 2) Pub con menos existencias de un artículo en particular (especificando el código del artículo)

SELECT E.COD_PUB, P.Nombre_P AS Nombre_Pub, E.COD_ARTICULO, E.Nombre_EX AS Nombre_Articulo, E.Cantidad
FROM Existencias AS E
JOIN PUB AS P ON E.COD_PUB = P.COD_PUB
WHERE E.COD_ARTICULO = 101
ORDER BY E.Cantidad ASC
LIMIT 1;

-- 3) De qué localidad es un empleado en particular (especificando el DNI del empleado)

SELECT E.DNI_EMPLEADO, E.Nombre_E AS Nombre_Empleado, L.Nombre_L AS Nombre_Localidad
FROM Empleado AS E
JOIN Pub_Empleado AS PE ON E.DNI_EMPLEADO = PE.DNI_EMPLEADO
JOIN PUB AS P ON PE.COD_PUB = P.COD_PUB
JOIN Localidad AS L ON P.Cod_Localidad = L.COD_LOCALIDAD
WHERE E.DNI_EMPLEADO = 'DNI101';