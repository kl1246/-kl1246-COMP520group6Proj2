DROP DATABASE IF EXISTS Winner; 
CREATE DATABASE Winner;
USE Winner;

CREATE TABLE  Triple (
    `year` int PRIMARY KEY,
    `derbywinner` VARCHAR(60) NOT NULL,
    `preakwinner` VARCHAR(60) NOT NULL,
    `belmontwinner` VARCHAR(60) NOT NULL 
);

INSERT INTO Triple (year, derbywinner, preakwinner, belmontwinner)
VALUES (2014, "California Chrome", "California Chrome", "Tonalist"), 
(2013, "Orb", "Oxbow", "Palace malice"), 
(2012, "I'll Have Another", "I'll Have Another", "Union Rags"),
(2011, "Animal Kingdom", "Shackleford", "Ruler on Ice"),
(2010, "Super Saver", "Lookin At Lucky", "Drosselmeyer"),
(2009, "Mine That Bird", "Rachel Alexandra", "Summer Bird"),
(2008, "Big Brown", "Big Brown", "Da'Tara"),
(2007, "Street Sense", "Curlin", "Rags to Riches"),
(2006, "Barbaro", "Bernardini", "Jazil"),
(2015, "American Pharoah", "American Pharoah", "American Pharoah");

CREATE VIEW Derby AS
SELECT  
    year,
    derbywinner as winner
FROM Triple;

CREATE VIEW Preakness AS
SELECT  
    year,
    preakwinner as winner
FROM Triple;

CREATE VIEW Belmont AS
SELECT  
    year,
    belmontwinner as winner
FROM Triple;

SELECT d.year FROM Derby AS d
WHERE d.winner NOT IN (SELECT p.winner FROM Preakness AS p WHERE p.winner NOT IN (SELECT b.winner FROM Belmont AS b WHERE b.winner NOT IN (SELECT d.winner FROM Derby AS d)));

SELECT d.year, d.winner FROM Derby AS d
WHERE d.winner IN (SELECT p.winner FROM Preakness AS p WHERE p.winner NOT IN (SELECT b.winner FROM Belmont AS b));

SELECT d.year, d.winner FROM Derby AS d
WHERE d.winner IN (SELECT p.winner FROM Preakness AS p WHERE p.winner IN (SELECT b.winner FROM Belmont AS b WHERE b.winner IN (SELECT d.winner FROM Derby AS d)));
