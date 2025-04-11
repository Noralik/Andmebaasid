--("-- = kommentaar")
-- XAMPP control Panel (Start Apache, Start MYsql)
-- Connect to
--Authentication: 
  -- kasutajanimi - root
  -- parool ei ole
-- sql
--
CREATE DATABASE gutsuljak;
--vali hiirega andmebaasi
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


CREATE TABLE oplilane( 
	opilane_ID int Primary Key AUTO_INCREMENT, 
	eesnimi varchar(25), 
	perenimi varchar(25) Unique, 
	synniaeg date, 
	aadress TEXT, 
	opilaskodu bit );

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

--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

--identity(1,1) автоматический счёт от 1 и до ...
CREATE TABLE ryhm(
	ryhm_ID int not null Primary Key AUTO_INCREMENT
	ryhm varchar(10) unique,
	osakond varchar(20)
);

SELECT * FROM ryhm;
-- Danger Zone
DROP table ryhm;

INSERT INTO ryhm(ryhm, osakond)
VALUES 
    ('TiTpv23', 'IT'),
	('TiTpv22', 'IT'),
	('Vlogpv23', 'Logistikat'),
	('Vlogpv22', 'Logistikat'),
	('MEHpv23', 'Mehanika'),
	('MEHpv22', 'Mehanika');

--lisame uus verg RyhmID tabelise opilnae
ALTER TABLE oplilane ADD ryhmID int;

--lisame foreign key veergule ryhmID mis on seotud
--tabeliga ryhm ja veerguga ryhmID
ALTER TABLE oplilane 
Add foreign key (ryhmID) references ryhm(ryhm_ID);

--foreign key kontroll
INSERT INTO oplilane(eesnimi, perenimi, synniaeg, aadress, opilaskodu, ryhmID)
VALUES 
    ('Sergei', 'Nichaev', '1958-05-09', 'novosibirsk', 1, 3);

SELECT * FROM oplilane JOIN ryhm
ON oplilane.ryhmID=ryhm.ryhm_ID;


SELECT oplilane.perenimi, ryhm.ryhm FROM oplilane JOIN ryhm
ON oplilane.ryhmID=ryhm.ryhm_ID;


SELECT o.perenimi, r.ryhm, o.aadress
FROM oplilane o JOIN ryhm r
ON o.ryhmID=r.ryhm_ID;

select * from oplilane 
select * from ryhm

--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CREATE TABLE hinne(
	hinne_ID int not null Primary AUTO_INCREMENT,
	opilane_ID int,
	hinne int,
	oppeaine VARCHAR(20)
);

INSERT INTO hinne (opilane_ID, hinne, oppeaine)
VALUES 
    (1, 4, 'minecraft'),
    (2, 2, 'osu'),
    (3, 1, 'dota 2'),
    (4, 3, 'calculator'),
    (5, 5, 'informatika');


ALTER TABLE oplilane ADD hinneID int;

ALTER TABLE oplilane 
Add foreign key (hinneID) references hinne(hinne_ID);

SELECT o.eesnimi, o.perenimi, h.oppeaine, h.hinne
FROM oplilane o
JOIN hinne h ON o.opilane_ID = h.opilane_ID;

--Sigam rabotaet /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
ALTER TABLE hinne
ADD foreign key (oplilane_ID) references oplilane(oplilaneID);

INSERT INTO hinne(oplilaneID, oppeaine, hinne)
Values(7, 'league',3);
select * from hinne;


-- alter table oplilane drop column hinneID;
-- delete from hinne where eesnimi = 'Gerald';


CREATE TABLE opetaja(
	opetaja_ID int not null Primary AUTO_INCREMENT,
	nimi VARCHAR(25),
	perenimi VARCHAR(35),
	telefon VARCHAR(20)
);

select * from ryhm 
select * from opetaja

ALTER TABLE ryhm ADD opetajaID int;

ALTER TABLE ryhm 
ADD FOREIGN KEY (opetajaID) REFERENCES opetaja(opetaja_ID);

INSERT INTO opetaja (nimi, perenimi, telefon)
VALUES 
	('Jekaterina', 'Rätsep', '55978151'),
	('Jekaterina', 'Rätsep', '55978151'),
	('Andrey', 'Lobanov', '59634512'),
	('Andrey', 'Lobanov', '59634512'),
	('Rein', 'Ausmees', '53489708'),
	('Rein', 'Ausmees', '53489708');
