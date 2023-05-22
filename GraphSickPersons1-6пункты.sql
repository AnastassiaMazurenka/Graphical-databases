--����

--����:
--������� (SickPerson)
--�������� (Hospital)
--�����    (City)

--�����:
--����������� (InfectedFrom) -- ������� ������� ������� ��������
--����� (LivesIn)   -- ����� ���������� ��������
--��������� (LocatedIn) -- ����� ��������� ��������
-- ������� (BeTreated) -- �����(��������), ��� ������� �������� �������

Use master;
DROP DATABASE IF EXISTS GrafOfInfection;
CREATE DATABASE GrafOfInfection;


USE GrafOfInfection;


CREATE TABLE SickPerson 
(
 id INT NOT NULL PRIMARY KEY,
 name NVARCHAR(50) NOT NULL
) AS NODE;



CREATE TABLE City
(
id INT NOT NULL PRIMARY KEY,
name NVARCHAR(30) NOT NULL,
region NVARCHAR(30) NOT NULL
) AS NODE;


CREATE TABLE Hospital
(
id INT NOT NULL PRIMARY KEY,
name NVARCHAR(50) NOT NULL,
city NVARCHAR(30) NOT NULL
) AS NODE;


CREATE TABLE InfectedFrom AS EDGE; 

CREATE TABLE LivesIn AS EDGE;-- ����� ������� ���� � ������
CREATE TABLE LocatedIn AS EDGE;-- ����� �������� ��������� � ������
CREATE TABLE BeTreated (betreated INT) AS EDGE;-- ����� ������� ������� � �������� (betreated -- ���� ��������) 


ALTER TABLE InfectedFrom
ADD CONSTRAINT EC_InfectedFrom CONNECTION (SickPerson TO SickPerson);

ALTER TABLE LivesIn
ADD CONSTRAINT EC_LivesIn CONNECTION (SickPerson TO City);
ALTER TABLE LocatedIn
ADD CONSTRAINT EC_LocatedIn CONNECTION (Hospital TO City);
ALTER TABLE BeTreated
ADD CONSTRAINT EC_BeTreated CONNECTION (SickPerson TO Hospital);
GO





--���������

INSERT INTO SickPerson (id, name)
VALUES (1, N'����'),
       (2, N'����'),
       (3, N'����'),
       (4, N'����'),
       (5, N'����'),
       (6, N'����'),
       (7, N'ϸ��'),
       (8, N'���'),
       (9, N'�����'),
       (10, N'�������');
GO
SELECT *
FROM SickPerson;



INSERT INTO City (id, name, region)
VALUES (1, N'�����', N'�������'),
       (2, N'�����', N'����������'),
       (3, N'������', N'����������'),
       (4, N'�����', N'���������'),
       (5, N'�������', N'���������'),
       (6, N'������', N'�����������'),
       (7, N'�������', N'�����������'),
       (8, N'����������', N'���������'),
       (9, N'����', N'���������'),
       (10, N'������', N'����������');
GO
SELECT *
FROM City;



INSERT INTO Hospital (id, name, city)
VALUES (1, N'��������10', N'�����'),
       (2, N'��������5', N'�����'),
       (3, N'������� ��������', N'������'),
       (4, N'��������� ��������', N'�����'),
       (5, N'��������� ��������', N'�������'),
       (6, N'��������������� ��������', N'������'),
       (7, N'������� ��������', N'�����'),
       (8, N'�������� ��� ���������', N'�������'),
       (9, N'�������� �1', N'�����'),
       (10, N'������� "������"', N'������');
GO
SELECT *
FROM Hospital;


