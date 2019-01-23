CREATE TABLE ActiveServices (
    ServicesId     INT NOT NULL,
    ClientsLogin   nvarchar (30) NOT NULL, 
    StartDate      datetime NOT NULL,
    EndDate        datetime NOT NULL
)
GO

ALTER TABLE ActiveServices ADD constraint ActiveServices_PK PRIMARY KEY CLUSTERED (ServicesId, ClientsLogin, EndDate)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON ) 
GO

CREATE TABLE BonusSalary ( 
	EmployeesId INT NOT NULL, 
	ReceivedDate DATE NOT NULL,
	BonusSalary money NOT NULL,
	ReceiveFor nvarchar (30) DEFAULT N'Bonus' )
GO

ALTER TABLE BonusSalary ADD constraint BonusSalary_PK PRIMARY KEY CLUSTERED (EmployeesId, ReceivedDate)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON ) 
GO

CREATE TABLE Categories (
    Id     INT IDENTITY(1,1),
    Category   nvarchar(30) 
)
GO

ALTER TABLE Categories ADD constraint Categories_PK PRIMARY KEY CLUSTERED (Id)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON ) 
GO

CREATE TABLE Clients ( 
	Login nvarchar (30) NOT NULL , 
	PeopleId INT NOT NULL,
    Password NVARCHAR (30)
)
GO 

ALTER TABLE Clients ADD constraint Clients_PK PRIMARY KEY CLUSTERED (Login)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON ) 
GO

CREATE TABLE Comments ( 
	NewsId INT NOT NULL , 
    ClientsLogin NVARCHAR(30) NOT NULL,
    AddDate DATETIME NOT NULL,
	CommentBody text
)
GO

ALTER TABLE Comments ADD constraint Comments_PK PRIMARY KEY CLUSTERED (AddDate, NewsId, ClientsLogin)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON ) 
GO

CREATE TABLE Employees (
    PeopleId      INT NOT NULL,
    HireDate       DATE NOT NULL,
    PositionsId   INT NOT NULL,
    BossId           INT
)
GO

ALTER TABLE Employees ADD constraint Employees_PK PRIMARY KEY CLUSTERED (PeopleId)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON ) 
GO

CREATE TABLE ExpiredServices (
	ServicesId     INT NOT NULL,
    ClientsLogin   nvarchar (30) NOT NULL,
    StartDate      datetime NOT NULL,
    EndDate        datetime NOT NULL
) 
GO
ALTER TABLE ExpiredServices ADD constraint ExpiredServices_PK PRIMARY KEY CLUSTERED (ServicesId, ClientsLogin, EndDate)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON ) 
GO

CREATE TABLE Items (
    Id		     INT NOT NULL,
    Name         nvarchar (30) , 
    CategoriesId INT NOT NULL ) 
GO

ALTER TABLE Items ADD constraint Items_PK PRIMARY KEY CLUSTERED (Id)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON ) 
GO

CREATE TABLE ItemsInWarehouse (
    ItemsId       INT NOT NULL,
	WarehouseId   INT NOT NULL,
    Quantity       INT
)
GO

ALTER TABLE ItemsInWarehouse ADD constraint ItemsInWarehouse_PK PRIMARY KEY CLUSTERED (ItemsId, WarehouseId)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON ) 
GO

CREATE TABLE Logs( 
	 Id INT IDENTITY(1,1),
	 Date DATETIME , 
     Info TEXT , 
     Level CHAR(1)
) 
GO

ALTER TABLE Logs ADD constraint Logs_PK PRIMARY KEY CLUSTERED (Id)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON ) 
GO

CREATE TABLE News ( 
	Id INT IDENTITY(1,1), 
    Topic nvarchar(30) NOT NULL,
	NewsBody text NOT NULL, 
	Date datetime 
)
GO


ALTER TABLE News ADD constraint News_PK PRIMARY KEY CLUSTERED (Id)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON ) 
GO

