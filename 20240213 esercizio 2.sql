-- ESERCZIO 1
-- Recuperate tutte le tracce che abbiano come genere “Pop” o “Rock”.
SELECT TRACK.Name AS TRACK, GENRE.Name AS GENRE FROM TRACK
LEFT JOIN GENRE ON TRACK.GenreId = GENRE.GenreId
WHERE GENRE.Name IN ('Pop', 'Rock')
ORDER BY GENRE.Name ASC;


WITH HELP_1 AS (
	SELECT TRACK.Name AS TRACK, GENRE.Name AS GENRE FROM TRACK
	LEFT JOIN GENRE ON TRACK.GenreId = GENRE.GenreId
	WHERE GENRE.Name IN ('Pop', 'Rock')
	)
    SELECT GENRE, COUNT(GENRE) FROM HELP_1
    GROUP BY GENRE;
    
    
-- ESERCIZIO 2
-- Elencate tutti gli artisti e/o gli album che inizino con la lettera “A”.

-- CASO "E"
SELECT ARTIST.Name AS ARTIST, ALBUM.Title AS ALBUM FROM ARTIST
LEFT JOIN ALBUM ON ARTIST.ArtistId = ALBUM.ArtistId
WHERE ARTIST.Name LIKE 'A%' AND ALBUM.Title LIKE 'A%';

-- CASO "O"
SELECT ARTIST.Name AS ARTIST, ALBUM.Title AS ALBUM FROM ARTIST
LEFT JOIN ALBUM ON ARTIST.ArtistId = ALBUM.ArtistId
WHERE ARTIST.Name LIKE 'A%' OR ALBUM.Title LIKE 'A%';


-- ESERCIZIO 3
-- Recuperate i nomi degli album o degli artisti che abbiano pubblicazioni precedenti all’anno 2010.
SELECT TRACK.Name, INVOICE.InvoiceDate FROM TRACK
JOIN INVOICELINE ON TRACK.TrackId = INVOICELINE.TrackId
JOIN INVOICE ON  INVOICELINE.InvoiceId = INVOICE.InvoiceId
WHERE YEAR(InvoiceDate) < 2010;


-- ESERCIZIO 4
-- Elencate tutte le tracce che hanno come genere “Jazz” o che durano meno di 3 minuti
SELECT TRACK.Name AS TRACK_NAME, GENRE.Name AS GENRE_NAME, TRACK.Milliseconds/1000/60 AS TRACK_DURATION FROM TRACK
JOIN GENRE ON TRACK.GenreId = GENRE.GenreId
WHERE GENRE.Name = 'Jazz' OR TRACK.Milliseconds/1000/60 < 3;


-- ESERCIZIO 5
-- Recuperate tutte le tracce più lunghe della durata media.
SELECT Name, Milliseconds/1000/60 AS TRACK_DURATION FROM TRACK
WHERE Milliseconds/1000/60 > (SELECT AVG(Milliseconds)/1000/60 FROM TRACK)
ORDER BY TRACK_DURATION ASC;


-- ESERCIZIO 6
-- Individuate i generi che hanno tracce con una durata media maggiore di 4 minuti
SELECT GENRE.Name, AVG(TRACK.Milliseconds)/1000/60 FROM TRACK
JOIN GENRE USING (GenreId)
GROUP BY GENRE.Name
HAVING AVG(TRACK.Milliseconds)/1000/60 > 4;


-- ESERCIZIO 7
-- Individuate gli artisti che hanno rilasciato più di un album.
SELECT ARTIST.Name, COUNT(ALBUM.AlbumId) FROM ARTIST
JOIN ALBUM USING (ArtistId)
GROUP BY ARTIST.Name
HAVING COUNT(ALBUM.AlbumId) > 1
ORDER BY COUNT(ALBUM.AlbumId) DESC;


-- ESERCIZIO 8.1
-- Trovate la traccia più lunga in ogni album.
SELECT ALBUM.Title, TRACK.Name, TRACK.Milliseconds/1000/60 AS Duration FROM TRACK
JOIN ALBUM USING (AlbumId)
JOIN (
	SELECT AlbumId, MAX(Milliseconds) AS LONGER_TRACK FROM TRACK
	GROUP BY AlbumId
    ) AS LONGER_TRACK_TABLE ON TRACK.AlbumId = LONGER_TRACK_TABLE.AlbumId AND LONGER_TRACK_TABLE.LONGER_TRACK = TRACK.Milliseconds
ORDER BY Duration DESC;


-- ESERCZIO 8.2
-- Individuate la durata media delle tracce per ogni album.
SELECT ALBUM.Title, AVG(TRACK.Milliseconds)/1000/60 AS AVG_DURATION FROM TRACK
JOIN ALBUM USING (AlbumId)
GROUP BY ALBUM.Title
ORDER BY AVG_DURATION DESC;


-- ESERCIZIO 9
-- Individuate gli album che hanno più di 20 tracce e mostrate il nome dell’album e il numero di tracce in esso contenute
SELECT ALBUM.Title, COUNT(TRACK.TrackId) FROM TRACK
JOIN ALBUM USING (AlbumId)
GROUP BY ALBUM.Title
HAVING COUNT(TRACK.TrackId) > 20
ORDER BY COUNT(TRACK.TrackId) DESC;