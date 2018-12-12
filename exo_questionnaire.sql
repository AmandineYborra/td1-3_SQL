DROP DATABASE IF EXISTS questionnaire;
CREATE DATABASE questionnaire;
USE questionnaire;

CREATE TABLE personne
(
numPers int primary key,
age int(4),
sexe CHAR(1),
numCat int
);

CREATE TABLE categorie
(
numCat int primary key,
intitule VARCHAR(45)
);

CREATE TABLE question
(
numQ int primary key,
descriptionQ VARCHAR(100)
);

CREATE TABLE avis
(
numA int primary key,
numQ int,
numPers int,
reponse VARCHAR(100)
);

ALTER TABLE personne ADD FOREIGN KEY(numCat) REFERENCES categorie(numCat);
ALTER TABLE avis ADD FOREIGN KEY(numQ) REFERENCES question(numQ);
ALTER TABLE avis ADD FOREIGN KEY(numPers) REFERENCES personne(numPers);

INSERT INTO personne VALUES (1,18,'M',1);
INSERT INTO personne VALUES (2,20,'F',1);
INSERT INTO personne VALUES (3,25,'F',3);
INSERT INTO personne VALUES (4,45,'M',3);
INSERT INTO personne VALUES (5,67,'M',4);
INSERT INTO personne VALUES (6,30,'M',2);

INSERT INTO categorie VALUES (1,'Etudiant');
INSERT INTO categorie VALUES (2,'Cadre');
INSERT INTO categorie VALUES (3,'Ouvrier');
INSERT INTO categorie VALUES (4,'Retraité');

INSERT INTO question VALUES (1,'baisse des impôts');
INSERT INTO question VALUES (2,'referendum européen');
INSERT INTO question VALUES (3,'augmentagtion du smic');
INSERT INTO question VALUES (4,'baisse de la vitesse de conduite');

INSERT INTO avis VALUES (1,1,1,'');
INSERT INTO avis VALUES (2,1,2,'oui');
INSERT INTO avis VALUES (3,2,2,'non');
INSERT INTO avis VALUES (4,2,3,'oui');
INSERT INTO avis VALUES (5,3,3,'');
INSERT INTO avis VALUES (6,3,4,'');
INSERT INTO avis VALUES (7,4,4,'non');
INSERT INTO avis VALUES (8,4,1,'');
INSERT INTO avis VALUES (9,1,5,'oui');
INSERT INTO avis VALUES (10,2,5,'oui');

-- Questions 

/* 
1. 
2. Une personne peut avoir plusieurs avis comme aucun.
3. cf schéma questionnaire
*/

-- Requêtes

-- requete 1

SELECT pers.numPers, pers.sexe, cat.intitule
FROM personne AS pers
INNER JOIN categorie AS cat ON pers.numCat = cat.numCat
WHERE pers.sexe = 'F'AND cat.intitule = 'Cadre';

-- requete 2

SELECT pers.numPers, pers.age
FROM personne AS pers
INNER JOIN avis AS a ON pers.numPers = a.numPers
WHERE pers.age > 25 AND a.reponse = '';

-- requete 3 

SELECT numQ, numA
FROM avis
GROUP BY numQ, numA
HAVING COUNT(numA) >30;

-- requete 4

SELECT COUNT(DISTINCT a.numPers) AS nbPers
FROM avis AS a
INNER JOIN question AS q ON a.numQ = q.numQ
WHERE q.descriptionQ = 'referendum européen' AND a.reponse = 'oui';

-- requete 5

SELECT pers.age
FROM personne AS pers 
INNER JOIN avis AS a ON pers.numPers = a.numPers
INNER JOIN question AS q ON a.numQ = q.numQ
WHERE pers.age > 40 AND q.descriptionQ = 'baisse des impôts' AND a.reponse = 'oui';