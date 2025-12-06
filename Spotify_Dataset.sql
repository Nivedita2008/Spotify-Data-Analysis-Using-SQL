-- SQL PROJECT -- SPOTIFY DATASET
drop TABLE spotify;
CREATE TABLE spotify(
Artist VARCHAR(255),
Track VARCHAR(255),
Album VARCHAR(255),	
Album_type VARCHAR(50),
Danceability FLOAT,
Energy FLOAT,
Loudness FLOAT,	
Speechiness FLOAT,	
Acousticness FLOAT,	
Instrumentalness FLOAT,
Liveness FLOAT,
Valence	FLOAT,
Tempo FLOAT,
Duration_min FLOAT,
Title VARCHAR(255),
Channel	VARCHAR(255),
Views FLOAT,
Likes FLOAT,	
Comments BIGINT,
Licensed BOOLEAN,
official_video BOOLEAN,
Stream BIGINT,
EnergyLiveness FLOAT,
most_playedon VARCHAR(50)
);
SELECT * FROM spotify;

SELECT COUNT(*) FROM spotify; -- 20594

SELECT COUNT(DISTINCT Artist) FROM spotify; -- 2074

SELECT DISTINCT Album_type FROM spotify; -- "album","compilation","single"

SELECT MAX(Duration_min) FROM spotify; -- 77.9343

SELECT 
MIN(Duration_min) 
FROM spotify; -- 0

SELECT 
DISTINCT most_playedon 
FROM spotify; 
-- "Youtube","Spotify"

SELECT * FROM spotify 
WHERE Duration_min = 0;

DELETE FROM spotify 
WHERE Duration_min = 0;
-- ----------------------------
-- DATA ANALYSIS -EASY CATEGORY
-- ----------------------------
--Q1. Retrieve the names of all tracks that have more than 1 billion streams.
SELECT 
  Track,
  stream 
FROM spotify 
WHERE stream > 1000000000;

--Q2. List all the albums along with their respective artists.
SELECT 
  DISTINCT album,
  artist 
FROM spotify; -- Total rows: 14178

--Q3. DISTINCT album removes duplicates only based on album name
SELECT 
  DISTINCT album
FROM spotify; -- Total rows: 11853
-- DISTINCT album, artist treats the combination as a pair

--Q4. Get the total number of comments for tracks where licensed = TRUE.
SELECT 
  SUM(comments) AS Total_Comments
FROM spotify 
WHERE licensed = TRUE ;

--Q5. Find all tracks that belong to the album type single.
SELECT * FROM spotify 
WHERE album_type = 'single';

--Q6. Count the total number of tracks by each artist.
SELECT 
  artist,
  COUNT(track) AS total_no_songs
FROM spotify 
GROUP BY artist
ORDER BY total_no_songs DESC;

-- Medium Level

--Q7. Calculate the average danceability of tracks in each album.
SELECT 
  album,
  AVG(danceability) AS avg_danceability
FROM spotify
GROUP BY 1
ORDER BY 2 DESC;

--Q8. Find the top 5 tracks with the highest energy values.
SELECT track, 
  MAX(Energy) AS Highest_energy 
FROM spotify
ORDER BY Highest_energy DESC
LIMIT 5;

--Q9. List all tracks along with their views and likes where official_video = TRUE 
SELECT 
  track, 
  views,
  likes
FROM spotify
WHERE official_video = TRUE
GROUP BY 1
ORDER BY 2 DESC;

--Q10. For each album, calculate the total views of all associated tracks.
SELECT
  album, 
  track,
  SUM(views) AS Total_views
FROM spotify
GROUP BY album,track
ORDER BY Total_views DESC;

--Q11. Retrieve the track names that have been streamed on Spotify more than YouTube.
SELECT * FROM 
(SELECT 
  track,
  COALESCE(SUM(CASE WHEN most_playedon = 'Youtube' THEN stream END),0) AS streamed_on_youtube,
  COALESCE(SUM(CASE WHEN most_playedon = 'Spotify' THEN stream END),0) AS streamed_on_spotify
FROM spotify
GROUP BY 1
) AS T1
WHERE 
  streamed_on_spotify > streamed_on_youtube 
AND 
  streamed_on_youtube <> 0;

-- Advanced Level
--Q12. Find the top 3 most-viewed tracks for each artist using window functions.
WITH ranking_artist
AS
(SELECT
   artist,
   track,
   SUM(views) AS Total_views,
   DENSE_RANK() OVER (PARTITION BY artist ORDER BY SUM(views) DESC) AS rank
FROM spotify
GROUP BY artist,track
ORDER BY artist,Total_views DESC
) 
SELECT * FROM ranking_artist
WHERE 
   rank <= 3
;

--Q13. Write a query to find tracks where the liveness score is above the average.
SELECT
  track,
  artist,
  liveness
  FROM spotify
WHERE
  liveness > (SELECT AVG(liveness) FROM spotify);
