CREATE DATABASE gutsuljak;
use gutsuljak;

-- procduur 1
CREATE TABLE linnad(
	linnID int PRIMARY KEY identity (1,1),
	linnNimi varchar(30) unique,
	elanikeArv int not null,
	maakond varchar(25)
	);

	--Protseduur, mis lisab (INSERT) tabelisse andmed &
	-- kohe näitab (SELECT) tabeli
CREATE PROCEDURE lisaLinn
	@linnNimi varchar(30),
	@elanikeArv int,
	@maakond varchar(25)
AS
BEGIN
	INSERT INTO linnad(linnNimi,elanikeArv,maakond)
	VALUES (@linnNimi, @elanikeArv, @maakond);
	SELECT * FROM linnad;
END

-- kutse
Exec lisaLinn 'Tallinn', 650000, 'Harju';
Exec lisaLinn 'Tartu', 20000, 'Tartu';
Exec lisaLinn 'Pärnu', 30000, 'Pärnu';
Exec lisaLinn 'Keila', 1000, 'Harju';

-- protseduuri kustutamine
DROP Procedure lisaLinn;

-- prtotseduur, mis kustutab tabelist linnID järgi
CREATE PROCEDURE kustutaLinn
@id int
AS
BEGIN
SELECT * FROM linnad;
DELETE FROM linnad where linnID=@id;
SELECT * FROM linnad;
END

-- kutse 
EXEC kustutaLinn 4;
EXEC kustutaLinn @id=4;

-- protseduur mis uuendab tabeli ja suurendab elanike arv 10%
CREATE Procedure uuenaLinn
@arv decimal(5,2)
AS
BEGIN
SELECT * FROM linnad;
UPDATE linnad SET elanikeArv=elanikeArv*@arv;
SELECT * FROM linnad;
END

--kutse
EXEC uuenaLinn 0.05;
DROP Procedure uuenaLinn;
UPDATE linnad SET elanikeArv=20000 WHERE linnID=2;
SELECT * FROM linnad;
