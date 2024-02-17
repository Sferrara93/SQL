-- ESERCIZIO 1 
-- Elencate il numero di tracce per ogni genere in ordine discendente, escludendo quei generi che hanno meno di 10 tracce
SELECT GENRE.Name, COUNT(TRACK.TrackId) AS TOTAL_TRACKS FROM TRACK
JOIN GENRE USING (GenreId)
GROUP BY GENRE.Name
HAVING TOTAL_TRACKS > 10
ORDER BY TOTAL_TRACKS DESC;


-- ESERCIZIO 2
-- Trovate le tre canzoni più costose
SELECT Name, UnitPrice FROM TRACK
ORDER BY UnitPrice DESC
LIMIT 3;


-- ESERCIZIO 3
-- Elencate gli artisti che hanno canzoni più lunghe di 6 minuti.
SELECT ARTIST.Name AS ARTIST_NAME, MAX(TRACK.Milliseconds)/1000/60 AS TRACK_DURATION FROM TRACK
JOIN ALBUM ON TRACK.AlbumId = ALBUM.AlbumId
JOIN ARTIST ON ALBUM.ArtistId = ARTIST.ArtistId
GROUP BY ARTIST.Name
HAVING TRACK_DURATION > 6
ORDER BY TRACK_DURATION;


-- ESERCIZIO 4
-- Individuate la durata media delle tracce per ogni genere.
SELECT GENRE.Name, ROUND(AVG(TRACK.Milliseconds)/1000/60,2) AS AVG_DURATION FROM TRACK
JOIN GENRE USING (GenreId)
GROUP BY GENRE.Name
ORDER BY AVG_DURATION;


-- ESERCIZIO 5
-- Elencate tutte le canzoni con la parola “Love” nel titolo, ordinandole alfabeticamente prima per genere e poi per nome.
SELECT TRACK.Name, GENRE.Name FROM TRACK
JOIN GENRE USING (GenreId)
WHERE TRACK.Name LIKE '%Love %'
ORDER BY GENRE.Name, TRACK.Name;


-- ESERCIZIO 6
-- Trovate il costo medio per ogni tipologia di media
SELECT MEDIATYPE.Name, AVG(TRACK.UnitPrice) AS AVG_PRICE FROM TRACK
JOIN MEDIATYPE USING (MediaTypeId)
GROUP BY MEDIATYPE.Name
ORDER BY AVG_PRICE;


-- ESERCIZIO 7
-- Individuate il genere con più tracce.
SELECT GENRE.Name AS GENRE, COUNT(TRACK.TrackId) AS TOTAL_TRACKS  FROM TRACK
JOIN GENRE USING (GenreId)
GROUP BY GENRE
ORDER BY TOTAL_TRACKS DESC
LIMIT 1;


-- ESERCIZIO 8
-- Trovate gli artisti che hanno lo stesso numero di album dei Rolling Stones
/* WITH ROLLING_STONES AS (
	SELECT COUNT(ALBUM.AlbumId) FROM ALBUM
	JOIN ARTIST USING (ArtistId)
	GROUP BY ARTIST.Name
	HAVING ARTIST.Name = 'The Rolling Stones')
*/    

SELECT ARTIST.Name, COUNT(ALBUM.AlbumId) FROM ALBUM
JOIN ARTIST USING (ArtistId)
GROUP BY ARTIST.Name
HAVING COUNT(ALBUM.AlbumId) = (SELECT COUNT(ALBUM.AlbumId) FROM ALBUM
								JOIN ARTIST USING (ArtistId)
								GROUP BY ARTIST.Name
								HAVING ARTIST.Name = 'The Rolling Stones')
		AND ARTIST.Name <> 'The Rolling Stones';


-- ESERCIZIO 9
-- Trovate l’artista con l’album più costoso
SELECT ALBUM.Title, ARTIST.Name, PRICE FROM ALBUM
JOIN ARTIST USING (ArtistId)
JOIN (
	SELECT ALBUM.AlbumId, SUM(TRACK.UnitPrice) AS PRICE FROM TRACK
	JOIN ALBUM USING (AlbumId)
	GROUP BY ALBUM.AlbumId
    ) AS ALBUM_PRICE ON ALBUM_PRICE.AlbumId = ALBUM.AlbumId
ORDER BY PRICE DESC
LIMIT 1;