CREATE TABLE Orders (
    Id             INT IDENTITY(1,1),
    PurchaseDate   datetime,
    City           nvarchar (30) , 
    Country		   NVARCHAR (30) , 
    Address		   NVARCHAR (30) , 
    ClientsLogin   NVARCHAR (30) NOT NULL 
) 
GO

ALTER TABLE Orders ADD constraint Orders_PK PRIMARY KEY CLUSTERED (Id)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON ) 
GO

CREATE TABLE OrdersDetails (
    OrdersId     INT NOT NULL,
    ProductsId   INT NOT NULL,
    UnitPrice     money NOT NULL,
    Quantity      SMALLINT NOT NULL,
    Discount      REAL NOT NULL
)
GO

ALTER TABLE OrdersDetails ADD constraint OrdersDetails_PK PRIMARY KEY CLUSTERED (OrdersId, ProductsId)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON ) 
GO

CREATE TABLE Status(
	Id INT IDENTITY(1,1),
	StatusInfo text,
)
GO

ALTER TABLE Status ADD constraint Status_PK PRIMARY KEY CLUSTERED (Id)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON ) 
GO

CREATE TABLE OrdersStatus (
    OrdersId    INT NOT NULL,
    StatusId    INT NOT NULL,
)
GO

ALTER TABLE OrdersStatus ADD constraint OrdersStatus_PK PRIMARY KEY CLUSTERED (OrdersId)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON ) 
GO

CREATE TABLE Payments ( 
	Id				INT IDENTITY(1,1), 
	PaymentsTypsId	INT NOT NULL , 
    OrdersId		INT NOT NULL,
    PaymentDate		DATETIME , 
    Value			MONEY
)
Go

ALTER TABLE Payments ADD constraint Payments_PK PRIMARY KEY CLUSTERED (Id)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON ) 
GO

CREATE TABLE PaymentsTyps (
    Id     INT IDENTITY(1,1),
    Type   nvarchar(30) NOT NULL, 
    Provider NVARCHAR(30) NOT NULL, 
	TermsUrl nvarchar(30) 
)
GO

ALTER TABLE PaymentsTyps ADD constraint PaymentsTyps_PK PRIMARY KEY CLUSTERED (Id)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
Go

CREATE TABLE People (
    Id     INT IDENTITY(1,1),
    Name   nvarchar (30) NOT NULL, 
    Surname NVARCHAR (30) NOT NULL, 
    Email NVARCHAR (30) NOT NULL, 
	Phone nvarchar(12),
	Country NVARCHAR(30),
	City NVARCHAR(30),
	Adress NVARCHAR(30)
)
GO

ALTER TABLE People ADD constraint People_pk PRIMARY KEY CLUSTERED (Id)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON ) 
Go

CREATE TABLE Positions (
    Id         INT IDENTITY(1,1),
    Position   nvarchar(30) NOT NULL, 
	salary INT NOT NULL ) 
GO

ALTER TABLE Positions ADD constraint Positions_PK PRIMARY KEY CLUSTERED (Id)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON ) 
Go

CREATE TABLE Products (
    Id            INT NOT NULL,
    Description   text NOT NULL
)
GO

ALTER TABLE Products ADD constraint Products_PK PRIMARY KEY CLUSTERED (Id)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON ) 
GO

CREATE TABLE ProductsPrices (
    ProductsId   INT NOT NULL,
    StartDate     datetime NOT NULL,
    EndDate       datetime,
    UnitPrice     money
)
GO

ALTER TABLE ProductsPrices ADD constraint ProductsPrices_pk PRIMARY KEY CLUSTERED (ProductsId, StartDate)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON ) 
GO

CREATE TABLE PromotionCodes (
    Id				INT IDENTITY(1,1),
	ProductsId		INT NOT NULL,
    Used			bit DEFAULT 0 ,
    Code			nvarchar (10) NOT NULL, 
    ExpirDate		DATETIME NOT NULL , 
    ClientsLogin	NVARCHAR (30) 
) 
Go

