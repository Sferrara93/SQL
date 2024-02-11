-- ESERCIZIO 1

USE new_schema;

SELECT * FROM IMPIEGATO;

-- Seleziona tutti gli impiegati con una laurea in Economia.
SELECT * FROM IMPIEGATO
WHERE TitoloStudio = 'Laurea in economia';

-- Seleziona gli impiegati che lavorano come Cassiere o che hanno un Diploma di Informatica
SELECT Nome, Carica FROM IMPIEGATO
JOIN SERVIZIO_IMPIEGATO ON IMPIEGATO.CodiceFiscale = SERVIZIO_IMPIEGATO.CodiceFiscale
WHERE SERVIZIO_IMPIEGATO.Carica = 'Cassiere' OR IMPIEGATO.TitoloStudio = 'Diploma in Informatica';

-- Seleziona i nomi e i titoli degli impiegati che hanno iniziato a lavorare dopo il 1 gennaio 2023
SELECT Nome, TitoloStudio FROM IMPIEGATO
JOIN SERVIZIO_IMPIEGATO ON IMPIEGATO.CodiceFiscale = SERVIZIO_IMPIEGATO.CodiceFiscale
WHERE SERVIZIO_IMPIEGATO.DataInizio >= '2023-01-01';

-- Seleziona i titoli di studio distinti tra gli impiegati
SELECT DISTINCT TitoloStudio FROM IMPIEGATO;

-- Seleziona gli impiegati con un titolo di studio diverso da "Laurea in Economia"
SELECT * FROM IMPIEGATO
WHERE TitoloStudio <> 'Laurea in economia';

-- Seleziona gli impiegati che hanno iniziato a lavorare prima del 1 luglio 2023 e sono Commessi
SELECT Nome, Carica, DataInizio FROM IMPIEGATO
JOIN SERVIZIO_IMPIEGATO ON IMPIEGATO.CodiceFiscale = SERVIZIO_IMPIEGATO.CodiceFiscale
WHERE SERVIZIO_IMPIEGATO.DataInizio < '2023-07-01' AND SERVIZIO_IMPIEGATO.Carica = 'Commesso';

-- Seleziona i titoli e gli sviluppatori dei videogiochi distribuiti nel 2020
SELECT Titolo, Sviluppatore FROM VIDEOGIOCO
WHERE YEAR(AnnoDistribuzione) = 2020;

-- ESERCIZIO 2
USE gestionale;

-- Seleziona tutti i prodotti con un prezzo superiore a 50 euro dalla tabella Prodotti
SELECT * FROM PRODOTTI
WHERE PREZZO > 50;

-- Seleziona tutte le email dei clienti il cui nome inizia con la lettera 'A' dalla tabella Clienti
SELECT EMAIL FROM CLIENTI
WHERE NOME LIKE 'A%';

-- Seleziona tutti gli ordini con una quantità maggiore di 10 o con un importo totale inferiore a 100 euro dalla tabella Ordini
SELECT * FROM ORDINI
JOIN DETTAGLIOORDINE ON DETTAGLIOORDINE.IdOrdine = ORDINI.IdOrdine
WHERE ORDINI.Quantità > 10 OR DETTAGLIOORDINE.PrezzoTotale < 100;

-- Seleziona tutti i prezzi dei prodotti il cui nome contiene la parola 'tech' indipendentemente dalla posizione nella tabella Prodotti
SELECT NomeProdotto, Prezzo FROM PRODOTTI
WHERE NomeProdotto LIKE '%tech%';

-- Seleziona tutti i clienti che non hanno un indirizzo email nella tabella Clienti
SELECT * FROM CLIENTI
WHERE EMAIL IS NULL OR EMAIL IN (' ','');

-- Seleziona tutti i prodotti il cui nome inizia con 'M' e termina con 'e' indipendentemente dalla lunghezza della parola nella tabella Prodotti
SELECT * FROM PRODOTTI
WHERE NomeProdotto LIKE 'M%_%e';
