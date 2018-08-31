
/* Utilisation de la base SQC_DB */
USE [SQC_DB]
GO

/* ------------------------------------------------------------- */
/* TABLE : T_PARAM_MAILING                                       */
/* ------------------------------------------------------------- */
DELETE FROM T_PARAM_MAILING 
INSERT INTO T_PARAM_MAILING (Id, Nom, Description, Valeur) VALUES (1, 'MAILING_SERVEUR_SMTP', 'Serveur SMTP', 'b=_J?JKD_DhX__?mD=')
INSERT INTO T_PARAM_MAILING (Id, Nom, Description, Valeur) VALUES (2, 'MAILING_ALIAS', 'Alias de la messagerie', 'bMmJlDn')
INSERT INTO T_PARAM_MAILING (Id, Nom, Description, Valeur) VALUES (3, 'MAILING_ADRESSE', 'Adresse de messagerie', 'bMmJlDn@JKD_DhX__?mD=')
INSERT INTO T_PARAM_MAILING (Id, Nom, Description, Valeur) VALUES (4, 'MAILING_MOT_DE_PASSE', 'Mot de passe', '7MmJl3nN')

/* ------------------------------------------------------------- */
/* TABLE : TP_EMAIL_CONTEXTE                                     */
/* ------------------------------------------------------------- */

/* Suppression des nouveaux contextes */
DELETE FROM TP_EMAIL_CONTEXTE WHERE IdContexte in (1)

/* Envoi d'un mail lors de l'enregistrement d'une palette finale */
INSERT INTO TP_EMAIL_CONTEXTE (IdContexte, Libelle, Observations, Actif, Rang)
VALUES (1, 'Creation Palette Finale', 'Envoi d''un mail lors de l''enregistrement d''une palette finale', -1, 1)

/* Envoi d'un mail lors de l'enregistrement d'une palette finale */
INSERT INTO TP_EMAIL_CONTEXTE (IdContexte, Libelle, Observations, Actif, Rang)
VALUES (2, 'Creation Palette Transit', 'Envoi d''un mail lors de l''enregistrement d''une palette de transit', -1, 2)

/* ------------------------------------------------------------- */
/* TABLE : TP_EMAIL_DESTINATAIRE                                 */
/* ------------------------------------------------------------- */

/* Suppression des nouveaux destinataires */
DELETE FROM TP_EMAIL_DESTINATAIRE WHERE IdDestinataire in (1,2,3)

/* Yannick BOURNAY */
INSERT INTO TP_EMAIL_DESTINATAIRE (Nom, Prenom, Adresse, Observations, Rang)
VALUES ('BOURNAY', 'Yannick', 'Y.Bournay@photowatt.com', 'Yannick BOURNAY', 1)

/* Bertrand MUET */
INSERT INTO TP_EMAIL_DESTINATAIRE (Nom, Prenom, Adresse, Observations, Rang)
VALUES ('MUET', 'Bertrand', 'B.MUET@photowatt.com', 'Bertrand MUET', 2)

/* ------------------------------------------------------------- */
/* TABLE : TP_EMAIL_CONTEXTE ('Creation Palette Finale)          */
/* ------------------------------------------------------------- */

/* Titre du mail */
UPDATE TP_EMAIL_CONTEXTE
SET		TitreEmail = 'CONSTITUTION DE LA PALETTE FINALE ''<ID_PALETTE>'''
WHERE IdContexte = 1

