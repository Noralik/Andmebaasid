CREATE DATABASE sigmas;
use sigmas;

CREATE TABLE firma (
firmaID INT NOT NULL PRIMARY KEY IDENTITY (1,1),
firmanimi VARCHAR(20) unique,
aadress VARCHAR(20),
telefon VARCHAR (20)
);

CREATE TABLE Praktikajuhendaja (
    praktikajuhendajaID INT PRIMARY KEY, 
    eesnimi VARCHAR(50), 
    perekonnanimi VARCHAR(50), 
    synniaeg DATE, 
    telefon VARCHAR(20)
);


CREATE TABLE praktikabaas (
praktikabaasID int NOT NULL PRIMARY KEY IDENTITY(1,1),
firmaID int,
praktikatingimused varchar(20),
arvutiprogramm varchar(20),
juhendajaID int,
FOREIGN KEY (firmaID) REFERENCES firma (firmaID),
FOREIGN KEY (juhendajaID) REFERENCES praktikajuhendaja(praktikajuhendajaID)
);

-- Täida kõik tabelid 5-10 kirjetega  SQL päringu abil.
INSERT INTO firma(firmanimi, aadress, telefon)
VALUES 
    ('SpqceX', 'Usa', '57841881'),
    ('Starbaks', 'HZlenovich', '9741055'),
    ('Audi', 'Sigmastik', '79115051'),
    ('Memasiks', 'Lopstik', '879018150'),
    ('slapmistik', 'Mustik', '454118499');

INSERT INTO Praktikajuhendaja(praktikajuhendajaID, eesnimi, perekonnanimi, telefon, synniaeg)
VALUES 
    (1, 'SpqceX', 'Usa', '57841881', '1980-05-12'),
    (2, 'Starbaks', 'HZlenovich', '9741055', '1992-08-23'),
    (3, 'Audi', 'Sigmastik', '79115051', '1987-12-09'),
    (4, 'Memasiks', 'Lopstik', '879018150', '1995-03-11'),
    (5, 'Slapmistik', 'Mustik', '454118499', '1999-11-29');


INSERT INTO praktikabaas(firmaID, praktikatingimused, arvutiprogramm, juhendajaID)
VALUES 
    (1, 'Töökogemus', 'MS Office', 1),
    (2, 'Internship', 'AutoCAD', 2),
    (3, 'Töötuba', 'SolidWorks', 3),
    (4, 'Projekt', 'MATLAB', 4),
    (5, 'Teadusprojekt', 'Python', 5);


select * from firma;
select * from Praktikajuhendaja;
select * from praktikabaas;

-- Kontroll

-- 1
SELECT * FROM firma
WHERE firmanimi LIKE '%a%';
-- 2
SELECT f.*, p.*
FROM firma f
JOIN praktikabaas p ON f.firmaID = p.firmaID
ORDER BY f.firmanimi;
-- 3
SELECT f.firmanimi, COUNT(p.praktikabaasID) AS praktikakohti
FROM firma f
JOIN praktikabaas p ON f.firmaID = p.firmaID
GROUP BY f.firmanimi;
-- 4
SELECT eesnimi, perekonnanimi FROM praktikajuhendaja WHERE synniaeg > '1980-01-01';
-- 5
SELECT MONTH(synniaeg) AS kuu, COUNT(*) AS juhendajaid
FROM praktikajuhendaja
GROUP BY MONTH(synniaeg)
ORDER BY kuu;
-- 6
SELECT j.eesnimi, j.perekonnanimi, COUNT(p.praktikabaasID) AS praktikakohti
FROM praktikajuhendaja j
LEFT JOIN praktikabaas p ON j.praktikajuhendajaID = p.juhendajaID
GROUP BY j.eesnimi, j.perekonnanimi;
-- 7
ALTER TABLE praktikajuhendaja
ADD palk DECIMAL(10, 2);
select * from Praktikajuhendaja
-- 8 
SELECT eesnimi, perekonnanimi, palk, palk * 0.20 AS tulumaks
FROM praktikajuhendaja;
-- 9
SELECT AVG(palk) AS keskmine_palk
FROM praktikajuhendaja;

