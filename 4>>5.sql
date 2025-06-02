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

CREATE TRIGGER Delete_logi
ON Voistlus
FOR DELETE
AS
BEGIN
    INSERT INTO logi (kasutaja, kuupaev, tegevus, andmed)
    SELECT
        SYSTEM_USER,
        GETDATE(),
        'deletes',
        CONCAT(
            'Kustutatud andmed: ',
            'VoistlusID=', deleted.VoistlusID, ', ',
            'VoistlusNimi=', deleted.VoistlusNimi, ', ',
            'OsalejateArv=', deleted.OsalejateArv, ', ',
            'TurniirID=', deleted.TurniirID
        )
    FROM deleted;
END;
/*PEREHOD*/
CREATE TRIGGER Insert_logi
ON Voistlus
FOR INSERT
AS
BEGIN
    INSERT INTO logi (kasutaja, kuupaev, tegevus, andmed)
    SELECT
        SYSTEM_USER,
        GETDATE(),
        'Lootes',
        CONCAT(
            'Lisatud andmed: ',
            'VoistlusID=', inserted.VoistlusID, ', ',
            'VoistlusNimi=', inserted.VoistlusNimi, ', ',
            'OsalejateArv=', inserted.OsalejateArv, ', ',
            'TurniirID=', inserted.TurniirID
        )
    FROM inserted;
END;
/*PEREHOD*/
SELECT * FROM logi;

INSERT INTO Turniir (TurniirNimi)
VALUES ('ddss');
INSERT INTO Voistlus (VoistlusNimi, OsalejateArv, TurniirID)
VALUES ('8888km ujuma', 8, 3);



/*FOR KASUTAJA*/
INSERT INTO Turniir (TurniirNimi)
VALUES ('Kevadturniir');

INSERT INTO Voistlus (VoistlusNimi, OsalejateArv, TurniirID)
VALUES ('100m jooks', 8, 1);

INSERT INTO Turniir (TurniirNimi)
VALUES ('Sigmassse');
INSERT INTO Voistlus (VoistlusNimi, OsalejateArv, TurniirID)
VALUES ('100m jooks', 8, 2);


DELETE FROM Voistlus WHERE VoistlusID = 3;

SELECT * FROM Voistlus;
SELECT * FROM Turniir;
SELECT * FROM logi;