/* Texte du mail */
UPDATE TP_EMAIL_CONTEXTE
SET		TexteEmail = 
'<!DOCTYPE HTML PUBLIC ""-//W3C//DTD HTML 4.0 Transitional//EN""> 
<HTML>
<BR>
<TABLE BORDER="1" width=500 bordercolor="blue"> 
<TR><TH ALIGN=center COLSPAN=2 BGCOLOR="orangered"><b>PALETTE FINALE : <ID_PALETTE></b></TH> 
<TR><TH ALIGN=left width=30% BGCOLOR="salmon">Forcage</TH><TD ALIGN=center><FORCAGE></TD></TR> 
<TR><TH ALIGN=left width=30% BGCOLOR="salmon">Rejets</TH><TD ALIGN=center><Rejets></TD></TR> 
<TR><TH ALIGN=center COLSPAN=2 BGCOLOR="orangered"><b>OPERATEUR</b></TH> 
<TR><TH ALIGN=left width=30% BGCOLOR="salmon">Operateur</TH><TD ALIGN=center><OPERATEUR></TD></TR> 
<TR><TH ALIGN=left width=30% BGCOLOR="salmon">Equipe</TH><TD ALIGN=center><EQUIPE></TD></TR> 
<TR><TH ALIGN=left width=30% BGCOLOR="salmon">Poste</TH><TD ALIGN=center><POSTE></TD></TR> 
<TR><TH ALIGN=center COLSPAN=2 BGCOLOR="orangered"><b>QUANTITES</b></TH> 
<TR><TH ALIGN=left width=30% BGCOLOR="salmon">Nombre de cartons</TH><TD ALIGN=center><NOMBRECARTONS></TD></TR> 
<TR><TH ALIGN=left width=30% BGCOLOR="salmon">Nombre de cellules</TH><TD ALIGN=center><NOMBRECELLULES></TD></TR> 
<TR><TH ALIGN=center COLSPAN=2 BGCOLOR="orangered"><b>DATE & LIEU</b></TH> 
<TR><TH ALIGN=left width=30% BGCOLOR="salmon">Créée le</TH><TD ALIGN=center><DATEHEURE></TD></TR> 
<TR><TH ALIGN=left width=30% BGCOLOR="salmon">Société</TH><TD ALIGN=center><SOCIETE></TD></TR> 
<TR><TH ALIGN=left width=30% BGCOLOR="salmon">Atelier</TH><TD ALIGN=center><ATELIER></TD></TR> 
<TR><TH ALIGN=center COLSPAN=2 BGCOLOR="orangered"><b>CARACTERISTIQUES DES CELLULES</b></TH> 
<TR><TH ALIGN=left width=30% BGCOLOR="salmon">Format</TH><TD ALIGN=center><FORMAT></TD></TR> 
<TR><TH ALIGN=left width=30% BGCOLOR="salmon">Classe</TH><TD ALIGN=center><CLASSE></TD></TR> 
<TR><TH ALIGN=left width=30% BGCOLOR="salmon">Code logistique</TH><TD ALIGN=center><LOGISTIQUE></TD></TR> 
<TR><TH ALIGN=left width=30% BGCOLOR="salmon">Matériau</TH><TD ALIGN=center><MATERIAU></TD></TR> 
<TR><TH ALIGN=left width=30% BGCOLOR="salmon">Tri</TH><TD ALIGN=center><TRI></TD></TR> 
</TABLE> 
<BR><BR>
<FONT COLOR=#ff0000 SIZE="6px">
<B>Ceci est un mail envoyé par SQC. Si vous ne voulez plus en être le destinataire, veuillez contacter l''administrateur SQC.</B>
</FONT>
</HTML>'
WHERE IdContexte = 1

/* Requete associée au mail */
UPDATE TP_EMAIL_CONTEXTE
SET		InfosEmail = 
'SELECT	
 P.Id as ''<ID_PALETTE>'', 
 IIF(P.Forçage = 0,''NON'', ''OUI'')  as ''<FORCAGE>'',
 IIF(P.Rejets = 0,''NON'', ''OUI'')  as ''<REJETS>'',
 A.NomAtelier as ''<ATELIER>'', 
 T.NomTri as ''<TRI>'', 
 F.Format_ as ''<FORMAT>'', 
 REPLACE(C.Classe,''_'', ''.'') as ''<CLASSE>'', 
 L.CodeLog as ''<LOGISTIQUE>'', 
 IIF(L.IdSociete = 1,''EDF ENR PWT'', ''PV Alliance'')  as ''<SOCIETE>'',
 M.Materiau as ''<MATERIAU>'',
 P.DateHeure as ''<DATEHEURE>'',
 P.DateDebPoste as ''<DATEPOSTE>'',
 O.Nom + '' '' + O.Prenom + '' ('' + TRIM(O.Matricule) + '')'' as ''<OPERATEUR>'',
 P.Equipe as ''<EQUIPE>'',
 P.Poste as ''<POSTE>'',
 NCA.Quantite as ''<NOMBRECARTONS>'',
 NCE.Quantite as ''<NOMBRECELLULES>''
