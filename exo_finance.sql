DROP DATABASE IF EXISTS finance;
CREATE DATABASE finance;
USE finance;

CREATE TABLE compte
(
idCompte int primary key,
idClient int,
solde int,
resume int
);

CREATE TABLE action
(
idAction int,
idCompte int,
montant int
);

CREATE TABLE client
(
idClient int primary key,
nom VARCHAR(45),
prenom VARCHAR(45),
adresse VARCHAR(100),
annee int
);

ALTER TABLE action ADD PRIMARY KEY (idAction, idCompte);
ALTER TABLE compte ADD FOREIGN KEY (idClient) REFERENCES client(idClient);

INSERT INTO client VALUES (1,'Noel','Mère','12 rue du pôle Nord',1990);
INSERT INTO client VALUES (2,'Noel','Père','12 rue du pôle Nord',1967);
INSERT INTO client VALUES (3,'Renne','Rudolphe','4 avenue du Sucre Orge',1978);
INSERT INTO client VALUES (4,'Fouettard','Lepère','3 Avenue du martinet',1987);
INSERT INTO client VALUES (5,'Lutin','willow','2 rue de la fabrique',1963);
INSERT INTO client VALUES (6,'Biscuit','Petit','67 rue de la boulangerie',2000);
INSERT INTO client VALUES (7,'Sapin','Boule','89 impasse Arbre',1954);
INSERT INTO client VALUES (30,'Dupont','Jean','1 rue Pasteur',1978);

INSERT INTO compte VALUES (1,30,5,0);
INSERT INTO compte VALUES (2,2,2345,2);
INSERT INTO compte VALUES (3,3,1222,5);
INSERT INTO compte VALUES (4,4,23,3);
INSERT INTO compte VALUES (5,5,456,14);
INSERT INTO compte VALUES (6,6,234,34);
INSERT INTO compte VALUES (7,7,12345,12);
INSERT INTO compte VALUES (8,1,876,1);

INSERT INTO action VALUES (1,1,+10);
INSERT INTO action VALUES (2,1,+5);
INSERT INTO action VALUES (3,1,-10);

-- Requetes

-- requete 1

SELECT nom, prenom, idClient 
FROM client
WHERE idClient < 1000 AND annee >1968;

-- requete 2

SELECT co.idCompte
FROM compte AS co
INNER JOIN client AS cl ON co.idClient = cl.idClient
WHERE co.solde > 1000 AND cl.nom = 'Dupont';

-- requete 3

SELECT cl.idClient, ac.montant
FROM client AS cl
INNER JOIN compte AS co ON cl.idClient = co.idCLient 
INNER JOIN action AS ac ON co.idCompte = ac.idCompte
WHERE montant NOT IN
	(SELECT montant FROM action WHERE montant < 0)
GROUP BY idClient;

-- requete 4

-- requete 5

SELECT idCompte, resume
FROM compte;
