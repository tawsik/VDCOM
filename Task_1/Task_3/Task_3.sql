USE Vdcom;
CREATE TABLE Counterparty_1(
Counterparty_id NVARCHAR(30),
status NVARCHAR(30),
valid_from datetime,
valid_to datetime);

--Статус контрагента на 3.02.2021:
--Значит дата valid_from должна быть <= 3.02.2021
--А дата valid_to должна быть больше 3.02.2021 либо должна быть NULL

INSERT INTO Counterparty_1 VALUES
('2356aa563bb5874cc','active','2021-02-01 00:00:00','2021-02-03 00:00:00'),
('2356aa563bb5874cc','defaulter','2021-02-03 00:00:00','2021-02-06 00:00:00'),
('2356aa563bb5874cc','removed','2021-02-06 00:00:00',NULL),
('5632bb7410cc6512aa','active','2021-02-01 00:00:00','2021-02-01 00:00:00'),
('5632bb7410cc6512aa','defaulter','2021-02-01 00:00:00','2021-02-02 00:00:00'),
('5632bb7410cc6512aa','active','2021-02-02 00:00:00','2021-02-03 00:00:00'),
('5632bb7410cc6512aa','defaulter','2021-02-03 00:00:00','2021-02-04 00:00:00'),
('5632bb7410cc6512aa','active','2021-02-04 00:00:00',NULL),
('5632cc5241aa8569bb','active','2021-02-01 00:00:00','2021-02-03 00:00:00'),
('5632cc5241aa8569bb','defaulter','2021-02-03 00:00:00','2021-02-05 00:00:00'),
('5632cc5241aa8569bb','active','2021-02-05 00:00:00',NULL),
('5632bb4512aa8569cc','active','2021-02-01 00:00:00','2021-02-01 00:00:00'),
('5632bb4512aa8569cc','defaulter','2021-02-01 00:00:00','2021-02-02 00:00:00'),
('5632bb4512aa8569cc','active','2021-02-02 00:00:00',NULL),
('8956aa5214cc5896bb','active','2021-02-01 00:00:00','2021-02-04 00:00:00'),
('8956aa5214cc5896bb','defaulter','2021-02-04 00:00:00',NULL);
SELECT * FROM Counterparty_1;

--No Window  Function
DECLARE @DT DATETIME = '2021-02-03 00:00:00';
SELECT Counterparty_id, status FROM Counterparty_1
WHERE valid_from <= @DT AND (valid_to>@DT OR valid_to IS NULL) ORDER BY Counterparty_id;

--With rank window function
--DECLARE @DT DATETIME = '2021-02-03 00:00:00';
SELECT RANK() OVER (ORDER BY Counterparty_id) AS ID,
  Counterparty_id,
  status
  FROM Counterparty_1
  WHERE valid_from<=@DT 
  AND (@DT<valid_to OR valid_to IS NULL);




