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
            'Võistlus: ', v.VoistlusNimi, '; ',
            'Turniir: ', t.TurniirNimi
        )
    FROM inserted i
    INNER JOIN Voistlus v ON i.VoistlusID = v.VoistlusID
    INNER JOIN Turniir t ON v.TurniirID = t.TurniirID;
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
            'Uus osaleja: ', i.OsalejaNimi, '; ',
            'Võistlus: ', v.VoistlusNimi, '; ',
            'Turniir: ', t.TurniirNimi
        )
    FROM inserted i
    INNER JOIN Voistlus v ON i.VoistlusID = v.VoistlusID
    INNER JOIN Turniir t ON v.TurniirID = t.TurniirID;
END;
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
            'Võistlus: ', v.VoistlusNimi, '; ',
            'Turniir: ', t.TurniirNimi
        )
    FROM deleted d
    INNER JOIN Voistlus v ON d.VoistlusID = v.VoistlusID
    INNER JOIN Turniir t ON v.TurniirID = t.TurniirID;
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
    SET NOCOUNT ON;

    INSERT INTO logi (kasutaja, tegevus, andmed)
    SELECT
        SYSTEM_USER,
        'Võistlus lisatud',
        CONCAT(
            'Võistlus: ', v.VoistlusNimi, '; ',
            'Osalejate arv: ', v.OsalejateArv, '; ',
            'Turniir: ', t.TurniirNimi, '; ',
            'Osaleja: ', o.OsalejaNimi
        )
    FROM inserted v
    INNER JOIN Turniir t ON v.TurniirID = t.TurniirID
    INNER JOIN Osaleja o ON o.VoistlusID = v.VoistlusID;
END;
drop trigger  Insert_Voistlus
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
