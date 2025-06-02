/*CREATE DATABSE*/
CREATE DATABASE specter;
drop database specter;
use specter;
use master;

/*CREATE TABELID*/
CREATE TABLE Turniir (
    TurniirID INT PRIMARY KEY  IDENTITY (1,1),
    TurniirNimi VARCHAR(37)
);
/*PEREHOD*/
CREATE TABLE Voistlus (
    VoistlusID INT PRIMARY KEY  IDENTITY (1,1),
    VoistlusNimi VARCHAR(52),
    OsalejateArv INT,
    TurniirID INT,
    FOREIGN KEY (TurniirID) REFERENCES Turniir(TurniirID)
);
/*PEREHOD*/
CREATE TABLE Osaleja (
    OsalejaID INT PRIMARY KEY  IDENTITY (1,1),
    OsalejaNimi VARCHAR(69),
    VoistlusID INT,
    FOREIGN KEY (VoistlusID) REFERENCES Voistlus(VoistlusID)
);
/*PEREHOD*/


/*FIRE KASUTAJA*/
GRANT SELECT, INSERT ON Turniir TO opilaneJaramir
GRANT SELECT, INSERT ON Voistlus TO opilaneJaramir
GRANT SELECT, INSERT ON Osaleja TO opilaneJaramir

/*Loo Logi*/
CREATE TABLE logi (
    id INT IDENTITY (1,1) PRIMARY KEY,
    kasutaja VARCHAR(50),
    kuupaev DATETIME DEFAULT CURRENT_TIMESTAMP,
    tegevus VARCHAR(50),
    andmed TEXT
);

/*PEREHOD*/
SELECT * FROM logi;

INSERT INTO Turniir (TurniirNimi) VALUES ('EEE');
INSERT INTO Turniir (TurniirNimi) VALUES ('KKK');

INSERT INTO Voistlus (VoistlusNimi, OsalejateArv, TurniirID)
VALUES ('100m jooks', 8, 3);

INSERT INTO Voistlus (VoistlusNimi, OsalejateArv, TurniirID)
VALUES ('200m jooks', 10, 4);


INSERT INTO Voistlus (VoistlusNimi, OsalejateArv, TurniirID)
VALUES ('500m jooks', 6, 999);

DELETE FROM Voistlus WHERE VoistlusID = 3;


select * from Osaleja
INSERT INTO Osaleja (OsalejaNimi)
	VALUES ('ee');

	select * from Voistlus
UPDATE Osaleja
SET VoistlusID = 4
WHERE OsalejaNimi = 'FFF';





/*OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO*/
CREATE TRIGGER Insert_Osaleja
ON Osaleja
AFTER INSERT
AS
BEGIN
    INSERT INTO logi (kasutaja, tegevus, andmed)
    SELECT
        SYSTEM_USER,
        'Osaleja lisatud',
        CONCAT(
            'Osaleja: ', i.OsalejaNimi, '; ',
            'Võistlus: ', v.VoistlusNimi
        )
    FROM inserted i
    INNER JOIN Voistlus v ON i.VoistlusID = v.VoistlusID
END;
/*PEREHOD*/ 
CREATE TRIGGER Update_Osaleja
ON Osaleja
AFTER UPDATE
AS
BEGIN
    INSERT INTO logi (kasutaja, tegevus, andmed)
    SELECT
        SYSTEM_USER,
        'Osaleja uuendatud',
        CONCAT(
            'Vanad andmed: OsalejaID=', d.OsalejaID, '; OsalejaNimi=', d.OsalejaNimi, '; VoistlusID=', CAST(d.VoistlusID AS NVARCHAR(10)), 
			/*"CAST(d.VoistlusID AS NVARCHAR(10)" 
			Это преобразование нужно для того, чтобы числовое поле VoistlusID можно было соединить с остальными текстовыми значениями в единую строку и записать в поле andmed.*/
            ' | Uued andmed: OsalejaID=', i.OsalejaID, '; OsalejaNimi=', i.OsalejaNimi, '; VoistlusID=', CAST(i.VoistlusID AS NVARCHAR(10))
        )
    FROM inserted i
    INNER JOIN deleted d ON i.OsalejaID = d.OsalejaID;
END;
drop trigger Update_Osaleja
/*PEREHOD*/
CREATE TRIGGER Delete_Osaleja
ON Osaleja
AFTER DELETE
AS
BEGIN
    INSERT INTO logi (kasutaja, tegevus, andmed)
    SELECT
        SYSTEM_USER,
        'Osaleja kustutatud',
        CONCAT(
            'Kustutatud osaleja: ', d.OsalejaNimi, '; ',
            'Võistlus: ', v.VoistlusNimi
        )
    FROM deleted d
    INNER JOIN Voistlus v ON d.VoistlusID = v.VoistlusID
END;
/*OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO*/
CREATE TRIGGER Insert_Turniir
ON Turniir
AFTER INSERT
AS
BEGIN
    INSERT INTO logi (kasutaja, tegevus, andmed)
    SELECT
        SYSTEM_USER,
        'Turniir lisatud',
        CONCAT('Turniir: ', TurniirNimi)
    FROM inserted;
