USE Vdcom;
CREATE TABLE Counterparty_1(
Counterparty_id NVARCHAR(30),
status NVARCHAR(30),
valid_from datetime,
valid_to datetime);
--SELECT CONVERT(datetime, '2021-02-01 00:00:00');
--SELECT CAST('2021-02-01 00:00:00' AS datetime2);


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

--No Window  Function
DECLARE @DT DATETIME = '2021-02-03 00:00:00';
SELECT Counterparty_id, status FROM Counterparty_1
WHERE valid_from <= @DT AND (valid_to>@DT OR valid_to IS NULL) ORDER BY Counterparty_id;

--With rank window function
DECLARE @DT DATETIME = '2021-02-03 00:00:00';
SELECT RANK() OVER (ORDER BY Counterparty_id) AS ID,
  Counterparty_id,
  status
  FROM Counterparty_1
  WHERE valid_from<=@DT 
  AND (@DT<valid_to OR valid_to IS NULL);




