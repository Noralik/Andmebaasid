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

/*LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL*/
/*LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL*/
/*LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL*/
/*LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL*/


-- Create product_audits table
CREATE TABLE product_audits(
    change_id INT IDENTITY PRIMARY KEY,
    product_id INT NOT NULL,
    product_name VARCHAR(255) NOT NULL,
    brand_id INT NOT NULL,
    category_id INT NOT NULL,
    model_year SMALLINT NOT NULL,
    list_price DEC(10,2) NOT NULL,
    updated_at DATETIME NOT NULL,
    operation CHAR(3) NOT NULL,
    CHECK(operation = 'INS' OR operation = 'DEL')
);

-- Create product table
CREATE TABLE product (
    product_id INT IDENTITY PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    brand_id INT NOT NULL,
    category_id INT NOT NULL,
    model_year SMALLINT NOT NULL,
    list_price DECIMAL(10, 2) NOT NULL
);


CREATE TRIGGER trg_product_audit
ON product
AFTER INSERT, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO product_audits(
        product_id, 
        product_name,
        brand_id,
        category_id,
        model_year,
        list_price, 
        updated_at, 
        operation
    )
    SELECT
        i.product_id,
        i.product_name, 
        i.brand_id,  
        i.category_id,
        i.model_year,
        i.list_price,
        GETDATE(),
        'INS'
    FROM inserted i;

    INSERT INTO product_audits(
        product_id, 
        product_name,
        brand_id,
        category_id,
        model_year,
        list_price, 
        updated_at, 
        operation
    )
    SELECT
        d.product_id,
        d.product_name, 
        d.brand_id, 
        d.category_id, 
        d.model_year, 
        d.list_price,
        GETDATE(),
        'DEL'
    FROM deleted d;
END;


INSERT INTO product( 
    product_name, 
    brand_id, 
    category_id, 
    model_year, 
    list_price
)
VALUES (
    'Test product',
    1,
    1,
    2018,
    599
);

SELECT * FROM product_audits;

DELETE FROM 
    product
WHERE 
    product_id = 1;



