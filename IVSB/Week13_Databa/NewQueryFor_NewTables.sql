/*
    1. BASIC TASKS
*/
    -- 1) Select titles of comedy movies
    SELECT M.Title
    FROM Movie M
    JOIN MovieGenre MG ON M.ID = MG.MovieID
    JOIN Genre G ON MG.GenreID = G.ID
    WHERE G.Name = 'Comedy';


    -- 2) Only criminal + adventures
    SELECT M.Title
    FROM Movie M
    JOIN MovieGenre MG ON M.ID = MG.MovieID
    JOIN Genre G ON MG.GenreID = G.ID
    WHERE G.Name IN ('Criminal', 'Adventure')
    GROUP BY M.ID, M.Title
    HAVING COUNT(DISTINCT G.Name) = 2;


    -- 3) Movies from 2009 which are MS-12
    SELECT M.Title
    FROM Movie M
    JOIN Rating R ON M.RatingID = R.ID
    WHERE M.ReleaseYear = 2009
    AND R.Name = 'MS-12';



/*
    2. GROUP BY

    How many of different rating Drama movies
    were there each year?
*/
    SELECT
        M.ReleaseYear AS Year,
        R.Name AS Rating,
        COUNT(*) AS MovieCount
    FROM Movie M
    JOIN Rating R ON M.RatingID = R.ID
    JOIN MovieGenre MG ON M.ID = MG.MovieID
    JOIN Genre G ON MG.GenreID = G.ID
    WHERE G.Name = 'Drama'
    GROUP BY M.ReleaseYear, R.Name
    ORDER BY M.ReleaseYear, R.Name;


/*
    3. CASE

    How many cool and boring movies there were each year?

    Cool: K-16, K-18
    Boring: PERE, K-14, MS-12, MS-6 etc.
*/
    SELECT
        M.ReleaseYear AS Year,

        SUM(CASE
            WHEN R.Name IN ('K-16', 'K-18') THEN 1
            ELSE 0
        END) AS CoolMovies,

        SUM(CASE
            WHEN R.Name IN ('PERE', 'K-14', 'MS-12', 'MS-6') THEN 1
            ELSE 0
        END) AS BoringMovies

    FROM Movie M
    JOIN Rating R ON M.RatingID = R.ID
    GROUP BY M.ReleaseYear
    ORDER BY M.ReleaseYear;

