
CREATE DATABASE Test; 

SELECT * FROM sys.databases
ORDER BY create_date; 

CREATE TABLE Customers (
	firstName varchar(30) NOT NULL,
	lastName varchar(40) NOT NULL,
	address varchar(50) NOT NULL,
	age int
);


CREATE TABLE agents(
	agent_code char(6) NOT NULL PRIMARY KEY,
	agent_name char(40) NOT NULL,
	working_area char(35),
	commission decimal(10,2),
	phone_no char(17)
);


CREATE TABLE customer1(
	cust_code char(6) NOT NULL PRIMARY KEY,
	cust_name char(25),
	cust_city char(25),
	agent_code char(6),
	FOREIGN KEY(agent_code)
	REFERENCES agents(agent_code) 
);

CREATE TABLE Orders (
	OrderID int NOT NULL PRIMARY KEY,
	OrderNumber int NOT NULL,
	PersonID int FOREIGN KEY REFERENCES Persons(PersonID) 
);