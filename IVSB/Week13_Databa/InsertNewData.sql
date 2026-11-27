SELECT @movie_id, ID FROM Genre WHERE Name IN ('Horror', 'Adventure');

INSERT INTO Movie (Title, ReleaseYear, RatingID)
SELECT 'F1', 2025, ID FROM Rating WHERE Name = '-';
SET @movie_id = LAST_INSERT_ID();
INSERT INTO MovieGenre (MovieID, GenreID)
SELECT @movie_id, ID FROM Genre WHERE Name IN ('Thriller');

INSERT INTO Movie (Title, ReleaseYear, RatingID)
SELECT 'The Phoenician Scheme', 2010, ID FROM Rating WHERE Name = 'MS-12';
SET @movie_id = LAST_INSERT_ID();
INSERT INTO MovieGenre (MovieID, GenreID)
SELECT @movie_id, ID FROM Genre WHERE Name IN ('Drama', 'Thriller');

INSERT INTO Movie (Title, ReleaseYear, RatingID)
SELECT 'A Minecraft Movie', 2011, ID FROM Rating WHERE Name = 'K-16';
SET @movie_id = LAST_INSERT_ID();
INSERT INTO MovieGenre (MovieID, GenreID)
SELECT @movie_id, ID FROM Genre WHERE Name IN ('Comedy', 'Cartoon');

INSERT INTO Movie (Title, ReleaseYear, RatingID)
SELECT 'The Running Man', 2012, ID FROM Rating WHERE Name = 'PERE';
SET @movie_id = LAST_INSERT_ID();
INSERT INTO MovieGenre (MovieID, GenreID)
SELECT @movie_id, ID FROM Genre WHERE Name IN ('Criminal', 'Adventure');

INSERT INTO Movie (Title, ReleaseYear, RatingID)
SELECT 'Tron: Ares', 2013, ID FROM Rating WHERE Name = 'MS-12';
SET @movie_id = LAST_INSERT_ID();
INSERT INTO MovieGenre (MovieID, GenreID)
SELECT @movie_id, ID FROM Genre WHERE Name IN ('Horror');

INSERT INTO Movie (Title, ReleaseYear, RatingID)
SELECT 'Zootopia 2', 2014, ID FROM Rating WHERE Name = 'K-16';
SET @movie_id = LAST_INSERT_ID();
INSERT INTO MovieGenre (MovieID, GenreID)
SELECT @movie_id, ID FROM Genre WHERE Name IN ('Drama', 'Thriller', 'Musical');

INSERT INTO Movie (Title, ReleaseYear, RatingID)
SELECT 'Avatar: Fire and Ash', 2015, ID FROM Rating WHERE Name = 'L';
SET @movie_id = LAST_INSERT_ID();
INSERT INTO MovieGenre (MovieID, GenreID)
SELECT @movie_id, ID FROM Genre WHERE Name IN ('Comedy', 'Musical');

INSERT INTO Movie (Title, ReleaseYear, RatingID)
SELECT 'The Odyssey', 2016, ID FROM Rating WHERE Name = 'K-12';
SET @movie_id = LAST_INSERT_ID();
INSERT INTO MovieGenre (MovieID, GenreID)
SELECT @movie_id, ID FROM Genre WHERE Name IN ('Horror', 'Adventure');

INSERT INTO Movie (Title, ReleaseYear, RatingID)
SELECT 'Project Hail Mary', 2017, ID FROM Rating WHERE Name = 'K-18';
SET @movie_id = LAST_INSERT_ID();
INSERT INTO MovieGenre (MovieID, GenreID)
SELECT @movie_id, ID FROM Genre WHERE Name IN ('Fantasy');

INSERT INTO Movie (Title, ReleaseYear, RatingID)
SELECT 'The Last Signal', 2018, ID FROM Rating WHERE Name = 'L';
SET @movie_id = LAST_INSERT_ID();
INSERT INTO MovieGenre (MovieID, GenreID)
SELECT @movie_id, ID FROM Genre WHERE Name IN ('Drama', 'Criminal');

