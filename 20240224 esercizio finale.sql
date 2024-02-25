drop schema esercizio_finale;
-- CREAZIONE DATABASE

CREATE SCHEMA esercizio_finale;
USE esercizio_finale;


-- CREAZIONE TABELLE

CREATE TABLE products (
productID INT,
product_name VARCHAR(100),
product_category VARCHAR(100),
product_price DECIMAL(10,2),
PRIMARY KEY (productID));

CREATE TABLE regions (
regionID INT,
region_name VARCHAR(100),
PRIMARY KEY (regionID));

CREATE TABLE states (
stateID INT,
state_name VARCHAR(100),
regionID INT,
PRIMARY KEY (stateID),
FOREIGN KEY (regionID) REFERENCES regions(regionID));

CREATE TABLE sales (
saleID INT,
sale_date DATE,
productID INT,
stateID INT,
quantity INT,
PRIMARY KEY (saleID),
FOREIGN KEY (stateID) REFERENCES states(stateID),
FOREIGN KEY (productID) REFERENCES products(productID));


-- INSERIMENTO RECORDS NELLE TABELLE 

INSERT INTO products (productID, product_name, product_category, product_price)
VALUES
(1, 'Scarpe da running', 'Abbigliamento sportivo', 50),
(2, 'Smartphone', 'Elettronica', 700),
(3, 'Forno a microonde', 'Elettrodomestici', 250),
(4, 'Libro di cucina', 'Libri', 10),
(5, 'Borsa da viaggio', 'Accessori', 30),
(6, 'TV LED', 'Elettronica', 2000),
(7, 'Caffè macinato', 'Alimentari', 5),
(8, 'Bicicletta da corsa', 'Sport e tempo libero', 3000),
(9, 'Set di pentole', 'Casalinghi', 300),
(10, 'Tavolo da giardino', 'Arredamento giardino', 120);

INSERT INTO regions (regionID, region_name)
VALUES
(1, 'Nord America'),
(2, 'Sud America'),
(3, 'Europa Occidentale'),
(4, 'Europa Orientale'),
(5, 'Asia Orientale'),
(6, 'Asia Meridionale'),
(7, 'Africa Settentrionale'),
(8, 'Africa Centrale'),
(9, 'Africa Meridionale'),
(10, 'Oceania');

INSERT INTO states (stateID, state_name, regionID)
VALUES
(1, 'United States', 1),
(2, 'Italy', 2),
(3, 'France', 2),
(4, 'Japan', 3),
(5, 'Australia', 3),
(6, 'Brazil', 4),
(7, 'South Africa', 5),
(8, 'Germany', 2),
(9, 'India', 4),
(10, 'South Africa', 5),
(11, 'Canada', 1),
(12, 'Japan', 3),
(13, 'Spain', 2),
(14, 'South Korea', 3),
(15, 'Netherlands', 2),
(16, 'Brazil', 4),
(17, 'Russia', 2),
(18, 'China', 3),
(19, 'Portugal', 2),
(20, 'Mexico', 1),
(21, 'Turkey', 2),
(22, 'Egypt', 5);

