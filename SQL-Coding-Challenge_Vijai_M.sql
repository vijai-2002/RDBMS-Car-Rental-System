create database carrentalsystem;
use carrentalsystem;
--Vehicle table creation
CREATE TABLE Vehicle (
    vehicleID INT PRIMARY KEY,
    make VARCHAR(50) NOT NULL,
    model VARCHAR(50) NOT NULL,
    year INT NOT NULL,
    dailyRate DECIMAL(10, 2) NOT NULL,
    status VARCHAR(20) NOT NULL CHECK (status IN ('available', 'notAvailable')),
    passengerCapacity INT NOT NULL,
    engineCapacity INT NOT NULL
);
--Customer table creation
CREATE TABLE Customer (
    customerID INT PRIMARY KEY,
    firstName VARCHAR(20) NOT NULL,
    lastName VARCHAR(20) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    phoneNumber VARCHAR(20) NOT NULL
);
--Lease table creation
CREATE TABLE Lease (
    leaseID INT PRIMARY KEY,
    vehicleID INT NOT NULL,
    customerID INT NOT NULL,
    startDate DATE NOT NULL,
    endDate DATE NOT NULL,
    type VARCHAR(20) NOT NULL CHECK (type IN ('Daily', 'Monthly')),
    FOREIGN KEY (vehicleID) REFERENCES Vehicle(vehicleID) ON DELETE CASCADE,
    FOREIGN KEY (customerID) REFERENCES Customer(customerID) ON DELETE CASCADE
);
--Payment table creation
CREATE TABLE Payment (
    paymentID INT PRIMARY KEY,
    leaseID INT NOT NULL,
    paymentDate DATE NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (leaseID) REFERENCES Lease(leaseID) ON DELETE CASCADE
);

--Inserting value in Vehicle table
INSERT INTO Vehicle (vehicleID, make, model, year, dailyRate, status, passengerCapacity, engineCapacity)
VALUES 
(1, 'Toyota', 'Camry', 2022, 50.00, 'available', 4, 1450),
(2, 'Honda', 'Civic', 2023, 45.00, 'available', 7, 1500),
(3, 'Ford', 'Focus', 2022, 48.00, 'notAvailable', 4, 1400),
(4, 'Nissan', 'Altima', 2023, 52.00, 'available', 7, 1200),
(5, 'Chevrolet', 'Malibu', 2022, 47.00, 'available', 4, 1800),
(6, 'Hyundai', 'Sonata', 2023, 49.00, 'notAvailable', 7, 1400),
(7, 'BMW', '3 Series', 2023, 60.00, 'available', 7, 2499),
(8, 'Mercedes', 'C-Class', 2022, 58.00, 'available', 8, 2599),
(9, 'Audi', 'A4', 2022, 55.00, 'notAvailable', 4, 2500),
(10, 'Lexus', 'ES', 2023, 54.00, 'available', 4, 2500);

select * from Vehicle;

--Inserting value in Customer table

INSERT INTO Customer (customerID, firstName, lastName, email, phoneNumber)
VALUES 
(1, 'John', 'Doe', 'johndoe@example.com', '555-555-5555'),
(2, 'Jane', 'Smith', 'janesmith@example.com', '555-123-4567'),
(3, 'Robert', 'Johnson', 'robert@example.com', '555-789-1234'),
(4, 'Sarah', 'Brown', 'sarah@example.com', '555-456-7890'),
(5, 'David', 'Lee', 'david@example.com', '555-987-6543'),
(6, 'Laura', 'Hall', 'laura@example.com', '555-234-5678'),
(7, 'Michael', 'Davis', 'michael@example.com', '555-876-5432'),
(8, 'Emma', 'Wilson', 'emma@example.com', '555-432-1098'),
(9, 'William', 'Taylor', 'william@example.com', '555-321-6547'),
(10, 'Olivia', 'Adams', 'olivia@example.com', '555-765-4321');

select * from Customer;

--Inserting value in Lease table

INSERT INTO Lease (leaseID, vehicleID, customerID, startDate, endDate, type)
VALUES 
(1, 1, 1, '2023-01-01', '2023-01-05', 'Daily'),
(2, 2, 2, '2023-02-15', '2023-02-28', 'Monthly'),
(3, 3, 3, '2023-03-10', '2023-03-15', 'Daily'),
(4, 4, 4, '2023-04-20', '2023-04-30', 'Monthly'),
(5, 5, 5, '2023-05-05', '2023-05-10', 'Daily'),
(6, 4, 3, '2023-06-15', '2023-06-30', 'Monthly'),
(7, 7, 7, '2023-07-01', '2023-07-10', 'Daily'),
(8, 8, 8, '2023-08-12', '2023-08-15', 'Monthly'),
(9, 3, 3, '2023-09-07', '2023-09-10', 'Daily'),
(10, 10, 10, '2023-10-10', '2023-10-31', 'Monthly');

