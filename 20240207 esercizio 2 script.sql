USE GESTIONALE;

CREATE TABLE PRODOTTI (
IdProdotto INT,
NomeProdotto VARCHAR(100),
Prezzo DECIMAL(10,2),
PRIMARY KEY (IdProdotto));

INSERT INTO PRODOTTI (IdProdotto, NomeProdotto, Prezzo) VALUES
(1, 'Tablet', 300.00),
(2, 'Mouse', 20.00),
(3, 'Tastiera', 25.00),
(4, 'Monitor', 180.00),
(5, 'HDD', 90.00),
(6, 'SSD', 200.00),
(7, 'RAM', 100.00),
(8, 'Router', 80.00),
(9, 'Webcam', 45.00),
(10, 'GPU', 1250.00),
(11, 'Trackpad', 500.00),
(12, 'Techmagazine', 5.00),
(13, 'Martech', 50.00);

CREATE TABLE Clienti (
IdCliente INT,
Nome VARCHAR(50),
Email VARCHAR(100),
PRIMARY KEY (IdCliente));

INSERT INTO CLIENTI (IdCliente, Nome, Email) VALUES
(1, 'Antonio', NULL),
(2, 'Battista', 'battista@mailmail.it'),
(3, 'Maria', 'maria@posta.it'),
(4, 'Franca', 'franca@lettere.it'),
(5, 'Ettore', NULL),
(6, 'Arianna', 'arianna@posta.it'),
(7, 'Piero', 'piero@lavoro.it');

CREATE TABLE Ordini (
IDOrdine INT,
IDProdotto INT,
IDCliente INT,
Quantità INT,
PRIMARY KEY(IDOrdine),
FOREIGN KEY (IDProdotto) REFERENCES Prodotti(IDProdotto),
FOREIGN KEY (IDCliente) REFERENCES Clienti(IDCliente));

INSERT INTO Ordini (IDOrdine, IDProdotto, IDCliente, Quantità) VALUES
(1, 2, 1, 10),
(2, 6, 2, 2),
(3, 4, 3, 5),
(4, 9, 1, 1),
(5, 11, 6, 4),
(6, 10, 2, 2),
(7, 3, 3, 3),
(8, 1, 4, 1),
(9, 2, 5, 3),
(10, 1, 6, 2),
(11, 2, 7, 1);

CREATE TABLE DettaglioOrdine (
 IDOrdine INT,
 IDProdotto INT,
 IDCliente INT,
 PrezzoTotale DECIMAL(10, 2),
 PRIMARY KEY (IDOrdine, IDProdotto, IDCliente),
 FOREIGN KEY (IDOrdine) REFERENCES Ordini(IDOrdine),
 FOREIGN KEY (IDProdotto) REFERENCES Prodotti(IDProdotto),
 FOREIGN KEY (IDCliente) REFERENCES Clienti(IDCliente));

SELECT * FROM Prodotti;
SELECT * FROM Clienti;
SELECT * FROM Ordini;

INSERT INTO DettaglioOrdine (IDOrdine, IDProdotto, IDCliente, PrezzoTotale) SELECT
ord.IdOrdine,
ord.IdProdotto,
ord.IdCliente,
prd.Prezzo * ord.Quantità AS PrezzoTotale
FROM ORDINI ord JOIN PRODOTTI prd ON ord.IdProdotto = prd.IdProdotto;

SELECT * FROM DettaglioOrdine;