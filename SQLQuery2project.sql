
----------------------------------------------------------------------------------------------------------------------------------------------
CREATE VIEW SalesSalary AS(
SELECT 
empolyee.ID, 
COUNT(transactions.ID) AS NumberOfDeals,
(COUNT(transactions.ID) * Department.salary) AS Salary
FROM empolyee 
FULL JOIN transactions ON transactions.salesID = empolyee.ID 
FULL JOIN Department ON Department.ID = empolyee.DID
WHERE Department.ID = 5111
GROUP BY empolyee.ID, Department.salary,empolyee.bonus)

----------------------------------------------------------------------------------------------------------------------------------------------

CREATE VIEW PersonalInfo AS (
SELECT 
empolyee.ID, 
empolyee.FName + ' ' +empolyee.LName AS Name, 
empolyee.age, 
empolyee.gender, 
empolyee.Workingdays, 
empolyee.Workinghours, 
empolyee.bonus, 
empolyee.Email, 
empolyee.phonenumber, 
empolyee.EAddress, 
Department.DName, 
CASE Department.ID
WHEN 5111 THEN SalesSalary.Salary
ELSE Department.salary
END AS Salary
FROM empolyee FULL JOIN Department ON Department.ID = empolyee.DID FULL JOIN SalesSalary ON SalesSalary.ID = empolyee.ID)

----------------------------------------------------------------------------------------------------------------------------------------------

CREATE VIEW Offers1 AS (
SELECT 
p.ID AS ID, 
p.pname AS NAME,
p.ptype AS TYPE,
FORMAT(s.expdate, 'dd/MM/yyyy') AS expdate,
p.descrep,
0.9 *s.sellprice AS PRICE,
s.buyprice,
(s.sellprice - s.buyprice) AS profit_margin
FROM products p JOIN Stock s ON p.ID = s.PID 
WHERE s.buyprice < 100  AND s.amount > 350)

CREATE VIEW Offers2 AS(
SELECT p.ID,
p.pname AS NAME,
p.ptype,
FORMAT(s.expdate, 'dd/MM/yyyy') AS expdate,
p.descrep,
0.8*s.sellprice AS PRICE,
s.buyprice,
(s.sellprice - s.buyprice) AS profit_margin
FROM products p JOIN Stock s ON p.ID = s.PID 
WHERE s.expdate BETWEEN GETDATE() AND DATEADD(DAY, 20, GETDATE()) )

CREATE VIEW Offers3 AS(
SELECT 
p.ID,
p.pname AS NAME,
p.ptype,
FORMAT(s.expdate, 'dd/MM/yyyy') AS expdate,
p.descrep,
0.7*s.sellprice AS PRICE,
s.buyprice,
(s.sellprice - s.buyprice) AS profit_margin
FROM products p JOIN Stock s ON p.ID = s.PID 
WHERE s.sellprice > 500 AND (s.sellprice - s.buyprice) >= 50 )

----------------------------------------------------------------------------------------------------------------------------------------------

SELECT 
    empolyee.FName, empolyee.LName, empolyee.ID, empolyee.age, empolyee.Workinghours,
    empolyee.Workingdays, empolyee.EAddress, empolyee.phonenumber, empolyee.bonus,
    Department.DName AS DepartmentName, Department.ID AS DepartmentID
FROM 
    empolyee
LEFT JOIN 
    Department ON empolyee.DID = Department.ID;

----------------------------------------------------------------------------------------------------------------------------------------------

SELECT p.ID, p.pname, p.ptype, FORMAT(s.expdate, 'dd/MM/yyyy') AS expdate, s.sellprice, s.buyprice, p.descrep, s.amount 
FROM products p 
JOIN Stock s ON p.ID = s.PID 

----------------------------------------------------------------------------------------------------------------------------------------------

SELECT empolyee.FName, empolyee.LName,empolyee.ID,FORMAT(transactions.tdate, 'dd/MM/yyyy') AS tdate,transactions.Paid_amount,transactions.price,transactions.remainder, transactions.ID AS tid,transactions.CID, clients.cname, products.pname AS pname, transactions.sell_buy
FROM transactions 
JOIN clients ON transactions.CID = clients.ID 
JOIN products ON transactions.PID = products.ID
JOIN empolyee ON transactions.salesID = empolyee.ID

----------------------------------------------------------------------------------------------------------------------------------------------

SELECT * FROM company_info

----------------------------------------------------------------------------------------------------------------------------------------------

SELECT empolyee.*, Department.DName , Department.salary+bonus AS salary
FROM empolyee JOIN Department ON DID=Department.ID
WHERE empolyee.ID = @id

----------------------------------------------------------------------------------------------------------------------------------------------

UPDATE empolyee SET FName = @First WHERE ID = @id 

----------------------------------------------------------------------------------------------------------------------------------------------

SELECT ISNULL(MAX(ID), 0) AS MaxID FROM Daysoff
INSERT INTO Daysoff (ID, EID, REASON, Ddate, Dstate, enddate) VALUES (@id, @eid, @reason, @start, N'طلب', @end)

----------------------------------------------------------------------------------------------------------------------------------------------

Select [DName] AS a , COUNT([dbo].[Daysoff].[EID]) AS COUNTT 
FROM [empolyee] 
JOIN [dbo].[Department] ON [dbo].[Department].[ID]= [DID] 
JOIN[dbo].[Daysoff]  ON [EID]=[dbo].[empolyee].ID  
WHERE Daysoff.Dstate = N'موافقة'  GROUP BY [DName]

