-- création d'un schéma XML pour validation des données d'une colonne XML

CREATE XML SCHEMA COLLECTION XSC_DONNEES_ENTREPRISE as 
N'
<xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:company="http://www.exemple.com/entreprise"
    targetNamespace="http://www.exemple.com/entreprise" elementFormDefault="qualified">
  <xs:element name="personnel">
    <xs:complexType>
      <xs:choice maxOccurs="unbounded">
        <xs:element name="employe">
          <xs:complexType>
            <xs:all>
              <xs:element name="nom" type="xs:string" />
            </xs:all>
            <xs:attribute name="matricule" type="xs:ID" />
          </xs:complexType>
        </xs:element>
      </xs:choice>
    </xs:complexType>
  </xs:element>
</xs:schema>'
GO

-- cette table possède une colonne de type XML dont les données 
-- doivent se conformer au schéma ci avant

CREATE TABLE T_ENTREPRISE_EMPLOIS_EEP
(EEP_ID         INTEGER PRIMARY KEY IDENTITY, 
 EEP_NAME       VARCHAR(12),
 EEP_XML_DATA   XML (XSC_DONNEES_ENTREPRISE))
GO


-- insertion de deux listes d'employés 
-- pour les entreprises IBM et Microsoft

INSERT INTO T_ENTREPRISE_EMPLOIS_EEP 
       VALUES ('IBM',
'<personnel xmlns="http://www.exemple.com/entreprise">
  <employe matricule="M0108"><nom>Jean</nom></employe>
  <employe matricule="X0017"><nom>Jacques</nom></employe>
  <employe matricule="V0009"><nom>Jules</nom></employe>
</personnel>')

INSERT INTO T_ENTREPRISE_EMPLOIS_EEP 
       VALUES ('Microsoft',
'<personnel xmlns="http://www.exemple.com/entreprise">
  <employe matricule="AC23"><nom>Marc</nom></employe>
  <employe matricule="VF42"><nom>Marcel</nom></employe>
</personnel>')
GO

-- voir les données brutes
SELECT *
FROM   T_ENTREPRISE_EMPLOIS_EEP

-- extraire un fragment XML pour chaque noeuds
WITH XMLNAMESPACES (DEFAULT 'http://www.exemple.com/entreprise')
SELECT EEP_ID as [Clef entreprise], 
       NoeudXML.query('.')
FROM   T_ENTREPRISE_EMPLOIS_EEP
       CROSS APPLY EEP_XML_DATA.nodes('/personnel/employe') as T(NoeudXML)

-- convertir des attribust et balises en données XML sous forme de colonnes
WITH XMLNAMESPACES (DEFAULT 'http://www.exemple.com/entreprise')
SELECT EEP_ID as [Clef entreprise], 
       NoeudXML.value( './@matricule', 'nvarchar(10)' ) as [Matricule employé],
       NoeudXML.value( './nom', 'nvarchar(16)' ) as [Nom employé]
FROM   T_ENTREPRISE_EMPLOIS_EEP
       CROSS APPLY EEP_XML_DATA.nodes('/personnel/employe') as T(NoeudXML)

-- extraction de la liste des employés de toutes les entreprises
-- dont le nom comporte la lettre 'a'
WITH XMLNAMESPACES (DEFAULT 'http://www.exemple.com/entreprise')
SELECT EEP_ID as [Clef entreprise], 
       NoeudXML.value( './@matricule', 'nvarchar(10)' ) as [Matricule employé],
       NoeudXML.value( './nom', 'nvarchar(16)' ) as [Nom employé]
FROM   T_ENTREPRISE_EMPLOIS_EEP
       CROSS APPLY EEP_XML_DATA.nodes('/personnel/employe') as T(NoeudXML)
WHERE  NoeudXML.value( './nom', 'nvarchar(16)' ) LIKE '%a%'
