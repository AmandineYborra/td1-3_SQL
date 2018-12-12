DROP DATABASE IF EXISTS agence_environnement;
CREATE DATABASE agence_environnement;
USE agence_environnement;

CREATE TABLE modele
(
idmodele int primary key,
libelle VARCHAR(45),
crashtest VARCHAR(45),
consommation int
);

CREATE TABLE carburant
(
designation VARCHAR(45) primary key,
cours FLOAT,
pollution VARCHAR(45)
);

CREATE TABLE utilise
(
idmodele int,
designation VARCHAR(45)
);

CREATE TABLE vehicule
(
immatriculation VARCHAR(45) primary key,
kilometrage int,
idmodele int,
nom_proprio VARCHAR(45)
);

CREATE TABLE proprietaire
(
nom VARCHAR(45) primary key,
age int
);

ALTER TABLE utilise ADD PRIMARY KEY (idmodele, designation);
ALTER TABLE utilise ADD FOREIGN KEY (idmodele) REFERENCES modele(idmodele);
ALTER TABLE utilise ADD FOREIGN KEY (designation) REFERENCES carburant(designation);
ALTER TABLE vehicule ADD FOREIGN KEY (idmodele) REFERENCES modele(idmodele);
ALTER TABLE vehicule ADD FOREIGN KEY (nom_proprio) REFERENCES proprietaire(nom);

INSERT INTO carburant VALUES ('Essence',1.4,'200g');
INSERT INTO carburant VALUES ('Diesel',1.3,'250g');
INSERT INTO carburant VALUES ('GPL',0.8,'20g');
INSERT INTO carburant VALUES ('Electrique',1.1,'56g');

INSERT INTO modele VALUES (1,'ville','top',5);
INSERT INTO modele VALUES (2,'ville','mauvais',6);
INSERT INTO modele VALUES (3,'sport','moyen',7);
INSERT INTO modele VALUES (4,'berline','ça passe',8);
INSERT INTO modele VALUES (5,'berline','mauvais',9);
INSERT INTO modele VALUES (6,'4X4','top',10);

INSERT INTO proprietaire VALUES ('Bernard',23);
INSERT INTO proprietaire VALUES ('Rodolf',45);
INSERT INTO proprietaire VALUES ('Karine',54);
INSERT INTO proprietaire VALUES ('Haïfa',18);
INSERT INTO proprietaire VALUES ('Driss',28);
INSERT INTO proprietaire VALUES ('Mère Noël',33);

INSERT INTO utilise VALUES (1,'Diesel');
INSERT INTO utilise VALUES (1,'Essence');
INSERT INTO utilise VALUES (1,'Electrique');
INSERT INTO utilise VALUES (2,'Diesel');
INSERT INTO utilise VALUES (2,'Essence');
INSERT INTO utilise VALUES (2,'GPL');
INSERT INTO utilise VALUES (3,'Diesel');
INSERT INTO utilise VALUES (3,'Essence');
INSERT INTO utilise VALUES (3,'Electrique');
INSERT INTO utilise VALUES (4,'Diesel');
INSERT INTO utilise VALUES (4,'Essence');
INSERT INTO utilise VALUES (4,'Electrique');
INSERT INTO utilise VALUES (5,'Diesel');
INSERT INTO utilise VALUES (5,'Essence');
INSERT INTO utilise VALUES (5,'GPL');
INSERT INTO utilise VALUES (6,'Diesel');
INSERT INTO utilise VALUES (6,'Essence');
INSERT INTO utilise VALUES (6,'Electrique');

INSERT INTO vehicule VALUES ('45VBJ7',20000,1,'Bernard');
INSERT INTO vehicule VALUES ('13FDF',45678,1,'Rodolf');
INSERT INTO vehicule VALUES ('234FGN',234098,2,'Rodolf');
INSERT INTO vehicule VALUES ('HH6DC',134567,2,'Karine');
INSERT INTO vehicule VALUES ('BGD56V',22334,3,'Karine');
INSERT INTO vehicule VALUES ('45FGH',1234,3,'Karine');
INSERT INTO vehicule VALUES ('345VBN',99322,4,'Haïfa');
INSERT INTO vehicule VALUES ('67FGH',76543,4,'Driss');
INSERT INTO vehicule VALUES ('9877GG',25678,5,'Mère Noël');
INSERT INTO vehicule VALUES ('HGF46',187368,5,'Mère Noël');
INSERT INTO vehicule VALUES ('FCF56',12356,6,'Mère Noël');


-- conpréhension schema
-- Voir td1-3 open office

-- Requête 

-- Requête 1

SELECT prop.nom
FROM proprietaire AS prop
INNER JOIN vehicule AS v ON prop.nom = v.nom_proprio
WHERE v.kilometrage > 100000;

-- Requête 2

SELECT m.consommation, c.pollution
FROM modele AS m
INNER JOIN utilise AS u ON m.idmodele = u.idmodele
INNER JOIN carburant AS c ON u.designation = c.designation
WHERE m.libelle = '4X4';

-- Requête 3

SELECT AVG(m.consommation) AS conso_moyenne,c.designation
FROM modele as m
INNER JOIN utilise AS u ON m.idmodele = u.idmodele
INNER JOIN carburant AS c ON u.designation = c.designation
WHERE c.pollution >'100g'
GROUP BY c.designation;