INSERT INTO Movie (Title, ReleaseYear, RatingID)
SELECT 'Midnight at North Station', 2019, ID FROM Rating WHERE Name = 'K-12';
SET @movie_id = LAST_INSERT_ID();
INSERT INTO MovieGenre (MovieID, GenreID)
SELECT @movie_id, ID FROM Genre WHERE Name IN ('Comedy', 'Cartoon');

INSERT INTO Movie (Title, ReleaseYear, RatingID)
SELECT 'Shadows of the Old City', 2020, ID FROM Rating WHERE Name = '-';
SET @movie_id = LAST_INSERT_ID();
INSERT INTO MovieGenre (MovieID, GenreID)
SELECT @movie_id, ID FROM Genre WHERE Name IN ('Horror', 'Adventure');

INSERT INTO Movie (Title, ReleaseYear, RatingID)
SELECT 'The Glass Horizon', 2021, ID FROM Rating WHERE Name = 'MS-6';
SET @movie_id = LAST_INSERT_ID();
INSERT INTO MovieGenre (MovieID, GenreID)
SELECT @movie_id, ID FROM Genre WHERE Name IN ('Drama', 'Thriller');

INSERT INTO Movie (Title, ReleaseYear, RatingID)
SELECT 'Beyond the Red Planet', 2022, ID FROM Rating WHERE Name = 'K-14';
SET @movie_id = LAST_INSERT_ID();
INSERT INTO MovieGenre (MovieID, GenreID)
SELECT @movie_id, ID FROM Genre WHERE Name IN ('Drama', 'Historical');

INSERT INTO Movie (Title, ReleaseYear, RatingID)
SELECT 'A Song for Winter', 2023, ID FROM Rating WHERE Name = '-';
SET @movie_id = LAST_INSERT_ID();
INSERT INTO MovieGenre (MovieID, GenreID)
SELECT @movie_id, ID FROM Genre WHERE Name IN ('Comedy', 'Adventure');

INSERT INTO Movie (Title, ReleaseYear, RatingID)
SELECT 'The Clockmaker''s Secret', 2024, ID FROM Rating WHERE Name = 'MS-6';
SET @movie_id = LAST_INSERT_ID();
INSERT INTO MovieGenre (MovieID, GenreID)
SELECT @movie_id, ID FROM Genre WHERE Name IN ('Criminal', 'Adventure');

INSERT INTO Movie (Title, ReleaseYear, RatingID)
SELECT 'The Forgotten Kingdom', 2025, ID FROM Rating WHERE Name = 'K-16';
SET @movie_id = LAST_INSERT_ID();
INSERT INTO MovieGenre (MovieID, GenreID)
SELECT @movie_id, ID FROM Genre WHERE Name IN ('Thriller');

INSERT INTO Movie (Title, ReleaseYear, RatingID)
SELECT 'Echoes in the Deep', 2010, ID FROM Rating WHERE Name = 'PERE';
SET @movie_id = LAST_INSERT_ID();
INSERT INTO MovieGenre (MovieID, GenreID)
SELECT @movie_id, ID FROM Genre WHERE Name IN ('Drama', 'Musical');

INSERT INTO Movie (Title, ReleaseYear, RatingID)
SELECT 'The Last Lighthouse', 2011, ID FROM Rating WHERE Name = 'MS-12';
SET @movie_id = LAST_INSERT_ID();
INSERT INTO MovieGenre (MovieID, GenreID)
SELECT @movie_id, ID FROM Genre WHERE Name IN ('Comedy', 'Adventure');

INSERT INTO Movie (Title, ReleaseYear, RatingID)
SELECT 'Letters from Tomorrow', 2012, ID FROM Rating WHERE Name = 'K-16';
SET @movie_id = LAST_INSERT_ID();
INSERT INTO MovieGenre (MovieID, GenreID)
SELECT @movie_id, ID FROM Genre WHERE Name IN ('Horror', 'Adventure');

INSERT INTO Movie (Title, ReleaseYear, RatingID)
SELECT 'The Silent Carnival', 2013, ID FROM Rating WHERE Name = 'PERE';
SET @movie_id = LAST_INSERT_ID();
INSERT INTO MovieGenre (MovieID, GenreID)
SELECT @movie_id, ID FROM Genre WHERE Name IN ('Horror');