INSERT INTO sales (saleID, sale_date, productID, stateID, quantity)
VALUES
(1, '2023-11-14', 1, 1, 2),
(2, '2023-11-15', 2, 4, 1),
(3, '2023-11-16', 3, 5, 3),
(4, '2023-11-17', 4, 2, 4),
(5, '2023-11-18', 5, 3, 2),
(6, '2023-11-19', 6, 1, 3),
(7, '2023-11-20', 7, 4, 1),
(8, '2023-11-21', 8, 5, 2),
(9, '2023-11-22', 9, 2, 4),
(10, '2023-11-23', 10, 3, 1),
(11, '2023-11-24', 1, 1, 3),
(12, '2023-11-25', 2, 4, 2),
(13, '2023-11-26', 3, 5, 4),
(14, '2023-11-27', 4, 2, 1),
(15, '2023-11-28', 5, 3, 3),
(16, '2023-11-29', 6, 1, 2),
(17, '2023-11-30', 7, 4, 4),
(18, '2023-12-01', 8, 5, 1),
(19, '2023-12-02', 9, 2, 3),
(20, '2023-12-03', 10, 3, 2),
(21, '2022-12-04', 1, 1, 4),
(22, '2022-12-05', 2, 4, 1),
(23, '2022-12-06', 3, 5, 3),
(24, '2022-12-07', 4, 2, 4),
(25, '2022-12-08', 5, 3, 2),
(26, '2022-12-09', 6, 1, 3),
(27, '2022-12-10', 7, 4, 1),
(28, '2022-12-11', 8, 5, 2),
(29, '2022-12-12', 9, 2, 4),
(30, '2022-12-13', 10, 3, 1),
(31, '2022-12-14', 1, 1, 3),
(32, '2022-12-15', 2, 4, 2),
(33, '2022-12-16', 3, 5, 4),
(34, '2022-12-17', 4, 2, 1),
(35, '2022-12-18', 5, 3, 3),
(36, '2022-12-19', 6, 1, 2),
(37, '2022-12-20', 7, 4, 4),
(38, '2022-12-21', 8, 5, 1),
(39, '2022-12-22', 9, 2, 3);


-- QUERY
-- 1. Verificare che i campi definiti come PK siano univoci. 
select productID, count(productID) from products
group by productID
order by count(productID) desc;

select regionID, count(regionID) from regions
group by regionID
order by count(regionID) desc;

select stateID, count(stateID) from states
group by stateID
order by count(stateID) desc;

select saleID, count(saleID) from sales
group by saleID
order by count(saleID) desc;

-- 2. Esporre l’elenco dei soli prodotti venduti e per ognuno di questi il fatturato totale per anno.
with revenues_per_product as (
	select year(sales.sale_date) as year, products.product_name as product, sales.quantity*products.product_price as revenue from sales
	join products using (productID)
	group by year, product, revenue)

select year, product, sum(revenue) as revenues from revenues_per_product
group by year, product
order by revenues desc;

-- 3. Esporre il fatturato totale per stato per anno. Ordina il risultato per data e per fatturato decrescente. 
with revenues_per_state as (
	select year(sales.sale_date) as year, states.state_name as state, sales.quantity*products.product_price as revenue from sales
	join states using (stateID)
    join products using (productID)
	group by year, state, revenue)

select year, state, sum(revenue) as revenues from revenues_per_state
group by year, state
order by revenues desc;

-- 4. Rispondere alla seguente domanda: qual è la categoria di articoli maggiormente richiesta dal mercato?
with revenues_per_category as (
	select products.product_category as category, sales.quantity*products.product_price as revenue from sales
    join products using (productID)
	group by category, revenue)

select category, sum(revenue) as revenues from revenues_per_category
group by category
order by revenues desc
limit 1;

-- 5. Rispondere alla seguente domanda: quali sono, se ci sono, i prodotti invenduti? Proponi due approcci risolutivi differenti.
-- rimuovo la vendita di un prodotto
delete from sales where productID = 10;

-- approccio 1
select products.productID as ID, products.product_name as product from products
left join sales using (productID)
where saleID is null;

-- approccio 2
select productID as ID,  product_name as product from products
where productID not in (select productID from sales);

-- 6. Esporre l’elenco dei prodotti con la rispettiva ultima data di vendita (la data di vendita più recente).
select products.product_name as product, max(sales.sale_date) as last_sale from sales
join products using (productID)
group by product;

/* BONUS: Esporre l’elenco delle transazioni indicando nel result set il codice documento, la data, 
il nome del prodotto, la categoria del prodotto, il nome dello stato, il nome della regione di vendita 
e un campo booleano valorizzato in base alla condizione che siano passati più di 180 giorni 
dalla data vendita o meno (>180 -> True, <= 180 -> False) */
select sales.saleID as codice_documento, 
sales.sale_date as date,
products.product_name as product, 
products.product_category as category, 
states.state_name as state,
regions.region_name as region,
datediff(curdate(),sales.sale_date) as date_diff,
if(datediff(curdate(),sales.sale_date) > 180, "TRUE", "FALSE") as boolean
from sales
join products using (productID)
join states using (stateID)
join regions using(regionID);