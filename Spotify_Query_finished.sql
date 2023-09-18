
--Find out how many tracks have over 1 billion streams

Select COUNT(streams) AS streams_over_1billion
FROM	[Portfolio Project Database].[dbo].[spotify]
WHERE streams > 1000000000

--152

-- List the top ten songs with the most streams

SELECT TOP 10 track_name_clean, streams
FROM [Portfolio Project Database].[dbo].[spotify]
WHERE streams > 1000000000
ORDER BY streams DESC

--Blinding Lights, Shape Of You, Someone You loved, Dance Monkey, Sunflower, One Dance, Stay, Believer, Closer, Starboy

--Most streamed artist

SELECT TOP(1)  artist_s_name_clean, streams
FROM [Portfolio Project Database].[dbo].[spotify]
ORDER BY streams DESC

-- The Weeknd with 3703895074 streams

--Leased streamed artist

SELECT TOP(1)  artist_s_name_clean, streams
FROM [Portfolio Project Database].[dbo].[spotify]
ORDER BY streams

-- Carin Leon, Grupo Frontera 2762 streams

--Fixng key column replacing C# to C for each key

UPDATE [Portfolio Project Database].[dbo].[spotify]
SET [key] = 'C'
WHERE [key] = 'C#'

UPDATE [Portfolio Project Database].[dbo].[spotify]
SET [key] = 'F'
WHERE [key] = 'F#'

UPDATE [Portfolio Project Database].[dbo].[spotify]
SET [key] = 'G'
WHERE [key] = 'G#'

UPDATE [Portfolio Project Database].[dbo].[spotify]
SET [key] = 'A'
WHERE [key] = 'A#'

UPDATE [Portfolio Project Database].[dbo].[spotify]
SET [key] = 'D'
WHERE [key] = 'D#'

--Double check to make sure all values are proper

SELECT DISTINCT [key]
FROM [Portfolio Project Database].[dbo].[spotify]

--Most Popular Key

SELECT COUNT([key]) AS 'Total C key'
FROM [Portfolio Project Database].[dbo].[spotify]
WHERE [key] = 'C'

--210

SELECT COUNT([key]) AS 'Total B key'
FROM [Portfolio Project Database].[dbo].[spotify]
WHERE [key] = 'B'

--81

SELECT COUNT([key]) AS 'Total F key'
FROM [Portfolio Project Database].[dbo].[spotify]
WHERE [key] = 'F'

--163

SELECT COUNT([key]) AS 'Total D key'
FROM [Portfolio Project Database].[dbo].[spotify]
WHERE [key] = 'D'

--115

--Finding what percent is the highest key

SELECT COUNT(track_name_clean)
FROM [Portfolio Project Database].[dbo].[spotify]

--951 Total Songs

DECLARE @num1 as FLOAT
DECLARE @num2 as FLOAT
 
DECLARE @perc as FLOAT
SET @num1 = 951
SET @num2 = 210
 
SET @perc = @num2/@num1 * 100
 
PRINT @perc

--22% of the songs use C

--Most danceable, Highest energy, liveliness, speechiness

SELECT danceability, track_name_clean, [artist_s_name_clean]
FROM [Portfolio Project Database].[dbo].[spotify]
ORDER BY danceability DESC

-- 96 Danceability Peru by Ed Sheeran and Fireboy DML

SELECT energy, track_name_clean, [artist_s_name_clean]
FROM [Portfolio Project Database].[dbo].[spotify]
ORDER BY energy DESC

-- 97 energy I'm Good By Bebe Rexha and David Guetta

SELECT speechiness, track_name_clean, [artist_s_name_clean]
FROM [Portfolio Project Database].[dbo].[spotify]
ORDER BY speechiness DESC

-- 64 speechiness Cartao Black by MC Caverinha and Kayblack

--Search the most streamed music per year

SELECT released_year, SUM(streams) AS 'Stream per year'
FROM [Portfolio Project Database].[dbo].[spotify]
GROUP BY released_year
ORDER BY released_year DESC

--2022

-- Top songs in playlist per player, Spotify, Apple, Deezer, Shazam

SELECT track_name_clean, artist_s_name_clean, in_apple_playlists
FROM [Portfolio Project Database].[dbo].[spotify]
ORDER BY CAST(in_apple_playlists AS int) DESC

-- Most popular songs for Apple Playlist Blinding Lights By The Weeknd in 672 Playlists

SELECT track_name_clean, artist_s_name_clean, in_deezer_playlists
FROM [Portfolio Project Database].[dbo].[spotify]
ORDER BY in_deezer_playlists DESC

-- Smells Like Teen Spirit By Nirvana 12,367 In Deezer Playlist, found commas in in_deezer_playlist so manually looked up highest value
-- Compared with Apple playlist most added to double check for accurate data

SELECT track_name_clean, artist_s_name_clean, in_deezer_playlists
FROM [Portfolio Project Database].[dbo].[spotify]
WHERE artist_s_name_clean = 'The Weeknd'

--Check Shazam Charts

SELECT track_name_clean, artist_s_name_clean, in_shazam_charts
FROM [Portfolio Project Database].[dbo].[spotify]
ORDER BY in_shazam_charts DESC

-- Makeba by Jain with 1,451 

SELECT track_name_clean, artist_s_name_clean, in_shazam_charts
FROM [Portfolio Project Database].[dbo].[spotify]
WHERE artist_s_name_clean = 'The Weeknd'

-- Blinding lights value is Null for Shazam charts

-- Most popular release month

SELECT COUNT(released_month)
FROM [Portfolio Project Database].[dbo].[spotify]
WHERE released_month = 'dec'

--Jan=817 Dec=134

SELECT DISTINCT [released_month]
FROM [Portfolio Project Database].[dbo].[spotify]