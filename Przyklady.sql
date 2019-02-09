USE Sklep
INSERT INTO Categories VALUES('Marchewki')
EXEC uspAddItem 'grabki', 'grabimy', 'Marchewki'
EXEC uspAddService 'Podlewanie Ogrodka', 10000, 'bedziemy podlewac ogrodek za Ciebie', 'Marchewki'

EXEC uspAddClients 'WielkiFarmer','H@SH','Jan','Stary','ogrodnik@hehe.com','123123123', 'Polska', 'Wioskowo', 'MarchewkowyLas'

Insert into Warehouse VALUES('Ogrodek1','Polska','-','-','-')
Insert into Warehouse VALUES('Ogrodek2','Polska','-','-','-')
Insert into Warehouse VALUES('Ogrodek3','Polska','-','-','-')
Insert into ItemsInWarehouse VALUES(1,1,10)
Insert into ItemsInWarehouse VALUES(1,2,30)
Insert into ItemsInWarehouse VALUES(1,3,20)
--stworzylismy uzytkownika magazy i dodalismy tam przedmioty (grabki)

Insert into ProductsPrices VALUES(1,GETDATE()-100,NULL,100)
WAITFOR DELAY '000:00:01'
Insert into ProductsPrices VALUES(1,GETDATE(),NULL,50)
Insert into ProductsPrices VALUES(2,GETDATE(),NULL,100)

SELECT * FROM ProductsPrices
--prezentacja jak wyglada dodawanie nowych cen

SELECT dbo.ufnGetPrice(1,DEFAULT) 
Insert into Sales VALUES (1,10,GETDATE()+1000)
WAITFOR DELAY '000:00:01'
SELECT dbo.ufnGetPrice(1,DEFAULT)
--pobieranie ceny z uwzglednieniem wyprzedazy

SELECT * FROM News
SELECT * FROM Sales
--automatycznie tworzenie newsow

EXEC uspInitOrder 1,'Gdzie dostarczyc','-','-'
Insert Into OrdersDetails(OrdersId,ProductsId,Discount,Quantity) VALUES(1,1,10,15)
Insert Into OrdersDetails(OrdersId,ProductsId,Discount,Quantity) VALUES(1,2,0,0)

SELECT * FROM Orders WHERE Id = 1
SELECT * FROM OrdersDetails WHERE OrdersId = 1
-- przyklad uzupelniania cen z nowego zamowienia

SELECT * FROM ItemsInWarehouse
-- zbieranie produktow z wielu magazynow


--Prezentacja ze dzialaja procedury 
EXEC uspAddPeople 1, N'Jan', N'Kowalski', N'jankowalski123@gmailc.com', '123456789', N'Polska', N'Kraków', N'Dolna1234'
EXEC uspAddPeople 2, N'Adam', N'Bobrow', N'abobrow@gmailc.com', '012840', N'Polska', N'Kraków', N'Gorna1245'

SELECT * FROM People

--Dodawanie pozycji
INSERT INTO Positions VALUES (N'SuperSzefOgrodnik', 10000)
INSERT INTO Positions VALUES (N'Podwladny', 1000)

--Dodawanie pracownikow, btw super sposob TSQL ze nie moge zrobic w exec GETDATE()
DECLARE @tmp DATETIME
SET @tmp = GETDATE()

EXEC uspAddEmployees N'Jan', N'Ogrodnik', N'jan@ogrodnicy123.pl', N'SuperSzefOgrodnik', '555444333', N'Polska', N'Grabina', N'Ogrodnicza12', @tmp
EXEC uspAddEmployees N'Bartosz', N'Bartkowski', N'bar@bartosz.pl', N'Podwladny', '12356423', N'Polska', N'Krakow', N'Polna', @tmp, 4
EXEC uspAddEmployees N'Lidiusz', N'Wartki', N'war@wartki.pl', N'Podwladny', '12356423', N'Polska', N'Krakow', N'Polna', @tmp, 4

SELECT * FROM Employees

--Wypisywanie zaleznosci sluzbowych
SELECT * FROM LineOfAuthority

--Zmiania dnia zatrudnienia na inny zeby przetestowac funkcje ktora liczy ile zarobili pracownicy
UPDATE Employees SET HireDate = '2018-05-30' WHERE BossId IS NULL
UPDATE Employees SET HireDate = '2018-06-12' WHERE PositionsId = 2

SELECT * FROM Employees

SELECT * FROM ufnSalaries('2018-01-01', GETDATE())

--Dodawanie bonusow
INSERT INTO BonusSalary VALUES (4, GETDATE(), 5000, 'Ogrodnik miesiaca')

SELECT * FROM ufnSalaries('2018-01-01', GETDATE())



