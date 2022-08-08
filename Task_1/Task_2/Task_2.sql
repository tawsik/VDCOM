USE Vdcom;
CREATE TABLE Counterparty(
Counterparty_id NVARCHAR(30),
version int,
name NVARCHAR(30),
address NVARCHAR(30));

INSERT INTO Counterparty VALUES
('5426df5632rf7410gf',0,'Ivanov','Samara'),
('5426df5632rf7410gf',2,'Ivanov S.A','Samara,st.Lenina,6'),
('5426df5632rf7410gf',1,'Ivanov S','Samara'),
('5426df5632rf7410gf',4,'Ivanov S.V.','Samara, st.Lenina,6'),
('5426df5632rf7410gf',5,'Ivanov S.V.','Samara, st.Lenina,26'),
('5426df5632rf7410gf',3,'Ivanov S.A','Samara, st.Lenina,6'),
('2369as5214rr8517xz',1,'Petrov A.A.','Samara, st.Gagarina,44'),
('2369as5214rr8517xz',0,'Petrov A.A.','Samara, st.Gagarina,14'),
('2369as5214rr8517xz',3,'Perov A.A.','Samara, st.Gagarina,44a'),
('2369as5214rr8517xz',4,'Perov V.V.','Samara, st.Gagarina,44a'),
('2369as5214rr8517xz',2,'Perov A.A.','Samara, st.Gagarina,44');

SELECT * FROM Counterparty;

GO
WITH Cte AS (
SELECT Counterparty_id,version,name,address,
MAX(Version) OVER(PARTITION BY Counterparty_id) AS LastVer FROM Counterparty)
SELECT Counterparty_id,version,name,address FROM Cte WHERE version = LastVer;
GO