-- 10
-- Päring 1: Kõik juhendajad, kelle palk on suurem kui 2000
SELECT eesnimi, perekonnanimi, palk
FROM praktikajuhendaja
WHERE palk > 2000;

-- Päring 2: Kõik firmad, kus on vähem kui 3 praktika kohta
SELECT f.firmanimi, COUNT(p.praktikabaasID) AS praktikakohti
FROM firma f
JOIN praktikabaas p ON f.firmaID = p.firmaID
GROUP BY f.firmanimi
HAVING COUNT(p.praktikabaasID) < 3;

-- Päring 3: Kõik praktikabaasid, kus kasutatakse AutoCAD programmi
SELECT p.praktikabaasID, p.arvutiprogramm
FROM praktikabaas p
WHERE p.arvutiprogramm = 'AutoCAD';


-- TRIGERID

CREATE TABLE Praktikabaas_logi (
    id INT IDENTITY(1,1) PRIMARY KEY, 
    kasutaja VARCHAR(50), 
    aeg DATETIME DEFAULT GETDATE(), 
    tegevus VARCHAR(50), 
    andmed VARCHAR(MAX)
);
select * from Praktikabaas_logi

-- 1 triger
CREATE TRIGGER trg_Insert_Praktikabaas_logi
ON praktikabaas
FOR INSERT
AS
BEGIN
    INSERT INTO Praktikabaas_logi (kasutaja, tegevus, aeg, andmed)
    SELECT
        SYSTEM_USER,    
        'praktikabaas on lisatud', 
        GETDATE(),                 
        CONCAT(
            inserted.firmaID, ', ',
            inserted.praktikatingimused, ', ',
            inserted.arvutiprogramm
        )
    FROM inserted;
END;

