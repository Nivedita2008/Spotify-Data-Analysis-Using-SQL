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
## Business Problems and Solutions

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
