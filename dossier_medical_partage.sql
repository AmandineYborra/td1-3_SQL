DROP DATABASE IF EXISTS dossier_medical_partage;
CREATE DATABASE IF NOT EXISTS dossier_medical_partage;
USE dossier_medical_partage;

CREATE TABLE personne(
    noss int primary key auto_increment,
    nom varchar(45)not null,
    prenom varchar(45) not null,
    adresse varchar(80) not null
    );


CREATE TABLE consultation(
    NoCons int primary key auto_increment,
    dateCons date,
    Symptome VARCHAR(90),
    NossPat int,
    nossMed int,
    constraint fk_cons_nossPat foreign key (nossPat) references personne(noss),
    constraint fk_cons_nossMed foreign key (nossMed) references personne(noss)
    );


CREATE TABLE medicament(
    nomMed varchar(80) ,
    NomSubst varchar(80),
    Prix int default 0,
    constraint pk_medicament primary key (nomMed, NomSubst)
    );

CREATE TABLE prescription(
    noCons int,
    NomMed varchar(80),
    constraint fk_presc_nocons foreign key (noCons) references consultation(nocons),
    constraint fk_presc_nomMed foreign key (nomMed) references medicament(nomMed)
    );

INSERT INTO personne(nom, prenom, adresse)VALUES('Rodgers','Francis','45400 FLEURY'),
    ('Lamy','Louise','64700 MAISONS'),('Vaillancourt','Ally','97440 SAINT ANDRE'),('Vachel','Guertin','84200 CARPENTRAS'),
    ('Briard', 'Luc', '49400 SAUMUR'),('Flore','Cloutier','34300 Agde');

INSERT INTO consultation (symptome,nossPat,nossMed,dateCons)VALUES('toux seche',1,2,'2018/12/09'),('toux seche',3,2,'2018/12/09'),('toux grasse',4,5,'2018/12/10'),
    ('toux seche',1,5,'2018/12/09'),('toux seche',3,5,'2018/12/11');

INSERT INTO medicament(nomMed,nomSubst,Prix)VALUES('Humex','Noscapine',5.75),('Fluimucil','Noscapine',7.80),('Aspirine','Aspirine',3.9);

INSERT INTO prescription(nocons,nommed)VALUES(1,'Humex'),(2,'Aspirine');

-- question a

SELECT pers.nom, pers.prenom, pers.adresse, c.symptome, p.NomMed
FROM consultation AS c
INNER JOIN personne as pers ON c.NossPat = pers.noss
INNER JOIN prescription as p ON c.NoCons = p.NoCons
WHERE c.symptome = 'Toux sèche';

-- question b

SELECT c.dateCons, pers.nom, pers.prenom
FROM consultation AS c
INNER JOIN personne AS pers ON c.NossPat = pers.noss
WHERE c.symptome = 'Toux sèche' 
GROUP BY pers.nom, c.dateCons
HAVING COUNT(c.nossMed) >=2;

-- question c 

SELECT pers.nom, pers.prenom
FROM personne AS pers
INNER JOIN consultation AS c ON pers.noss = c.nossMed
INNER JOIN prescription AS p ON c.noCons = p.noCons
INNER JOIN medicament AS m ON p.nomMed = m.nomMed
WHERE m.NomSubst= 'Noscapine' AND c.Symptome = 'Toux sèche'; 
/* Désolée c'est l'inverse*/
    
-- question d

SELECT nomMed, NomSubst, prix
FROM medicament
WHERE nomSubst = 'Noscapine'
ORDER BY prix LIMIT 1;

-- question e 

SELECT nomSubst, nomMed, 
AVG(prix) AS prix_moyen, 
MIN(prix) AS prix_min
FROM medicament
GROUP BY nomMed;
