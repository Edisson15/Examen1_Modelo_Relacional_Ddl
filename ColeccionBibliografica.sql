CREATE DATABASE ColeccionBibliografica


USE ColeccionBibliografica

-- Crear tabla TIPOPUBLICACION
CREATE TABLE TipoPublicacion(
    Id INT IDENTITY NOT NULL,
    Nombre VARCHAR(100) NOT NULL,
    CONSTRAINT pk_TipoPublicacion_Id PRIMARY KEY(Id)
)
--Crear los índices de la tabla TIPOPUBLICACION
CREATE UNIQUE INDEX ix_TipoPublicacion_Nombre
    ON TipoPublicacion(Nombre)

-- Crear tabla DESCRIPTOR
CREATE TABLE Descriptor(
    Id INT IDENTITY NOT NULL,
    Nombre VARCHAR(100) NOT NULL,
    CONSTRAINT pk_Descriptor_Id PRIMARY KEY(Id)
)
--Crear los índices de la tabla DESCRIPTOR
CREATE UNIQUE INDEX ix_Descriptor_Nombre
    ON Descriptor(Nombre)

-- Crear tabla AUTOR (individual o corporativo)
CREATE TABLE Autor(
    Id INT IDENTITY NOT NULL,
    Nombre VARCHAR(150) NOT NULL,
    IdAutor VARCHAR(50) NOT NULL, -- Individual / Corporativo
    CONSTRAINT pk_Autor_Id PRIMARY KEY(Id)
)
--Crear los índices de la tabla AUTOR
CREATE UNIQUE INDEX ix_Autor_Nombre
    ON Autor(Nombre)


-- Crear tabla PAIS
CREATE TABLE Pais(
    Id INT IDENTITY NOT NULL,
    Nombre VARCHAR(100) NOT NULL,
    CodigoAlfa VARCHAR(5) NOT NULL,
    Indicativo INT NULL,
    CONSTRAINT pk_Pais_Id PRIMARY KEY(Id)
)
--Crear los índices de la tabla PAIS
CREATE UNIQUE INDEX ix_Pais_Nombre
    ON Pais(Nombre)

CREATE UNIQUE INDEX ix_Pais_CodigoAlfa
    ON Pais(CodigoAlfa)

-- Crear tabla REGION
CREATE TABLE Region(
    Id INT IDENTITY NOT NULL,
    Nombre VARCHAR(100) NOT NULL,
    Codigo VARCHAR(10) NOT NULL,
    IdPais INT NOT NULL,
    CONSTRAINT pk_Region_Id PRIMARY KEY(Id),
    CONSTRAINT fk_Region_IdPais FOREIGN KEY(IdPais) REFERENCES Pais(Id)
)
--Crear los índices de la tabla REGION
CREATE UNIQUE INDEX ix_Region_Nombre
    ON Region(IdPais, Nombre)

-- Crear tabla CIUDAD
CREATE TABLE Ciudad(
    Id INT IDENTITY NOT NULL,
    Nombre VARCHAR(100) NOT NULL,
    IdRegion INT NOT NULL,
    CONSTRAINT pk_Ciudad_Id PRIMARY KEY(Id),
    CONSTRAINT fk_Ciudad_IdRegion FOREIGN KEY(IdRegion) REFERENCES Region(Id)
)
--Crear los índices de la tabla CIUDAD
CREATE UNIQUE INDEX ix_Ciudad_Nombre
    ON Ciudad(IdRegion, Nombre)

-- Crear tabla EDITORIAL
CREATE TABLE Editorial(
    Id INT IDENTITY NOT NULL,
    Nombre VARCHAR(150) NOT NULL,
    IdCiudad INT NOT NULL,
    CONSTRAINT pk_Editorial_Id PRIMARY KEY(Id),
    CONSTRAINT fk_Editorial_IdCiudad FOREIGN KEY(IdCiudad) REFERENCES Ciudad(Id)
)
--Crear los índices de la tabla EDITORIAL
CREATE UNIQUE INDEX ix_Editorial_Nombre
    ON Editorial(Nombre)


-- Crear tabla PUBLICACION
CREATE TABLE Publicacion(
    Id INT IDENTITY NOT NULL,
    Titulo VARCHAR(200) NOT NULL,
    Año INT NULL,
    IdTipoPublicacion INT NOT NULL,
    CONSTRAINT pk_Publicacion_Id PRIMARY KEY(Id),
    CONSTRAINT fk_Publicacion_IdTipo FOREIGN KEY(IdTipoPublicacion) REFERENCES TipoPublicacion(Id)
    
)
--Crear los índices de la tabla PUBLICACION
CREATE UNIQUE INDEX ix_Publicacion_Titulo
    ON Publicacion(Titulo, Año)

-- Crear tabla VOLUMEN 
CREATE TABLE Volumen(
    Id INT IDENTITY NOT NULL,
    Numero INT NOT NULL,
    Año INT NULL,
    IdPublicacion INT NOT NULL,
    CONSTRAINT pk_Volumen_Id PRIMARY KEY(Id),
    CONSTRAINT fk_Volumen_IdPublicacion FOREIGN KEY(IdPublicacion) REFERENCES Publicacion(Id)
)
--Crear los índices de la tabla VOLUMEN
CREATE INDEX ix_Volumen_IdPublicacion
    ON Volumen(IdPublicacion)

-- Crear tabla PUBLICACIONAUTOR
CREATE TABLE PublicacionAutor(
    IdPublicacion INT NOT NULL,
    IdAutor INT NOT NULL,
    CONSTRAINT pk_PublicacionAutor PRIMARY KEY(IdPublicacion, IdAutor),
    CONSTRAINT fk_PublicacionAutor_IdPublicacion FOREIGN KEY(IdPublicacion) REFERENCES Publicacion(Id),
    CONSTRAINT fk_PublicacionAutor_IdAutor FOREIGN KEY(IdAutor) REFERENCES Autor(Id)
);

-- Crear los indices de la tabla PUBLICACIONAUTOR
CREATE INDEX ix_PublicacionAutor_IdAutor
    ON PublicacionAutor(IdAutor);


-- Crear tabla PUBLICACIONDESCRIPTOR
CREATE TABLE PublicacionDescriptor(
    IdPublicacion INT NOT NULL,
    IdDescriptor INT NOT NULL,
    CONSTRAINT pk_PublicacionDescriptor PRIMARY KEY(IdPublicacion, IdDescriptor),
    CONSTRAINT fk_PublicacionDescriptor_IdPublicacion FOREIGN KEY(IdPublicacion) REFERENCES Publicacion(Id),
    CONSTRAINT fk_PublicacionDescriptor_IdDescriptor FOREIGN KEY(IdDescriptor) REFERENCES Descriptor(Id)
)
--Crear los índices de la tabla PUBLICACIONDESCRIPTOR
CREATE INDEX ix_PublicacionDescriptor_IdDescriptor
    ON PublicacionDescriptor(IdDescriptor)