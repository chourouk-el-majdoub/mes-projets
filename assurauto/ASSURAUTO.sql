create database IF NOT EXISTS assurauto;

create TABLE IF NOT EXISTS CLIENTS (
CL_ID INT NOT NULL PRIMARY KEY,
CL_NOM VARCHAR(15) NOT NULL,
CL_PRENON VARCHAR(15) NOT NULL,
CL_ADRESSE VARCHAR(30),
CL_CODE_POSTAL INT(5),
CL_VILLE CHAR(10),
CL_FAX VARCHAR(15),
CL_TELEPHONE VARCHAR(15),
CL_EMAIL VARCHAR(50)
);
create TABLE IF NOT EXISTS CONTRAT (
CO_NUM INT NOT NULL PRIMARY KEY,
CO_DATE date,
CO_CATEGORIE VARCHAR(50),
CO_BONUS FLOAT(20),
CO_MALUS FLOAT(20),
CL_ID_FK INT NOT NULL,
FOREIGN KEY (CL_ID_FK) REFERENCES CLIENTS(CL_ID)
);
INSERT INTO CLIENTS (CL_ID,CL_NOM,CL_PRENON,CL_ADRESSE,CL_CODE_POSTAL,CL_VILLE,CL_FAX,CL_TELEPHONE,CL_EMAIL) VALUES
(1,'bouazza','nedra','avenue du jasmin',06400,'cannes','23467','0609088875','nedrabouazza@gmail.com'),
(2,'paul','debolina','avenue de jules greg',06600,'antibes','43526','0786543522','pauldebolina@gmail.com'),
(3,'tarek','bouraoui','avenue de jerome massier',06400,'cannes','23145','0654321988','tarekbouraoui@gmail.com');
select * from CLIENTS;
INSERT INTO CONTRAT (CO_NUM,CO_DATE,CO_CATEGORIE,CO_BONUS,CO_MALUS,CL_ID_FK) VALUES 
(4,'2019-01-06','TOURISME',12,3,1),
(5,'2000-03-09','UTILITAIRE',19,2,2),
(6,'2014-05-05','TOURISME',22,4,3);
select * from CONTRAT;