ALTER TABLE PromotionCodes ADD constraint PromotionCodes_pk PRIMARY KEY CLUSTERED (Id)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON ) 
GO

CREATE TABLE Ratings( 
	ClientsLogin nvarchar (30) NOT NULL ,
	ProductsId INT NOT NULL, 
    Rating SMALLINT NOT NULL, 
    AddDate DATETIME NOT NULL
) 
GO

ALTER TABLE Ratings ADD constraint Ratings_pk PRIMARY KEY CLUSTERED (ClientsLogin, ProductsId)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON ) 
GO

CREATE TABLE Sales (
    ProductsId   INT NOT NULL,
    Unitprice     money NOT NULL,
    Until         datetime NOT NULL
)
GO

ALTER TABLE Sales ADD constraint Sales_PK PRIMARY KEY CLUSTERED (ProductsId)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON ) 
GO

CREATE TABLE Services (
    Id			 INT NOT NULL,
    Name		 nvarchar (30) NOT NULL, 
    Time	     DATETIME , 
    CategoriesId INT NOT NULL ) 
GO

ALTER TABLE Services ADD constraint Services_PK PRIMARY KEY CLUSTERED (Id)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON ) 
GO

CREATE TABLE Warehouse (
    Id     INT IDENTITY(1,1),
    Name   nvarchar (30) NOT NULL, 
	Country nvarchar(30) NOT NULL,
	City	nvarchar(30) NOT NULL,
    Address nvarchar(30) NOT NULL, 
	Phone INT    NOT NULL                  
)
GO

ALTER TABLE Warehouse ADD constraint Warehouse_PK PRIMARY KEY CLUSTERED (Id)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON ) 
GO

ALTER TABLE ActiveServices
    ADD CONSTRAINT ActiveServices_Clients_FK FOREIGN KEY ( ClientsLogin )
        REFERENCES clients ( Login )
	ON DELETE CASCADE
    ON UPDATE CASCADE 
GO

ALTER TABLE ActiveServices
    ADD CONSTRAINT ActiveServices_Services_FK FOREIGN KEY ( ServicesId )
        REFERENCES Services ( Id )
GO

ALTER TABLE BonusSalary
    ADD CONSTRAINT BonusSalary_Employees_FK FOREIGN KEY ( EmployeesId )
        REFERENCES Employees ( PeopleId )
GO

ALTER TABLE Clients
    ADD CONSTRAINT Clients_People_FK FOREIGN KEY ( PeopleId )
	REFERENCES People ( Id )
	ON DELETE CASCADE 
    ON UPDATE CASCADE 
GO

ALTER TABLE Comments
    ADD CONSTRAINT Comments_Clients_FK FOREIGN KEY ( ClientsLogin )
        REFERENCES Clients ( Login )
	ON DELETE CASCADE 
    ON UPDATE CASCADE 
GO

ALTER TABLE Comments
    ADD CONSTRAINT Comments_News_FK FOREIGN KEY ( NewsId )
        REFERENCES News ( Id )
	ON DELETE CASCADE 
    ON UPDATE CASCADE 
GO

ALTER TABLE Employees
    ADD CONSTRAINT Employees_People_FK FOREIGN KEY ( PeopleId )
        REFERENCES People ( Id )
    ON DELETE CASCADE 
    ON UPDATE CASCADE 
GO

ALTER TABLE Employees
    ADD CONSTRAINT Employees_Positions_FK FOREIGN KEY ( PositionsId )
        REFERENCES Positions ( Id )
GO

ALTER TABLE ExpiredServices
    ADD CONSTRAINT ExpiredServices_Clients_FK FOREIGN KEY ( ClientsLogin )
        REFERENCES Clients ( Login )
GO

ALTER TABLE ExpiredServices
    ADD CONSTRAINT ExpiredServices_Services_FK FOREIGN KEY ( ServicesId )
        REFERENCES Services ( Id )
