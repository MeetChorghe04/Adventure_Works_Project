Select * from sales_new Union Select * from sales_old;
Create table sales Select * from sales_new Union Select * from sales_old;

select * from sales;

 Alter table sales 
 modify OrderDateKey date ;
 
 
ALTER TABLE sales
Drop ProductName ;



Desc dimproduct;


Select * from sales

alter table sales drop column carriertrackingnumber;
alter table sales drop column customerPOnumber;

select * from dimproduct;


create table product 
select 
	prod.Productkey,
    prod.`Unit price`,
    prod.ProductAlternateKey,
    prod.ProductSubcategoryKey,
    prod.WeightUnitMeasureCode,
    prod.SizeUnitMeasureCode,
    prod.EnglishProductName,
    prod.StandardCost,
    prod.FinishedGoodsFlag,
    prod.Color,
    prod.SafetyStockLevel,
    prod.ReorderPoint,
    prod.ListPrice,
    prod.Size,
    prod.SizeRange,
    prod.Weight,
    prod.DaysToManufacture,
    prod.ProductLine,
    prod.DealerPrice,
    prod.Class,
    prod.Style,
    prod.StartDate,
    prod.EndDate,
    prod.Status,
    subcat.ProductSubcategoryAlternateKey,
    subcat.EnglishProductSubcategoryName,
    subcat.ProductCategoryKey,
    cat.ProductCategoryAlternateKey,
    cat.EnglishProductCategoryName
from dimproduct as prod
left join dimprodsubcategory as subcat on prod.ProductSubcategoryKey = subcat.ProductSubcategoryKey
left join dimprodcategory as cat on subcat.productcategorykey= cat.productcategorykey;

alter table dimsalesterritory modify column SalesTerritoryKey int primary key;

alter table sales add constraint FK_SalesT foreign key (SalesTerritoryKey) references dimsalesterritory(SalesTerritoryKey);

select * from dimcustomer;
desc dimcustomer;

alter table dimcustomer modify column CustomerKey int primary key;
alter table sales add constraint FK_Cust foreign key (CustomerKey) references dimcustomer(CustomerKey);

select * from dimdate;
desc dimdate;

alter table dimdate modify column DateKey int primary key;

 Alter table sales
 modify ShipDateKey date ;
alter table sales add constraint FK_ODK foreign key (OrderDateKey) references dimdate(DateKey);
alter table sales add constraint FK_DDK foreign key (DueDateKey) references dimdate(DateKey);
alter table sales add constraint FK_SDK foreign key (ShipDateKey) references dimdate(DateKey);

alter table sales
drop  constraint FK_SDK;


select * from product;
desc product;

alter table product add constraint primary key (Productkey);
alter table sales add constraint FK_PK foreign key (Productkey) references product(Productkey);

SET SQL_SAFE_UPDATES = 0;
alter table sales add column productname varchar(100);
update sales left join product on sales.ProductKey = product.ProductKey set sales.productname = product.EnglishProductName;


alter table sales add column customerfullname varchar(100);
update sales left join dimcustomer on sales.CustomerKey = dimcustomer.CustomerKey set sales.customerfullname = concat(FirstName, " ", MiddleName, " ", LastName);


alter table sales drop orderdate1 ;

alter table sales add column orderdate1  date ;
update sales 
set orderdate1 = OrderDateKey ;



alter table sales
 add column Year int;
 update sales set year = year(orderdate1);
 
 alter table sales
 add column monthno int;
 
 update sales set monthno = month(orderdate1);
 
 
 alter table sales
 add column month varchar(20);
update sales
 set month = monthname(orderdate1);
 
 alter table sales 
 add column quarter text;
update sales 
set quarter = concat("Q",quarter(orderdate1));

alter table sales 
add column YearMonth text;
update sales
 set yearmonth = concat(year," ",month);
 
 alter table sales
 add weekdayno int;
update sales 
set weekdayno = weekday(orderdate1);


alter table sales 
add weekdayname text;
update sales
 set weekdayname = dayname(orderdate1);
 
 alter table sales 
 add financialmonth int;
update sales 
set financialmonth = ((monthno + 8)%12)+1;

alter table sales 
add financialquarter text;
update sales
 set financialquarter = concat("Q",((quarter(orderdate1) + 2)%4)+1);
 
 alter table sales
 add salesamt double;
update sales 
set salesamt = (unitprice*orderquantity)-discountamount;

alter table sales
 add productioncost double;
update sales 
set productioncost = (productstandardcost*orderquantity);

alter table sales 
add profit double;
update sales
 set profit = salesamt-productioncost;
 
 Select * from sales;
 

 update sales
 set profit = round(salesamt-productioncost,2);
 
  update sales
 set productioncost  = round(productstandardcost*orderquantity,2);
 
 