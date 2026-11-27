CREATE TABLE Movie
(
    ID Int NOT NULL PRIMARY KEY auto_increment,
    Title varchar(100) NOT NULL,
    Year int NOT NULL DEFAULT 0,
    Rating varchar(10) NOT NULL DEFAULT '-', 
		   -- Enum('-', 'PERE', 'L', 'MS-6', 'MS-12', 'K-12', 'K-14', 'K-16', 'K-18') NOT NULL DEFAULT '-', 
    Drama char(1) NOT NULL DEFAULT 'N', -- Y or N
    Comedy char(1) NOT NULL DEFAULT 'N',
    Historical char(1) NOT NULL DEFAULT 'N',
    Disaster char(1) NOT NULL DEFAULT 'N',
    Criminal char(1) NOT NULL DEFAULT 'N',
    Action char(1) NOT NULL DEFAULT 'N',
    Adventure char(1) NOT NULL DEFAULT 'N',
    Cartoon char(1) NOT NULL DEFAULT 'N',
    Fantasy char(1) NOT NULL DEFAULT 'N',
    SciFi char(1) NOT NULL DEFAULT 'N',
    Fairytale char(1) NOT NULL DEFAULT 'N',
    Musical char(1) NOT NULL DEFAULT 'N',
    Thriller char(1) NOT NULL DEFAULT 'N',
    Horror char(1) NOT NULL DEFAULT 'N'
);

select * from Movie

/*
UPDATE Movie  SET Drama = CASE Drama WHEN 'J' THEN 'Y' ELSE 'N' END
UPDATE Movie  SET Comedy = CASE Comedy WHEN 'J' THEN 'Y' ELSE 'N' END
UPDATE Movie  SET Historical = CASE Historical WHEN 'J' THEN 'Y' ELSE 'N' END
UPDATE Movie  SET Disaster = CASE Disaster WHEN 'J' THEN 'Y' ELSE 'N' END
UPDATE Movie  SET Criminal = CASE Criminal WHEN 'J' THEN 'Y' ELSE 'N' END
UPDATE Movie  SET Action = CASE Action WHEN 'J' THEN 'Y' ELSE 'N' END
UPDATE Movie  SET Adventure = CASE Adventure WHEN 'J' THEN 'Y' ELSE 'N' END
UPDATE Movie  SET Cartoon = CASE Cartoon WHEN 'J' THEN 'Y' ELSE 'N' END
UPDATE Movie  SET Fantasy = CASE Fantasy WHEN 'J' THEN 'Y' ELSE 'N' END
UPDATE Movie  SET SciFi = CASE SciFi WHEN 'J' THEN 'Y' ELSE 'N' END
UPDATE Movie  SET Fairytale = CASE Fairytale WHEN 'J' THEN 'Y' ELSE 'N' END
UPDATE Movie  SET Musical = CASE Musical WHEN 'J' THEN 'Y' ELSE 'N' END
UPDATE Movie  SET Thriller = CASE Thriller WHEN 'J' THEN 'Y' ELSE 'N' END
UPDATE Movie  SET Horror = CASE Horror WHEN 'J' THEN 'Y' ELSE 'N' END
*/