INSERT INTO InfectedFrom ($from_id, $to_id)
VALUES 
        ((SELECT $node_id FROM SickPerson WHERE id = 1),(SELECT $node_id FROM SickPerson WHERE id = 2)),
        ((SELECT $node_id FROM SickPerson WHERE id = 1),(SELECT $node_id FROM SickPerson WHERE id = 5)),
        ((SELECT $node_id FROM SickPerson WHERE id = 2),(SELECT $node_id FROM SickPerson WHERE id = 3)),
        ((SELECT $node_id FROM SickPerson WHERE id = 3),(SELECT $node_id FROM SickPerson WHERE id = 1)),
        ((SELECT $node_id FROM SickPerson WHERE id = 3),(SELECT $node_id FROM SickPerson WHERE id = 6)),
        ((SELECT $node_id FROM SickPerson WHERE id = 4),(SELECT $node_id FROM SickPerson WHERE id = 2)),
        ((SELECT $node_id FROM SickPerson WHERE id = 5),(SELECT $node_id FROM SickPerson WHERE id = 4)),
        ((SELECT $node_id FROM SickPerson WHERE id = 6), (SELECT $node_id FROM SickPerson WHERE id = 10)),
        ((SELECT $node_id FROM SickPerson WHERE id = 6),(SELECT $node_id FROM SickPerson WHERE id = 8)),
        ((SELECT $node_id FROM SickPerson WHERE id = 7),(SELECT $node_id FROM SickPerson WHERE id = 6)),       
        ((SELECT $node_id FROM SickPerson WHERE id = 7),(SELECT $node_id FROM SickPerson WHERE id = 10)),
        ((SELECT $node_id FROM SickPerson WHERE id = 8),(SELECT $node_id FROM SickPerson WHERE id = 3)),
        ((SELECT $node_id FROM SickPerson WHERE id = 9),(SELECT $node_id FROM SickPerson WHERE id = 8)),
        ((SELECT $node_id FROM SickPerson WHERE id = 10),(SELECT $node_id FROM SickPerson WHERE id = 9));


GO
SELECT *
FROM InfectedFrom;



INSERT INTO LivesIn ($from_id, $to_id)
VALUES 
        ((SELECT $node_id FROM SickPerson WHERE ID = 1),(SELECT $node_id FROM City WHERE ID = 1)),
        ((SELECT $node_id FROM SickPerson WHERE ID = 5),(SELECT $node_id FROM City WHERE ID = 1)),
        ((SELECT $node_id FROM SickPerson WHERE ID = 2),(SELECT $node_id FROM City WHERE ID = 2)),
        ((SELECT $node_id FROM SickPerson WHERE ID = 3),(SELECT $node_id FROM City WHERE ID = 3)),
        ((SELECT $node_id FROM SickPerson WHERE ID = 4),(SELECT $node_id FROM City WHERE ID = 3)),
        ((SELECT $node_id FROM SickPerson WHERE ID = 7),(SELECT $node_id FROM City WHERE ID = 4)),
        ((SELECT $node_id FROM SickPerson WHERE ID = 6),(SELECT $node_id FROM City WHERE ID = 5)),
        ((SELECT $node_id FROM SickPerson WHERE ID = 10),(SELECT $node_id FROM City WHERE ID = 6)),
        ((SELECT $node_id FROM SickPerson WHERE ID = 9),(SELECT $node_id FROM City WHERE ID = 7)),
        ((SELECT $node_id FROM SickPerson WHERE ID = 8),(SELECT $node_id FROM City WHERE ID = 9));
       


INSERT INTO LocatedIn ($from_id, $to_id)
VALUES 
        ((SELECT $node_id FROM Hospital WHERE ID = 1),(SELECT $node_id FROM City WHERE ID = 1)),
        ((SELECT $node_id FROM Hospital WHERE ID = 2),(SELECT $node_id FROM City WHERE ID = 2)),
        ((SELECT $node_id FROM Hospital WHERE ID = 3),(SELECT $node_id FROM City WHERE ID = 3)),
        ((SELECT $node_id FROM Hospital WHERE ID = 4),(SELECT $node_id FROM City WHERE ID = 4)),
        ((SELECT $node_id FROM Hospital WHERE ID = 5),(SELECT $node_id FROM City WHERE ID = 5)),
        ((SELECT $node_id FROM Hospital WHERE ID = 6),(SELECT $node_id FROM City WHERE ID = 6)),
        ((SELECT $node_id FROM Hospital WHERE ID = 7),(SELECT $node_id FROM City WHERE ID = 1)),  
        ((SELECT $node_id FROM Hospital WHERE ID = 8),(SELECT $node_id FROM City WHERE ID = 7)),
        ((SELECT $node_id FROM Hospital WHERE ID = 9),(SELECT $node_id FROM City WHERE ID = 2)),
        ((SELECT $node_id FROM Hospital WHERE ID = 10),(SELECT $node_id FROM City WHERE ID = 10));


