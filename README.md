# Spotify-Data-Analysis-Using-SQL
PostgreSQL project analyzing a Spotify music dataset with real-world streaming features. Includes data exploration and SQL queries categorized into easy, medium, and advanced levels. Covers filtering, aggregation, grouping, joins, subqueries, and window functions to build strong data analytics and database skills.

## Project Objectives

- Understand the structure and characteristics of Spotify music data

- Strengthen SQL skills through real-world analytical queries
  
- Apply indexing and execution plans for improved query performance
  
- Demonstrate practical experience in data analytics and database management

## Dataset Overview
The dataset contains detailed attributes of music tracks, including:

- Artist — Performer of the track
- Track — Song title
- Album — Album name
- Album Type — e.g., Album, Single
- Metrics — Danceability, Energy, Loudness, Tempo, etc.
- Engagement — Streams, Views, Likes, Comments
- Categorical Flags — Official_video, Licensed

## SQL Capabilities Demonstrated

- Data filtering and sorting
- Aggregate analytics using COUNT, SUM, AVG
- Grouping insights using GROUP BY and HAVING
- Ranking and analytics using window functions
- CTEs and subqueries for complex insights
- Query optimization using indexes and execution plans
- Meaningful music metrics queries (top artists, popular albums, etc.)

## Schema
DROP TABLE IF EXISTS spotify;
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
Valence FLOAT,  
Tempo FLOAT,  
Duration_min FLOAT,  
Title VARCHAR(255),  
Channel VARCHAR(255),  
Views FLOAT,  
Likes FLOAT,    
Comments BIGINT,  
Licensed BOOLEAN,  
official_video BOOLEAN,  
Stream BIGINT,  
EnergyLiveness FLOAT,  
most_playedon VARCHAR(50)  
);  

#### View All Data
SELECT * FROM spotify;  
-- Displays the complete table — 20,594 rows.

#### Count Total Number of Records
SELECT COUNT(*) FROM spotify;  
-- 20594  

#### Count Total Number of Unique Artists
SELECT 
  COUNT(DISTINCT Artist)  
FROM spotify;  
-- 2074 unique artists  

#### List All Album Types
SELECT 
  DISTINCT Album_type   
FROM spotify;   
-- "album","compilation","single"  

#### Maximum Track Duration (in minutes)
SELECT 
  MAX(Duration_min)  
FROM spotify;   
-- 77.9343 minutes (longest track)

#### Minimum Track Duration (in minutes)
SELECT 
  MIN(Duration_min)   
FROM spotify;  
-- 0 minutes (invalid/missing duration)  

#### Platforms Where Track is Most Played
SELECT 
  DISTINCT most_playedon  
FROM spotify;  
-- "Youtube","Spotify"  

#### Retrieve Tracks With Zero Duration
SELECT * 
FROM spotify  
WHERE 
  Duration_min = 0;  
-- Shows tracks having incorrect duration (0 min)

#### Remove Records With Zero Duration (Data Cleaning)
DELETE  
FROM spotify  
WHERE 
  Duration_min = 0;  
-- Removes invalid/incorrect entries from the dataset

## Business Problems and Solutions
### Q1. Retrieve the names of all tracks that have more than 1 billion streams.  
SELECT   
  Track,   
  stream    
FROM spotify   
WHERE stream > 1000000000;  

### Q2. List all the albums along with their respective artists.  
SELECT   
  DISTINCT album,  
  artist   
FROM spotify;  -- Total rows: 14178  

### Q3. DISTINCT album removes duplicates only based on album name  
SELECT   
  DISTINCT album  
FROM spotify;   

### Q4. Get the total number of comments for tracks where licensed = TRUE.  
SELECT   
  SUM(comments) AS Total_Comments  
FROM spotify   
WHERE 
  licensed = TRUE ;  

### Q5. Find all tracks that belong to the album type single.  
SELECT *
FROM spotify   
WHERE 
  album_type = 'single';  

### Q6. Count the total number of tracks by each artist.  
SELECT   
  artist,  
  COUNT(track) AS total_no_songs  
FROM spotify   
GROUP BY artist  
ORDER BY total_no_songs DESC;   

### Q7. Calculate the average danceability of tracks in each album.  
SELECT   
  album,  
  AVG(danceability) AS avg_danceability  
FROM spotify  
GROUP BY 1  
ORDER BY 2 DESC;  

### Q8. Find the top 5 tracks with the highest energy values.  
SELECT track,   
  MAX(Energy) AS Highest_energy   
FROM spotify  
ORDER BY Highest_energy DESC  
LIMIT 5;  

### Q9. List all tracks along with their views and likes where official_video = TRUE   
SELECT   
  track,   
  views,  
  likes  
FROM spotify  
WHERE 
  official_video = TRUE  
GROUP BY 1  
ORDER BY 2 DESC;  

### Q10. For each album, calculate the total views of all associated tracks.  
SELECT  
  album,   
  track,  
  SUM(views) AS Total_views  
FROM spotify  
GROUP BY album,track  
ORDER BY Total_views DESC;  

### Q11. Retrieve the track names that have been streamed on Spotify more than YouTube.
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

### Q12. Find the top 3 most-viewed tracks for each artist using window functions.
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

## Technology Stack

- PostgreSQL for Database engine
- SQL	for Querying and analytics
- GitHub	for Documentation and version control

## What I Learned

- Handling real-world music analytics data
- Writing clean and optimized SQL queries
- Using advanced SQL features such as window functions and CTEs
- Understanding performance improvements with indexing

## Contributions

Suggestions and improvements are welcome!
Fork the repo, run queries, and explore more insights.
