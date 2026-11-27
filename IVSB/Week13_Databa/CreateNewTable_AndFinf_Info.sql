/*
	-- 1) select titles of comedy movies
	SELECT Title
	FROM Movie
	WHERE Comedy = 'Y';

	-- 2) only criminal + adventures
	SELECT Title
	FROM Movie
	WHERE Criminal = 'Y'
	AND Adventure = 'Y';

	-- 3) 2009 which are MS-12
	SELECT Title
	FROM Movie
	WHERE Year = 2009
	AND Rating = 'MS-12';
*/


/*
-- 2

-- How many of different rating Drama movies were there each year?
SELECT Year, Rating, COUNT(*) AS MovieCount
FROM Movie
WHERE Drama = 'Y'
GROUP BY Year, Rating
ORDER BY Year, Rating;
*/




/*
	-- 3

	/*
	How many cool and boring movies there were each year?
	cool: K-16, K-18
	boring: PERE, K-14, MS-12, MS-6 etc 


	SELECT
		Year,
		SUM(CASE
			WHEN Rating IN ('K-16', 'K-18') THEN 1
			ELSE 0
		END) AS CoolMovies,

		SUM(CASE
			WHEN Rating IN ('PERE', 'K-14', 'MS-12', 'MS-6') THEN 1
			ELSE 0
		END) AS BoringMovies

	FROM Movie
	GROUP BY Year
	ORDER BY Year;
*/ 



-- 5 Exesissis
-- drop table Movie;
-- 1. Rating
CREATE TABLE Rating (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(10) NOT NULL UNIQUE
);

-- 2. Genre
CREATE TABLE Genre (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL UNIQUE
);

-- 3. Movie
CREATE TABLE Movie (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(100) NOT NULL,
    ReleaseYear SMALLINT NOT NULL,
    RatingID INT,

    FOREIGN KEY (RatingID)
        REFERENCES Rating(ID),

    CHECK (ReleaseYear BETWEEN 1888 AND 2100)
);

-- 4. MovieGenre
CREATE TABLE MovieGenre (
    MovieID INT NOT NULL,
    GenreID INT NOT NULL,

    PRIMARY KEY (MovieID, GenreID),

    FOREIGN KEY (MovieID)
        REFERENCES Movie(ID),

    FOREIGN KEY (GenreID)
        REFERENCES Genre(ID)
);