INSERT INTO BeTreated ($from_id, $to_id, betreated)
VALUES 
        ((SELECT $node_id FROM SickPerson WHERE ID = 1),(SELECT $node_id FROM Hospital WHERE ID = 1), 10),
        ((SELECT $node_id FROM SickPerson WHERE ID = 8),(SELECT $node_id FROM Hospital WHERE ID = 1), 9),
        ((SELECT $node_id FROM SickPerson WHERE ID = 2),(SELECT $node_id FROM Hospital WHERE ID = 2), 6),
        ((SELECT $node_id FROM SickPerson WHERE ID = 3),(SELECT $node_id FROM Hospital WHERE ID = 3), 9),
        ((SELECT $node_id FROM SickPerson WHERE ID = 4),(SELECT $node_id FROM Hospital WHERE ID = 3), 8),
        ((SELECT $node_id FROM SickPerson WHERE ID = 6),(SELECT $node_id FROM Hospital WHERE ID = 4), 10),
        ((SELECT $node_id FROM SickPerson WHERE ID = 2),(SELECT $node_id FROM Hospital WHERE ID = 5), 8),
        ((SELECT $node_id FROM SickPerson WHERE ID = 5),(SELECT $node_id FROM Hospital WHERE ID = 6), 9), 
        ((SELECT $node_id FROM SickPerson WHERE ID = 9),(SELECT $node_id FROM Hospital WHERE ID = 6), 7),
        ((SELECT $node_id FROM SickPerson WHERE ID = 1),(SELECT $node_id FROM Hospital WHERE ID = 7), 7),
        ((SELECT $node_id FROM SickPerson WHERE ID = 7),(SELECT $node_id FROM Hospital WHERE ID = 8), 7),
        ((SELECT $node_id FROM SickPerson WHERE ID = 8),(SELECT $node_id FROM Hospital WHERE ID = 9), 2), 
        ((SELECT $node_id FROM SickPerson WHERE ID = 10),(SELECT $node_id FROM Hospital WHERE ID = 10), 5);


 SELECT SickPerson1.name
 , SickPerson2.name AS [sick name]
FROM SickPerson AS SickPerson1
 , InfectedFrom
 , SickPerson AS SickPerson2
WHERE MATCH(SickPerson1-(InfectedFrom)->SickPerson2)
 AND SickPerson1.name = N'�����';

 SELECT SickPerson1.name
 , SickPerson2.name AS [sick name]
FROM SickPerson AS SickPerson1
 INNER JOIN InfectedFrom ON SickPerson1.$node_id = InfectedFrom.$from_id
 INNER JOIN SickPerson AS SickPerson2 ON SickPerson2.$node_id =
InfectedFrom.$to_id
WHERE SickPerson1.name = N'���'



--���� ������� ����
SELECT SickPerson1.name + N' ������� ' + SickPerson2.name AS Level1
 , SickPerson2.name + N' ������� ' + SickPerson3.name AS Level2
FROM SickPerson AS SickPerson1
 , InfectedFrom AS Infected1
 , SickPerson AS SickPerson2
 , InfectedFrom AS Infected2
 , SickPerson AS SickPerson3
WHERE MATCH(SickPerson1-(Infected1)->SickPerson2-(Infected2)->SickPerson3)
 AND SickPerson1.name = N'����';



