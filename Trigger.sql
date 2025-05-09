CREATE DATABASE TiTtriger;
use TiTtriger;
/* VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV */
-- tabel, mida automaatselt täidab triger
CREATE TABLE logi(
	id int primary key identity(1,1),
	tegevus varchar(50),
	kasutaja varchar(25),
	aeg datetime,
	andmed text
);
drop logi;
select * from logi
/* VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV */
-- tabel. millega töötab kasutaja
CREATE TABLE puud(
	puuId int primary key identity(1,1),
	puuNimi varchar(50),
	pikkus int,
	aasta int
);
drop puud;
select * from puud
/* VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV */
insert into puud(puuNimi, pikkus, aasta)
VALUES 
	('Dub', 2.5, 40),
	('ell', 5, 60),
	('Berezha', 6.5, 80);
/* VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV */
CREATE TRIGGER puuLisamine
ON puud
FOR INSERT
AS
INSERT INTO logi(kasutaja, tegevus, aeg, andmed)
SELECT
    SYSTEM_USER,
    'puu on lisatud',
    GETDATE(),
    CONCAT(inserted.puuNimi, ', ', inserted.pikkus, ', ', inserted.aasta)
FROM inserted;

INSERT INTO puud(puuNimi, pikkus, aasta)
VALUES ('Tamm', 5, 89);
select * from puud;
select * from logi;
/* VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV */
-- triger, mis jälgib tabelis kustutamine
CREATE TRIGGER puuKustutamine
ON puud
FOR DELETE
AS
INSERT INTO logi(kasutaja, tegevus, aeg, andmed)
SELECT
    SYSTEM_USER,
    'puu on kustatud',
    GETDATE(),
    CONCAT(deleted.puuNimi, ', ', deleted.pikkus, ', ', deleted.aasta)
FROM deleted;
DELETE FROM puud WHERE puuId=1;
select * from puud;
select * from logi;

-- kontoll
drop trigger puuKustutamine;

-- triger, mis jälgib tabelis uuendamine
CREATE TRIGGER puuUuendamine
ON puud
FOR UPDATE
AS
INSERT INTO logi(kasutaja, tegevus, aeg, andmed)
SELECT
    SYSTEM_USER,
    'puu on uuendatud',
    GETDATE(),
    CONCAT(
		'vana puu info - ', deleted.puuNimi, ', ', deleted.pikkus, ', ', deleted.aasta,
		'uus puu info - ', inserted.puuNimi, ', ', inserted.pikkus, ', ', inserted.aasta
	)
FROM deleted INNER JOIN inserted
on deleted.puuId=inserted.puuId

-- kontoll 
select * from puud;
select * from logi;
update puud SET pikkus=99, aasta=2000
WHERE puuId=7;
select * from puud;
select * from logi; 
