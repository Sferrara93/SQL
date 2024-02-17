-- ESERCIZIO 1
-- Fate un elenco di tutte le tabelle
SHOW TABLES;

-- Visualizzate le prime 10 righe della tabella Album.
SELECT * FROM album LIMIT 10;

-- Trovate il numero totale di canzoni della tabella Tracks.
SELECT COUNT(*) AS TOTAL_TRACKS FROM TRACK;

-- Trovate i diversi generi presenti nella tabella Genre.
SELECT DISTINCT GENRE.Name FROM GENRE;


-- ESERCIZIO 2
-- Recuperate il nome di tutte le tracce e del genere associato
SELECT TRACK.Name, GENRE.Name FROM TRACK
LEFT JOIN GENRE ON TRACK.GenreId = GENRE.GenreId
ORDER BY GENRE.Name;


-- ESERCIZIO 3
-- Recuperate il nome di tutti gli artisti che hanno almeno un album nel database. Esistono artisti senza album nel database?
WITH FIRST_ONE AS (
	SELECT ARTIST.Name, COUNT(ALBUM.AlbumID) AS TOTAL_ALBUM FROM ARTIST
	LEFT JOIN ALBUM ON ARTIST.ArtistId = ALBUM.ArtistId
	GROUP BY ARTIST.Name
	ORDER BY TOTAL_ALBUM DESC
    )
    
    SELECT * FROM FIRST_ONE
    WHERE TOTAL_ALBUM > 0;

WITH SECOND_ONE AS (
	SELECT ARTIST.Name, COUNT(ALBUM.AlbumID) AS TOTAL_ALBUM FROM ARTIST
	LEFT JOIN ALBUM ON ARTIST.ArtistId = ALBUM.ArtistId
	GROUP BY ARTIST.Name
	ORDER BY TOTAL_ALBUM DESC
    )
    
    SELECT * FROM SECOND_ONE
    WHERE TOTAL_ALBUM = 0;


-- ESERCIZIO 4
/* Recuperate il nome di tutte le tracce, del genere associato e della tipologia di media. 
Esiste un modo per recuperare il nome della tipologia di media? */
SELECT TRACK.Name AS TRACK_NAME,  GENRE.Name AS GENRE, MEDIATYPE.Name AS MEDIA_TYPE FROM TRACK
LEFT JOIN GENRE ON TRACK.GenreId = GENRE.GenreId
LEFT JOIN MEDIATYPE ON TRACK.MediaTypeId = MEDIATYPE.MediaTypeId;


-- ESERCIZIO 5
-- Elencate i nomi di tutti gli artisti e dei loro album.
SELECT ARTIST.Name, ALBUM.Title FROM ARTIST
LEFT JOIN ALBUM ON ARTIST.ArtistId = ALBUM.ArtistId
WHERE ALBUM.Title IS NOT NULL
ORDER BY ARTIST.Name;


-- EXTRA
-- durata media per ogni traccia
SELECT ALBUM.Title AS ALBUM_TITLE, TRACK.Name AS TRACK, AVG(TRACK.Milliseconds)/1000/60 AS AVG_TRACK FROM TRACK
JOIN ALBUM ON TRACK.AlbumId = ALBUM.AlbumId
GROUP BY ALBUM.Title, TRACK.Name
ORDER BY AVG_TRACK DESC;