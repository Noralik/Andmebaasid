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

-- protseedur " 'search film' 1 täht
@taht CHAR 1
BEGIN
	SELECT filmNimetus, pikkus
    FROM film
    WHERE filmNimetus LIKE CONCAT(taht, '%');
END
--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- muudatus add/drop column
--ADD column
	--tabelinimi VARCHAR 25, veerunimi VARCHAR 25, tyyp VARCHAR 25
BEGIN

set @sqltegevus=concat('ALTER TABLE ', tabelinimi, ' ADD COLUMN ', veerunimi, ' ', tyyp);
PREPARE STMT FROM @sqltegevus;
EXECUTE STMT;

END
--DROP column
	--tabelinimi VARCHAR 25, veerunimi VARCHAR 25
BEGIN

set @sqltegevus=concat('ALTER TABLE ', tabelinimi, ' DROP COLUMN ', veerunimi);
PREPARE STMT FROM @sqltegevus;
EXECUTE STMT;

END;


--/////////////////////////////////////////////////////////////////////////////////////////////
-- pikkus
	--pikkus_val INT
BEGIN
DECLARE today TIMESTAMP DEFAULT CURRENT_DATE;
	SELECT today, filmNimetus, pikkus
    FROM film
    WHERE pikkus < pikkus_val;
END

-- FilmType search
-- 2d film... get_film_by_type
	-- type VARCHAR 3
BEGIN
SELECT f.filmNimetus, t.filmtype
FROM film f
INNER JOIN filmtype t ON f.filmtypeID=t.filmTypeID
AND t.filmType= type;
END

-- UPDATE RESIISOR
-- Dont work :(
BEGIN
    SELECT * FROM rezisoor;
    UPDATE rezisoor
    SET name = eesnimi, perenimi = perenimi
    WHERE rezisoorID = @rezisoorID;
    SELECT * FROM rezisoor;
END