----------------------------------------------------------------------------------------------------------------------------------------------

SELECT [Daysoff].EID AS eid,[Daysoff].[ID] AS ddid,[FName],[LName],[DName],REASON,Dstate 
FROM Daysoff Join [dbo].[empolyee] ON [dbo].[empolyee].ID=Daysoff.EID JOIN [dbo].[Department] ON [empolyee].DID =[Department].ID

----------------------------------------------------------------------------------------------------------------------------------------------

SELECT MONTH(tdate) AS monthprofit, YEAR(tdate) AS yearprofit , SUM(netprice) AS net_profit
FROM(
SELECT tdate, transactions.sell_buy,
CASE transactions.sell_buy
WHEN N'بيع' THEN price
ELSE -price
END AS netprice
FROM transactions
JOIN clients ON transactions.CID = clients.ID 
JOIN products ON transactions.PID = products.ID
JOIN empolyee ON transactions.salesID = empolyee.ID) AS netprofit
GROUP BY MONTH(tdate), YEAR(tdate)
ORDER BY monthprofit

----------------------------------------------------------------------------------------------------------------------------------------------

UPDATE Daysoff SET Dstate = N'موافقة' WHERE [ID]=@id
UPDATE Daysoff SET Dstate = N'رفض' WHERE [ID]=@id

----------------------------------------------------------------------------------------------------------------------------------------------

SELECT ISNULL(MAX(ID), 0) AS MaxID FROM products
INSERT INTO products (ID, pname, ptype, descrep) VALUES (@id, @pname, @ptype,@desc);
INSERT INTO Stock (PID, sellprice, buyprice, expdate, amount) VALUES(@id, @sellprice, @buyprice, @edate, @amount)

----------------------------------------------------------------------------------------------------------------------------------------------

DELETE FROM products WHERE ID = @id

----------------------------------------------------------------------------------------------------------------------------------------------

SELECT FINANCIAL_INFO.ID AS id, FINANCIAL_INFO.CID AS cid, FINANCIAL_INFO.Amount, FINANCIAL_INFO.STATUSf, clients.cname FROM  FINANCIAL_INFO JOIN clients ON  FINANCIAL_INFO.CID = clients.ID

----------------------------------------------------------------------------------------------------------------------------------------------

SELECT FINANCIAL_INFO.ID AS id, FINANCIAL_INFO.CID AS cid, FINANCIAL_INFO.Amount, FINANCIAL_INFO.STATUSf, clients.cname 
FROM FINANCIAL_INFO JOIN clients ON FINANCIAL_INFO.CID = clients.ID 
WHERE FINANCIAL_INFO.ID = @id

----------------------------------------------------------------------------------------------------------------------------------------------

UPDATE FINANCIAL_INFO SET Amount = @Amount, STATUSf = @STATUSf WHERE ID = @id
UPDATE FINANCIAL_INFO SET Amount = @Amount WHERE ID = @id
DELETE FROM FINANCIAL_INFO WHERE ID = @id

----------------------------------------------------------------------------------------------------------------------------------------------

SELECT ISNULL(MAX(ID), 0) AS MaxID FROM Transactions
INSERT INTO transactions (ID, tdate, amount, salesID, PID, CID, sell_buy, payment, price, Paid_amount, remainder) VALUES (@ID, @TDate, @Amount, @SalesID, @PID, @CID, @sell_buy, @Payment, @Price, @PaidAmount, @Remainder)
SELECT ISNULL(MAX(ID), 0) AS MaxID FROM FINANCIAL_INFO
INSERT INTO FINANCIAL_INFO (ID, CID, Amount, STATUSf) VALUES (@ID, @CID, @Amount, @STATUSf)

----------------------------------------------------------------------------------------------------------------------------------------------

WITH count_pro AS(
SELECT PID,count(*) AS c 
FROM transactions WHERE transactions.sell_buy=N'بيع '
GROUP BY transactions.PID),
max_pro AS(
SELECT max(c) AS f FROM count_pro)
SELECT products.pname,c 
FROM (max_pro JOIN count_pro ON f=c) JOIN products ON products.ID = PID

----------------------------------------------------------------------------------------------------------------------------------------------

WITH count_pro AS(SELECT CID,count(*) AS c FROM transactions GROUP BY transactions.CID),
max_pro AS(SELECT max(c) AS f FROM count_pro)
SELECT clients.cname,c FROM (max_pro JOIN count_pro ON f=c) JOIN clients ON clients.ID= CID

----------------------------------------------------------------------------------------------------------------------------------------------

WITH count_pro AS(SELECT salesID,count(*) AS c FROM transactions GROUP BY transactions.salesID),
max_pro AS(SELECT max(c) AS f FROM count_pro)
SELECT empolyee.FName, empolyee.LName,c FROM (max_pro JOIN count_pro ON f=c) JOIN empolyee ON empolyee.ID= salesID

----------------------------------------------------------------------------------------------------------------------------------------------

SELECT products.pname, sum(amount) AS amount FROM products JOIN Stock ON products.ID = Stock.PID
GROUP BY products.pname
ORDER BY amount DESC

SELECT products.pname, sum(amount) AS amount FROM products JOIN Stock ON products.ID = Stock.PID
WHERE amount< @amount1
GROUP BY products.pname
ORDER BY amount DESC

----------------------------------------------------------------------------------------------------------------------------------------------

SELECT products.pname, sum(amount) AS amount 
FROM products JOIN Stock ON products.ID = Stock.PID 
GROUP BY products.pname 
ORDER BY amount DESC

