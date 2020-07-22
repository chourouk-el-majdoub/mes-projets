#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Jul 20 16:05:11 2020

@author: simplon
"""


import sqlalchemy 
import pandas as pd
engine = sqlalchemy.create_engine()

engine = create_engine('mysql+pymysql://simplon:simplon@localhost:3306/simplon')
data=pd.read_sql_query('select * from jeux_video', engine)
print(data)


engine = sql.create_engine('mysql+pymysql://simplon:simplon@localhost:3306/assurauto')
data2=pd.read_sql_query('select * from CLIENTS', engine)
print(data2)
MAXID = pd.read_sql_query("select max(CL_ID) as max FROM CLIENTS", engine)[max]
print(MAXID[0])


CL_NOM = str.upper(input("entrez votre nom :"))
print(CL_NOM)

CL_PRENOM = input("entrez votre prenom:")
CL_ADRESSE = input("entrez votre adresse")
CL_CODE_POSTAL = input("entrez votre code postal:")
CL_VILLE = input("entrez votre ville")
CL_FAX = input("entrez votre fax")
CL_TELEPHONE = input("entrez votre numero de telephone")
CL_EMAIL = input("entrez votre adresse mail")
engine.execute('insert into CLIENTS (CL_ID, CL_NOM, CL_PRENON, CL_ADRESSE, CL_CODE_POSTAL, CL_VILLE, CL_FAX, CL_TELEPHONE, CL_EMAIL)values(%s,"%s","%s","%s","%s","%s","%s","%s","%s");' %(MAXID[0]+1, CL_NOM, CL_PRENOM, CL_ADRESSE, CL_CODE_POSTAL, CL_VILLE, CL_FAX, CL_TELEPHONE, CL_EMAIL ))

while not(CL_CODE_POSTAL.isdigit()):
      print ('saisir un chiffre')
      CL_CODE_POSTAL =input('SAISIR UN CODE POSTAL')

data3=pd.read_sql_query('select * from CONTRAT', engine)
print(data3)
MAXID2 = pd.read_sql_query("select max(CO_NUM) as max FROM CONTRAT", engine)[max]
print(MAXID2[0])

CO_DATE	= input("saisir la date d'achat")
CO_CATEGORIE= input("categorie=")	
MAXID2 = pd.read_sql_query("select max(CO_NUM) as max FROM CONTRAT", engine)[max]
print(MAXID2[0])
engine.execute('insert into CONTRAT(CO_NUM,CO_DATE,CO_CATEGORIE,CL_ID_FK)values(%s,"%s","%s",%s);' %(MAXID2 ,CO_DATE,CO_CATEGORIE, MAXID[0]+1))