END;
/*PEREHOD*/
CREATE TRIGGER Update_Turniir
ON Turniir
AFTER UPDATE
AS
BEGIN
    INSERT INTO logi (kasutaja, tegevus, andmed)
    SELECT
        SYSTEM_USER,
        'Turniir uuendatud',
        CONCAT('Uus nimi: ', TurniirNimi)
    FROM inserted;
END;
/*PEREHOD*/
CREATE TRIGGER Delete_Turniir
ON Turniir
AFTER DELETE
AS
BEGIN
    INSERT INTO logi (kasutaja, tegevus, andmed)
    SELECT
        SYSTEM_USER,
        'Turniir kustutatud',
        CONCAT('Kustutatud turniir: ', TurniirNimi)
    FROM deleted;
END;
/*OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO*/
CREATE TRIGGER Insert_Voistlus
ON Voistlus
AFTER INSERT
AS
BEGIN
    INSERT INTO logi (kasutaja, tegevus, andmed)
    SELECT
        SYSTEM_USER,
        'Võistlus lisatud',
        CONCAT(
            'Võistlus: ', v.VoistlusNimi, '; ',
            'Osalejate arv: ', v.OsalejateArv, '; ',
            'Turniir: ', t.TurniirNimi
        )
    FROM inserted v
    INNER JOIN Turniir t ON v.TurniirID = t.TurniirID;
END;
/*PEREHOD*/
CREATE TRIGGER Update_Voistlus
ON Voistlus
AFTER UPDATE
AS
BEGIN
    INSERT INTO logi (kasutaja, tegevus, andmed)
    SELECT
        SYSTEM_USER,
        'Võistlus uuendatud',
        CONCAT(
            'Võistlus: ', v.VoistlusNimi, '; ',
            'Osalejate arv: ', v.OsalejateArv, '; ',
            'Turniir: ', t.TurniirNimi
        )
    FROM inserted v
    INNER JOIN Turniir t ON v.TurniirID = t.TurniirID;
END;
/*PEREHOD*/
CREATE TRIGGER Delete_Voistlus
ON Voistlus
AFTER DELETE
AS
BEGIN
    INSERT INTO logi (kasutaja, tegevus, andmed)
    SELECT
        SYSTEM_USER,
        'Võistlus kustutatud',
        CONCAT(
            'Võistlus: ', v.VoistlusNimi, '; ',
            'Osalejate arv: ', v.OsalejateArv, '; ',
            'Turniir: ', t.TurniirNimi
        )
    FROM deleted v
    INNER JOIN Turniir t ON v.TurniirID = t.TurniirID;
END;
drop trigger Delete_Voistlus
drop trigger Update_Voistlus
drop trigger Insert_Voistlus










/*Protseddur*/
CREATE PROCEDURE AddOsaleja
    @OsalejaNimi VARCHAR(69),
    @VoistlusID INT
AS
BEGIN
    INSERT INTO Osaleja (OsalejaNimi, VoistlusID)
    VALUES (@OsalejaNimi, @VoistlusID);
END;
drop PROCEDURE AddOsaleja


SELECT * FROM logi;
select * from Osaleja;
select * from Voistlus
EXEC AddOsaleja @OsalejaNimi = 'Steve1', @VoistlusID = 5;

CREATE PROCEDURE DeleteOsaleja
	@OsalejaID INT
AS
BEGIN
    DECLARE @OsalejaNimi VARCHAR(69);
    DECLARE @VoistlusID INT;
    SELECT 
        @OsalejaNimi = OsalejaNimi,
        @VoistlusID = VoistlusID
    FROM Osaleja
    WHERE OsalejaID = @OsalejaID;

    DELETE FROM Osaleja
    WHERE OsalejaID = @OsalejaID;
END;

drop procedure DeleteOsaleja

SELECT * FROM logi;
select * from Turniir;
select * from Voistlus;
select * from Osaleja;
EXEC DeleteOsaleja @OsalejaID = 11;

/* CAST(@VoistlusID AS NVARCHAR(10) */
















select * from Turniir

CREATE PROCEDURE vaaranOsaleja
    @OsalejaNimi VARCHAR(37)
AS
BEGIN
    SELECT
        o.OsalejaNimi,
        v.VoistlusNimi,
        v.OsalejateArv,
        t.TurniirNimi
    FROM Osaleja o
    INNER JOIN Voistlus v ON o.VoistlusID = v.VoistlusID
	INNER JOIN Turniir t ON v.TurniirID = t.TurniirID
    WHERE o.OsalejaNimi = @OsalejaNimi;
END;


select * from Osaleja
select * from Turniir
EXEC vaaranOsaleja @OsalejaNimi = 'Steve1';	





INSERT INTO Osaleja (OsalejaNimi, VoistlusID)
VALUES ('Steve1', 6);

select * from Turniir
select * from Osaleja