-- dorobotaniy     
USE [sigmas]
GO
/****** Object:  Trigger [dbo].[trg_Insert_Praktikabaas_logi]    Script Date: 12.05.2025 12:15:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER [dbo].[trg_Insert_Praktikabaas_logi]
ON [dbo].[praktikabaas]
FOR INSERT
AS
BEGIN
    INSERT INTO Praktikabaas_logi (kasutaja, tegevus, aeg, andmed)
    SELECT
        SYSTEM_USER,    
        'praktikabaas on lisatud', 
        GETDATE(),                 
        CONCAT(
            firma.firmanimi, ', ', 
			firma.aadress, ', ', 
			Praktikajuhendaja.perekonnanimi, ', ',
			Praktikajuhendaja.eesnimi, ', ',
            inserted.praktikatingimused, ', ',
            inserted.arvutiprogramm
        )
    FROM inserted 
	inner join firma on inserted.firmaID=firma.firmaID
	inner join Praktikajuhendaja on inserted.juhendajaID=Praktikajuhendaja.praktikajuhendajaID;
END;
-- 2 triger
CREATE TRIGGER trg_Delete_Praktikabaas_logi
ON praktikabaas
FOR DELETE
AS
BEGIN
    INSERT INTO Praktikabaas_logi (kasutaja, tegevus, aeg, andmed)
    SELECT
        SYSTEM_USER,
        'praktikabaas on kustutatud',
        GETDATE(),
        CONCAT(
            deleted.firmaID, ', ',
            deleted.praktikatingimused, ', ',
            deleted.arvutiprogramm
        )
    FROM deleted;
END;
-- 3 triger
CREATE TRIGGER trg_Update_Praktikabaas_logi
ON praktikabaas
FOR UPDATE
AS
BEGIN
    INSERT INTO Praktikabaas_logi (kasutaja, tegevus, aeg, andmed)
    SELECT
        SYSTEM_USER,
        'praktikabaas on uuendatud',
        GETDATE(),
        CONCAT(
            'vana andmed: ', 
            deleted.firmaID, ', ', deleted.praktikatingimused, ', ', deleted.arvutiprogramm,
            'uus andmed: ', 
            inserted.firmaID, ', ', inserted.praktikatingimused, ', ', inserted.arvutiprogramm
        )
    FROM deleted
    INNER JOIN inserted ON deleted.praktikabaasID = inserted.praktikabaasID;
END;



-- KONTROLL
SELECT name
FROM sys.triggers
WHERE parent_id = OBJECT_ID('praktikabaas');


select * from Praktikabaas;
-- ADD
INSERT INTO praktikabaas(firmaID, praktikatingimused, arvutiprogramm, juhendajaID)
VALUES 
    (5, 'Teadusprojekt', 'Python', 5);
select * from Praktikabaas_logi;
-- DELETE
DELETE FROM praktikabaas WHERE praktikabaasID=5;
-- UPDATE
UPDATE praktikabaas 
SET praktikatingimused = 'LinuxBSD', arvutiprogramm = 'C#'
WHERE praktikabaasID = 6;


-- 5 triger
CREATE TRIGGER trg_Check_Juhendaja_Synniaeg -- Создаёт тригер
ON praktikajuhendaja -- Триггер применяется к таблице praktikajuhendaja.
INSTEAD OF INSERT -- Тип триггера — INSTEAD OF INSERT, что означает, что триггер сработает вместо стандартной операции INSERT в таблицу.
AS -- Указывает начало блока SQL-кода, который будет выполнен при активации триггера
BEGIN -- Начало блока кода, который выполняется, если триггер сработал.
    IF EXISTS (SELECT 1 FROM inserted WHERE synniaeg > GETDATE()) --Эта строка проверяет, есть ли в таблице inserted строки, у которых дата рождения больше текущей даты.
    BEGIN -- Если условие в предыдущей строке выполняется, начинается блок кода, который будет выполнен.
        RAISERROR('Sünniaeg ei tohi olla tulevikus.', 16, 1); -- Если в предыдущей проверке обнаружены строки с некорректной датой рождения, будет выброшена ошибка с сообщением и кодом ошибки 16 и состоянием 1.
    END -- Завершение блока кода, выполняющегося в случае ошибки.
    ELSE -- Если условие проверки на дату не выполнено (то есть все даты рождения валидны), выполняется блок кода после ELSE.
    BEGIN -- Начало блока, который будет выполнен, если дата рождения не больше текущей даты.
        INSERT INTO praktikajuhendaja (eesnimi, perekonnanimi, synniaeg, telefon) -- INSERT INTO praktikajuhendaja Здесь происходит вставка данных в таблицу praktikajuhendaja. Вставляются значения для столбцов eesnimi, perekonnanimi, synniaeg и telefon
        SELECT eesnimi, perekonnanimi, synniaeg, telefon -- SELECT eesnimi, perekonnanimi, synniaeg, telefon FROM inserted; Вставка данных из виртуальной таблицы inserted, которая содержит те же данные, что и попытка вставки в таблицу. Данные вставляются в таблицу praktikajuhendaja.
        FROM inserted; -- Строка FROM inserted; в контексте триггера в SQL означает, что данные, которые были попыткой вставки в таблицу, доступны через виртуальную таблицу inserted
    END -- Завершение блока кода, который выполняется при корректной вставке данных.
END; -- Завершение блока кода триггера в целом.
-- Если дата рождения (поле synniaeg) для новой строки в таблице praktikajuhendaja больше текущей даты, то вставка данных будет отклонена, и будет сгенерирована ошибка.
-- Если дата рождения валидна, то данные вставляются в таблицу.Ы

-- Kontoll
-- ne rabotusie 
INSERT INTO praktikajuhendaja (eesnimi, perekonnanimi, synniaeg, telefon)
VALUES ('Мария', 'Тамм', '2050-01-01', '5551234');
-- rabotusie
INSERT INTO praktikajuhendaja (eesnimi, perekonnanimi, synniaeg, telefon)
VALUES ('Яан', 'Каск', '1990-05-01', '5555678');
select * from Praktikajuhendaja