FROM	
 T_PALETTE P, T_ATELIER A, T_TRI T, T_FORMAT F, T_ClasseCellule C, T_Logistique L, T_materiau M, T_OPerateur O,
 (SELECT COUNT(Id) AS QUANTITE FROM T_CARTON WHERE IdPalette = %1%) NCA,
 (SELECT SUM(CO.NbCellule) AS QUANTITE FROM T_COQUILLE CO, T_CARTON CA WHERE CA.IdPalette = %1% AND CA.Id = CO.IdCarton) NCE
WHERE P.Id = %1%
AND P.IdAtelierMaj = A.Id  
AND P.IdTriMaj = T.Id 
AND P.IdFormat = F.Id 
AND P.IdClasseMaj = C.Id 
AND P.IdLogistique  = L.Id 
AND L.Idmateriau  = M.Id
AND P.IdOper  = O.Id' 
WHERE IdContexte = 1

/* ------------------------------------------------------------- */
/* TABLE : TP_EMAIL_CONTEXTE ('Creation Palette Transit)         */
/* ------------------------------------------------------------- */

/* Titre du mail */
UPDATE TP_EMAIL_CONTEXTE
SET		TitreEmail = 'CONSTITUTION DE LA PALETTE DE TRANSIT ''<ID_PALETTE>'''
WHERE IdContexte = 2

/* Texte du mail */
UPDATE TP_EMAIL_CONTEXTE
SET		TexteEmail = 
'<!DOCTYPE HTML PUBLIC ""-//W3C//DTD HTML 4.0 Transitional//EN""> 
<HTML>
<BR>
<TABLE BORDER="1" width=500 bordercolor="blue"> 
<TR><TH ALIGN=center COLSPAN=2 BGCOLOR="limegreen"><b>PALETTE DE TRANSIT : <ID_PALETTE></b></TH> 
<TR><TH ALIGN=left width=30% BGCOLOR="lightgreen">Forcage</TH><TD ALIGN=center><FORCAGE></TD></TR> 
<TR><TH ALIGN=left width=30% BGCOLOR="lightgreen">Rejets</TH><TD ALIGN=center><Rejets></TD></TR> 
<TR><TH ALIGN=center COLSPAN=2 BGCOLOR="limegreen"><b>OPERATEUR</b></TH> 
<TR><TH ALIGN=left width=30% BGCOLOR="lightgreen">Operateur</TH><TD ALIGN=center><OPERATEUR></TD></TR> 
<TR><TH ALIGN=left width=30% BGCOLOR="lightgreen">Equipe</TH><TD ALIGN=center><EQUIPE></TD></TR> 
<TR><TH ALIGN=left width=30% BGCOLOR="lightgreen">Poste</TH><TD ALIGN=center><POSTE></TD></TR> 
<TR><TH ALIGN=center COLSPAN=2 BGCOLOR="limegreen"><b>QUANTITES</b></TH> 
<TR><TH ALIGN=left width=30% BGCOLOR="lightgreen">Nombre de cartons</TH><TD ALIGN=center><NOMBRECARTONS></TD></TR> 
<TR><TH ALIGN=left width=30% BGCOLOR="lightgreen">Nombre de cellules</TH><TD ALIGN=center><NOMBRECELLULES></TD></TR> 
<TR><TH ALIGN=center COLSPAN=2 BGCOLOR="limegreen"><b>DATE & LIEU</b></TH> 
<TR><TH ALIGN=left width=30% BGCOLOR="lightgreen">Créée le</TH><TD ALIGN=center><DATEHEURE></TD></TR> 
<TR><TH ALIGN=left width=30% BGCOLOR="lightgreen">Société</TH><TD ALIGN=center><SOCIETE></TD></TR> 
<TR><TH ALIGN=left width=30% BGCOLOR="lightgreen">Atelier</TH><TD ALIGN=center><ATELIER></TD></TR> 
<TR><TH ALIGN=center COLSPAN=2 BGCOLOR="limegreen"><b>CARACTERISTIQUES DES CELLULES</b></TH> 
<TR><TH ALIGN=left width=30% BGCOLOR="lightgreen">Format</TH><TD ALIGN=center><FORMAT></TD></TR> 
<TR><TH ALIGN=left width=30% BGCOLOR="lightgreen">Code logistique</TH><TD ALIGN=center><LOGISTIQUE></TD></TR> 
<TR><TH ALIGN=left width=30% BGCOLOR="lightgreen">Matériau</TH><TD ALIGN=center><MATERIAU></TD></TR> 
<TR><TH ALIGN=left width=30% BGCOLOR="lightgreen">Tri</TH><TD ALIGN=center><TRI></TD></TR> 
</TABLE> 
<BR><BR>
<FONT COLOR=#ff0000 SIZE="6px">
<B>Ceci est un mail envoyé par SQC. Si vous ne voulez plus en être le destinataire, veuillez contacter l''administrateur SQC.</B>
</FONT>
</HTML>'
WHERE IdContexte = 2

