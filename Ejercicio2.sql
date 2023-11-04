
CREATE DATABASE Ejercicio2;
SHOW DATABASES;
use Ejercicio2;

-- Tabla Empleado
CREATE TABLE Empleado (
	   CI VARCHAR (10) PRIMARY KEY,
       NombreCompleto VARCHAR (30),
       Direccion VARCHAR (40),
       FechaNac DATE,
       Telefono VARCHAR (10)
);

-- Tabla Departamento
CREATE TABLE Departamento (
	   Num_D VARCHAR (10) PRIMARY KEY,
       Nombre_D VARCHAR (20),
       CantidadEmpleado VARCHAR (100)
);

-- Tabla Pertenece
CREATE TABLE Pertenece (
       Numero VARCHAR (10),
       CI VARCHAR (10),
       PRIMARY KEY (Numero, CI),
       FOREIGN KEY (CI) REFERENCES Empleado (CI),
       FOREIGN KEY (Numero) REFERENCES Departamento (Num_D)
);

-- Tabla Supervisor
CREATE TABLE Supervisor (
       CISupervisor VARCHAR (8),
       CIEmpleado VARCHAR (8),
       PRIMARY KEY (CISupervisor, CIEmpleado),
       FOREIGN KEY (CISupervisor) REFERENCES Empleado (CI),
       FOREIGN KEY (CIEmpleado) REFERENCES Empleado (CI)
);

-- Ingresar datos aleatorios en la tabla Empleado
INSERT INTO Empleado (CI, NombreCompleto, Direccion, FechaNac, Telefono) VALUES
("11111111", "Franco Mendez", "Ruta 8, KM25", "2001-06-13", "091111111"),
("22222222", "Juan Rodriguez", "Ruta 101, KM34500", "2002-08-25", "092222222");

-- Ingresar datos aleatorios en la tabla Departamento
INSERT INTO Departamento (Num_D, Nombre_D, CantidadEmpleado) VALUES 
("7", "Oficina", "55");

-- Ingresar datos aleatorios en la tabla Pertenece
INSERT INTO Pertenece (Numero, CI) VALUES
("7", "11111111"),
("7", "22222222");

-- Ingresar datos aleatorios en la tabla Supervisor
INSERT INTO Supervisor VALUES
("11111111", "11111111");