GO

ALTER TABLE Items
    ADD CONSTRAINT Items_Categories_FK FOREIGN KEY ( CategoriesId )
        REFERENCES Categories ( Id )
GO

ALTER TABLE ItemsInWarehouse
    ADD CONSTRAINT ItemsInWarehouse_Items_FK FOREIGN KEY ( ItemsId )
        REFERENCES Items ( Id )
	ON DELETE CASCADE 
    ON UPDATE CASCADE 
GO

ALTER TABLE ItemsInWarehouse
    ADD CONSTRAINT ItemsInWarehouse_Warehouse_FK FOREIGN KEY ( WarehouseId )
        REFERENCES Warehouse ( Id )
	ON DELETE CASCADE 
    ON UPDATE CASCADE 
GO

ALTER TABLE Orders
    ADD CONSTRAINT Orders_Clients_FK FOREIGN KEY ( ClientsLogin )
        REFERENCES Clients ( Login )
GO

ALTER TABLE OrdersDetails
    ADD CONSTRAINT OrdersDetails_Orders_FK FOREIGN KEY ( OrdersId )
        REFERENCES Orders ( Id )
GO

ALTER TABLE OrdersDetails
    ADD CONSTRAINT OrdersDetails_Products_FK FOREIGN KEY ( ProductsId )
        REFERENCES Products ( Id )
GO

ALTER TABLE OrdersStatus
    ADD CONSTRAINT OrdersStatus_Orders_FK FOREIGN KEY ( OrdersId )
        REFERENCES Orders ( Id )
GO

ALTER TABLE Payments
    ADD CONSTRAINT Payments_Orders_FK FOREIGN KEY ( OrdersId )
        REFERENCES Orders ( Id )
GO

ALTER TABLE Payments
    ADD CONSTRAINT Payments_PaymentsTyps_FK FOREIGN KEY ( PaymentsTypsId )
        REFERENCES PaymentsTyps ( Id )
GO

ALTER TABLE ProductsPrices
    ADD CONSTRAINT ProductsPrices_Products_FK FOREIGN KEY ( ProductsId )
        REFERENCES Products ( Id )
GO

ALTER TABLE PromotionCodes
    ADD CONSTRAINT PromotionCodes_Clients_FK FOREIGN KEY ( ClientsLogin )
        REFERENCES Clients ( Login )
GO

ALTER TABLE PromotionCodes
    ADD CONSTRAINT PromotionCodes_Products_FK FOREIGN KEY ( ProductsId )
        REFERENCES Products ( Id )
GO

ALTER TABLE Ratings
    ADD CONSTRAINT Ratings_Clients_FK FOREIGN KEY ( ClientsLogin )
        REFERENCES Clients ( Login )
	ON DELETE CASCADE
    ON UPDATE CASCADE 
GO

ALTER TABLE Ratings
    ADD CONSTRAINT Ratings_Products_FK FOREIGN KEY ( ProductsId )
        REFERENCES Products ( Id )
	ON DELETE CASCADE 
    ON UPDATE CASCADE 
GO

ALTER TABLE Sales
    ADD CONSTRAINT Sales_Products_FK FOREIGN KEY ( ProductsId )
        REFERENCES Products ( Id )
	ON DELETE CASCADE 
    ON UPDATE CASCADE
GO

ALTER TABLE Services
    ADD CONSTRAINT Services_Categories_FK FOREIGN KEY ( CategoriesId )
        REFERENCES Categories ( Id )
GO

ALTER TABLE OrdersStatus
	ADD CONSTRAINT OrdersStatus_Status_FK FOREIGN KEY (StatusId)
		REFERENCES Status(Id)
GO

ALTER TABLE Employees 
	ADD CONSTRAINT Employees_Employees_FK FOREIGN KEY (BossId)
		REFERENCES Employees(PeopleId)
GO

ALTER TABLE ItemsInWarehouse ADD CHECK (Quantity >= 0)  
GO