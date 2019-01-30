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

