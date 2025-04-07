--("-- = kommentaar")
-- SQL Server Managment Stuudio
--(localdb)\mssqllocaldb
--Authentication: 
  -- Windows Auth -- admini õigused localhostis
  -- SQL Server Auth -- varem loodud kasutajad
-- New Query
--
CREATE DATABASE gutsuljak;
--Object Explorer on vaja pidevalt uuendada käsitsi!
USE gutsuljak;
--tabeli loomine
CREATE TABLE oplilane(
	opilane_ID int Primary Key identity(1,1),
	eesnimi varchar(25),
	perenimi varchar(25) Unique,
	synniaeg date,
	aadress TEXT,
	opilaskodu bit
);
-- select table
SELECT * FROM oplilane;

--tabeli kustutamine 
DROP table oplilane;

--andmete lisamine tabelisse
INSERT INTO oplilane(eesnimi, perenimi, synniaeg, aadress, opilaskodu)
VALUES 
    ('Gerald', 'Rodger', '1211-12-08', 'Rivia', '1'),
    ('Steve', 'Sigma', '2011-12-19', 'Minecraft', '0'),
    ('Lux', 'light', '2015-07-14', 'Demacia', '0'),
    ('Herobrine', 'Hero', '2013-12-19', 'Minecraft', '0'),
    ('Irelia', 'sword', '2017-07-14', 'Demacia', '0');
