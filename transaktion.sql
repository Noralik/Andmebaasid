CREATE DATABASE specter;
USE specter;
/*OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO*/
CREATE TABLE isik(
	ID INT P
	RIMARY KEY IDENTITY (1,1),
	eesnimi VARCHAR(50),
	sugu CHAR(1),
	sunnikuupaev date,
	aadress varchar(100),
	email varchar(50)
);
drop table isik;
/*OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO*/
CREATE TABLE oppeaine(
	ID INT PRIMARY KEY IDENTITY (1,1),
	nimi varchar(100),
	vastutav_opetaja int,
	aine_kestus varchar(50)
);
drop table oppeaine;
/*OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO*/
CREATE TABLE oppimine(
	ID INT PRIMARY KEY IDENTITY (1,1),
	isiku_id int,
	oppeaine_id int,
	hinne int
);
drop table oppimine;
/*OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO*/
ALTER TABLE oppeaine
ADD CONSTRAINT FK_oppeaine_vastutav_opetaja
FOREIGN KEY (vastutav_opetaja) REFERENCES isik(ID);

ALTER TABLE oppimine
ADD CONSTRAINT FK_oppimine_isiku
FOREIGN KEY (isiku_id) REFERENCES isik(ID);

ALTER TABLE oppimine
ADD CONSTRAINT FK_oppimine_oppeaine
FOREIGN KEY (oppeaine_id) REFERENCES oppeaine(ID);
/*OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO*/
GRANT INSERT, SELECT ON isik TO opilaneJaramir;
GRANT INSERT, SELECT ON oppeaine TO opilaneJaramir;
GRANT INSERT, SELECT ON oppimine TO opilaneJaramir;
GRANT CREATE TABLE TO opilaneJaramir;

UPDATE oppimine
SET hinne = 4
WHERE ID = 3;
select * from oppimine;
/*OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO*/
CREATE TABLE logi (
    id INT IDENTITY(1,1) PRIMARY KEY, 
    kasutaja VARCHAR(50), 
    kuupaev DATETIME DEFAULT GETDATE(), 
    sisestatudAndmed VARCHAR(MAX)
);
select * from logi;
drop table logi;
/*OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO*/
CREATE TRIGGER Insert_logi
ON oppimine
FOR INSERT
AS
BEGIN
    INSERT INTO logi (kasutaja, kuupaev, sisestatudAndmed)
    SELECT
        SYSTEM_USER,
        GETDATE(),
        CONCAT(
            'oppimine on loo, ',
            inserted.ID, ', ',
            inserted.isiku_id, ', ',
            inserted.oppeaine_id, ', ',
            inserted.hinne
        )
    FROM inserted;
END;
drop trigger Insert_logi;
/*OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO*/
CREATE TRIGGER Update_logi
ON oppimine
FOR UPDATE
AS
BEGIN
    INSERT INTO logi (kasutaja, kuupaev, sisestatudAndmed)
    SELECT
        SYSTEM_USER,
        GETDATE(),
        CONCAT(
            'oppimine on uuendatud, ',
            inserted.ID, ', ',
            inserted.isiku_id, ', ',
            inserted.oppeaine_id, ', ',
            inserted.hinne
        )
    FROM inserted;
END;
drop trigger Update_logi;
/*OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO*/
/*OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO*/
/*OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO*/
/*OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO*/





BEGIN TRANSACTION;
select * from isik;

INSERT INTO isik (eesnimi, sugu, sunnikuupaev, aadress, email)
VALUES ('вцццв', 'N', '2000-05-10', 'цввц', 'вццв@вцвц.com');

SAVE TRANSACTION MySavepoint;
DELETE FROM isik WHERE id = 4;

-- Откат к savepoint, чтобы отменить только последнюю вставку
ROLLBACK TRANSACTION MySavepoint;
SELECT * FROM isik;

COMMIT TRANSACTION;