select * from Lease;

--Inserting value in Payment table

INSERT INTO Payment (paymentID, leaseID, paymentDate, amount)
VALUES 
(1, 1, '2023-01-03', 200.00),
(2, 2, '2023-02-20', 1000.00),
(3, 3, '2023-03-12', 75.00),
(4, 4, '2023-04-25', 900.00),
(5, 5, '2023-05-07', 60.00),
(6, 6, '2023-06-18', 1200.00),
(7, 7, '2023-07-03', 40.00),
(8, 8, '2023-08-14', 1100.00),
(9, 9, '2023-09-09', 80.00),
(10, 10, '2023-10-25', 1500.00);

select * from Payment;
select* from Customer;
select * from Lease;
select * from Vehicle;
--Queries
--1. Update the daily rate for a Mercedes car to 68.
update Vehicle set dailyRate = 68.00 where make = 'Mercedes';
--2. Delete a specific customer and all associated leases and payments.
delete from Customer where customerID = 3;
--3. Rename the "paymentDate" column in the Payment table to "transactionDate".
EXEC sp_rename 'Payment.paymentDate', 'transactionDate', 'COLUMN';
--4. Find a specific customer by email.
select * from Customer where email = 'johndoe@example.com';
--5. Get active leases for a specific customer.
select * from Lease where customerID = 2 AND endDate >= CAST(GETDATE() AS DATE);
--6. Find all payments made by a customer with a specific phone number.
select p.* from Payment p join Lease l on p.leaseID = l.leaseID join Customer c ON l.customerID = c.customerID where c.phoneNumber = '555-555-5555';
--7. Calculate the average daily rate of all available cars.
select AVG(dailyRate) as average_rate from Vehicle where status = 'available';
--8. Find the car with the highest daily rate.
select top 1  * from  Vehicle order by dailyRate desc;
--9. Retrieve all cars leased by a specific customer.
select v.* from Vehicle v join Lease l on v.vehicleID = l.vehicleID where l.customerID = 1;
--10. Find the details of the most recent lease.
select top 1 * from Lease order by endDate desc ;
--11. List all payments made in the year 2023.
select * from Payment where year(transactionDate) = 2023;
--12. Retrieve customers who have not made any payments.
select *  from Customer c where not exists (select 1 from Lease l 
join Payment p on l.leaseID = p.leaseID  where l.customerID = c.customerID);
--13. Retrieve Car Details and Their Total Payments.
select v.make, v.model, sum(p.amount) as total_payments from Vehicle v 
join Lease l on v.vehicleID = l.vehicleID join Payment p on l.leaseID = p.leaseID group by v.make, v.model;
--14. Calculate Total Payments for Each Customer.
select c.customerID, c.firstName, c.lastName, sum(p.amount) as total_payments from Customer c 
join Lease l on c.customerID = l.customerID join Payment p on l.leaseID = p.leaseID group by c.customerID, c.firstName, c.lastName;
--15. List Car Details for Each Lease
select l.leaseID, v.make, v.model, l.startDate, l.endDate from Lease l join Vehicle v on l.vehicleID = v.vehicleID;
--16. Retrieve Details of Active Leases with Customer and Car Information.
select c.firstName, c.lastName, v.make, v.model, l.startDate, l.endDate from Lease l
join Customer c on l.customerID = c.customerID join Vehicle v on l.vehicleID = v.vehicleID where l.endDate >= CAST(GETDATE() AS DATE);
--17. Find the Customer Who Has Spent the Most on Leases.
select top 1 c.customerID, c.firstName, c.lastName, sum(p.amount) as total_spent from  Customer c
join Lease l on c.customerID = l.customerID join Payment p on l.leaseID = p.leaseID group by c.customerID, c.firstName, c.lastName
order by total_spent desc;
--18. List All Cars with Their Current Lease Information.
select v.make, v.model, l.startDate, l.endDate
from Vehicle v left join Lease l on v.vehicleID = l.vehicleID order by l.endDate desc;















