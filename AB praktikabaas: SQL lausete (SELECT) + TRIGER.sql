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


-- 5 triger CREATE TRIGGER trg_Check_Juhendaja_Synniaeg
ON praktikajuhendaja
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted WHERE synniaeg > GETDATE())
    BEGIN
        RAISERROR('Sünniaeg ei tohi olla tulevikus.', 16, 1);
    END
    ELSE
    BEGIN
        INSERT INTO praktikajuhendaja (eesnimi, perekonnanimi, synniaeg, telefon)
        SELECT eesnimi, perekonnanimi, synniaeg, telefon
        FROM inserted;
    END
END;