SELECT SickPerson2.name AS sickperson
 , Hospital.name AS hospital
 , BeTreated.betreated
FROM SickPerson AS sickperson1
 , SickPerson AS sickperson2
 , BeTreated
 , InfectedFrom
 , Hospital
WHERE MATCH(sickperson1-(InfectedFrom)->sickperson2-(BeTreated)->Hospital)
 AND sickperson1.name = N'����';


 SELECT SickPerson2.id AS sickperson
 , Hospital.id AS hospital
 , BeTreated.betreated
FROM SickPerson AS sickperson1
 , SickPerson AS sickperson2
 , BeTreated
 , InfectedFrom
 , Hospital
WHERE MATCH(sickperson1-(InfectedFrom)->sickperson2-(BeTreated)->Hospital)
 AND sickperson1.id = 8;


 SELECT SickPerson1.name AS PersonName
 , STRING_AGG(SickPerson2.name, '->') WITHIN GROUP (GRAPH PATH)
AS SICKPEOPLE
FROM SickPerson AS SickPerson1
 , InfectedFrom FOR PATH AS Infected
 , SickPerson FOR PATH AS SickPerson2
WHERE MATCH(SHORTEST_PATH(SickPerson1(-(Infected)->SickPerson2)+))
 AND SickPerson1.name = N'����';



  SELECT SickPerson1.name AS PersonName
 , STRING_AGG(Hospital.name, '->') WITHIN GROUP (GRAPH PATH)
AS SICKPEOPLE
FROM SickPerson AS SickPerson1
 , BeTreated FOR PATH AS beTreated
 , Hospital FOR PATH AS hospital
WHERE MATCH(SHORTEST_PATH(SickPerson1(-(beTreated)->hospital)+))
 AND SickPerson1.name = N'����';


 SELECT @@SERVERNAME

 --������ ������ ��� �����
 --��� �� ���� ���������
 SELECT SickPerson1.id IdFirst
		, SickPerson1.name AS First
		, CONCAT(N'SickPerson', SickPerson1.id) AS [First image name]
		, SickPerson2.id IdSecond
		, SickPerson2.name AS Second
		, CONCAT(N'SickPrson', SickPerson2.id) AS [Second image name]
FROM SickPerson AS SickPerson1
	, InfectedFrom
	 , SickPerson AS SickPerson2
WHERE MATCH(SickPerson1-(InfectedFrom)->SickPerson2) 

-- ������ ������ 
-- ��� ��� ���������

SELECT SickPerson.id IdSickPerson
		, SickPerson.name AS SickPerson
		, CONCAT(N'SickPerson', SickPerson.id) AS [SickPerson image name]
		, City.id IdCity
		, City.name AS City
		, CONCAT(N'City', City.id) AS [City image name]
FROM SickPerson
	, LivesIn
	, City
WHERE MATCH(SickPerson-(LivesIn)->City) 


--������ ������
--����� �������� � ����� ������ ���������

SELECT Hospital.id IdHospital
		, Hospital.name AS Hospital
		, CONCAT(N'Hospital', Hospital.id) AS [Hospital image name]
		, City.id IdCity
		, City.name AS City
		, CONCAT(N'City', City.id) AS [City image name]
FROM Hospital
	, LocatedIn
	, City
WHERE MATCH(Hospital-(LocatedIn)->City) 

--��������� ������
--��� � ����� �������� ������� � ��� �� ������

 SELECT SickPerson.id IdSickPerson
		, SickPerson.name AS SickPerson
		, CONCAT(N'SickPerson', SickPerson.id) AS [SickPerson image name]
		, Hospital.id IdHospital
		, Hospital.name AS Hospital
		, CONCAT(N'Hospital', Hospital.id) AS [Hospital image name]
		, BeTreated.betreated
FROM SickPerson
	, BeTreated
	, Hospital 
WHERE MATCH(SickPerson-(BeTreated)->Hospital) 
