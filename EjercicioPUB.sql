DROP DATABASE EjercicioPUB;

-- Crear la base de datos EjercicioPUB
CREATE DATABASE EjercicioPUB;

-- Usar la base de datos EjercicioPUB
USE EjercicioPUB;

-- Creación de la tabla Localidad
CREATE TABLE Localidad (
    COD_LOCALIDAD NUMERIC PRIMARY KEY,
    Nombre_L VARCHAR(255) NOT NULL
);

-- Creación de la tabla Pub
CREATE TABLE Pub (
    COD_PUB NUMERIC PRIMARY KEY,
    Nombre_P VARCHAR(255) NOT NULL,
    Licencia_Fiscal VARCHAR(255) NOT NULL,
    Domicilio_P VARCHAR(255),
    Fecha_Apertura DATE NOT NULL,
    Horario VARCHAR(5) CHECK (Horario IN ('HOR1', 'HOR2', 'HOR3')),
    COD_LOCALIDAD NUMERIC REFERENCES Localidad(COD_LOCALIDAD)
);

-- Creación de la tabla Titular
CREATE TABLE Titular (
    DNI_TITULAR VARCHAR(10) PRIMARY KEY,
    Nombre_T VARCHAR(255) NOT NULL,
    Domicilio_T VARCHAR(255),
    COD_PUB NUMERIC REFERENCES Pub(COD_PUB)
);

-- Creación de la tabla Empleado
CREATE TABLE Empleado (
    DNI_EMPLEADO VARCHAR(10) PRIMARY KEY,
    Nombre_E VARCHAR(255) NOT NULL,
    Domicilio_E VARCHAR(255)
);

-- Creación de la tabla Existencias
CREATE TABLE Existencias (
    COD_ARTICULO NUMERIC PRIMARY KEY,
    Nombre_EX VARCHAR(255) NOT NULL,
    Cantidad NUMERIC NOT NULL,
    Precio NUMERIC CHECK (Precio > 0) NOT NULL,
    COD_PUB NUMERIC REFERENCES Pub(COD_PUB) 
);

-- Creación de la tabla Pub_Empleado
CREATE TABLE Pub_Empleado (
    COD_PUB NUMERIC REFERENCES Pub(COD_PUB),
    DNI_EMPLEADO VARCHAR(10) REFERENCES Empleado(DNI_EMPLEADO),
    FUNCION VARCHAR(255) CHECK (FUNCION IN ('Camarero', 'Seguridad', 'Limpieza'))
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
    (101, 'Articulo1', 100, 10, 1),
    (102, 'Articulo2', 200, 15, 2),
    (103, 'Articulo3', 150, 12, 3);

-- Inserción de datos aleatorios en la tabla Pub_Empleado
INSERT INTO Pub_Empleado (COD_PUB, DNI_EMPLEADO, FUNCION)
VALUES
    (1, 'DNI101', 'Camarero'),
    (2, 'DNI102', 'Seguridad'),
    (3, 'DNI103', 'Limpieza');