/* Requete associée au mail */
UPDATE TP_EMAIL_CONTEXTE
SET		InfosEmail = 
'SELECT	
 P.Id as ''<ID_PALETTE>'', 
 IIF(P.Forçage = 0,''NON'', ''OUI'')  as ''<FORCAGE>'',
 IIF(P.Rejets = 0,''NON'', ''OUI'')  as ''<REJETS>'',
 A.NomAtelier as ''<ATELIER>'', 
 T.NomTri as ''<TRI>'', 
 F.Format_ as ''<FORMAT>'', 
 L.CodeLog as ''<LOGISTIQUE>'', 
 IIF(L.IdSociete = 1,''EDF ENR PWT'', ''PV Alliance'')  as ''<SOCIETE>'',
 M.Materiau as ''<MATERIAU>'',
 P.DateHeure as ''<DATEHEURE>'',
 P.DateDebPoste as ''<DATEPOSTE>'',
 O.Nom + '' '' + O.Prenom + '' ('' + TRIM(O.Matricule) + '')'' as ''<OPERATEUR>'',
 P.Equipe as ''<EQUIPE>'',
 P.Poste as ''<POSTE>'',
 NCA.Quantite as ''<NOMBRECARTONS>'',
 NCE.Quantite as ''<NOMBRECELLULES>''
FROM	
 T_PALETTE P, T_ATELIER A, T_TRI T, T_FORMAT F, T_ClasseCellule C, T_Logistique L, T_materiau M, T_OPerateur O,
 (SELECT COUNT(Id) AS QUANTITE FROM T_CARTON WHERE IdPalette = %1%) NCA,
 (SELECT SUM(CO.NbCellule) AS QUANTITE FROM T_COQUILLE CO, T_CARTON CA WHERE CA.IdPalette = %1% AND CA.Id = CO.IdCarton) NCE
WHERE P.Id = %1%
AND P.IdAtelierMaj = A.Id  
AND P.IdTriMaj = T.Id 
AND P.IdFormat = F.Id 
AND P.IdClasseMaj = C.Id 
AND P.IdLogistique  = L.Id 
AND L.Idmateriau  = M.Id
AND P.IdOper  = O.Id' 
WHERE IdContexte = 2
