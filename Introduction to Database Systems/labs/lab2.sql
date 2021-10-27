# Gianna Galard, CSC315 LAB 2

# init db  with PRIMARY KEY and FOREIGN KEY
CREATE DATABASE CSC315Lab2;
USE CSC315Lab2;

/* PART A 
Create a database called CSC315Lab2 and initialize it with the following schema:

Suppliers(sid: integer, sname: string, address: string)
Parts(pid: integer, pname: string, color: string)
Catalog(sid: integer, pid: integer, cost: real)

The Catalog relation lists the prices charged for parts by Suppliers. 
Write the SQL script to create the tables, including implied foreign keys, and populate it with sample data. 
Sample data should be minimum 4 records each and able to prove the queries in part B are accurate. 
(ie Query # 4 requires a supplier with a specific name to be included) */

CREATE TABLE Suppliers (
sid int,
sname varchar(100),
address varchar(200),
PRIMARY KEY (sid)
);
INSERT INTO Suppliers VALUES(1, 'Razer', '9 Pasteur, Suite 100');
INSERT INTO Suppliers VALUES(2, 'HyperX', '17600 Newhope Street');
INSERT INTO Suppliers VALUES(3, 'Corsair', '47100 Bayside Parkway');
INSERT INTO Suppliers VALUES(4, 'Acme Widget Suppliers', '924 Elmwood Road');
/* OUTPUT
1 row(s) affected	0.015 sec
1 row(s) affected	0.000 sec
1 row(s) affected	0.000 sec
1 row(s) affected	0.000 sec */
 
CREATE TABLE Parts (
pid int,
pname varchar(100),
color varchar(100),
PRIMARY KEY (pid)
);
INSERT INTO Parts VALUES(1, 'Keyboard', 'Green');
INSERT INTO Parts VALUES(2, 'RAM', 'Red');
INSERT INTO Parts VALUES(3, 'SSD', 'Green');
INSERT INTO Parts VALUES(4, 'Mouse Pad', 'Red');
INSERT INTO Parts VALUES(5, 'Head Set', 'Red');
/* OUTPUT
1 row(s) affected	0.000 sec
1 row(s) affected	0.000 sec
1 row(s) affected	0.000 sec
1 row(s) affected	0.000 sec
1 row(s) affected	0.015 sec */

CREATE TABLE Catalog (
sid int,
pid int,
cost real,
FOREIGN KEY (sid) references Suppliers(sid),
FOREIGN KEY (pid) references Parts(pid)
);
INSERT INTO Catalog VALUES(1, 1, 150);
INSERT INTO Catalog VALUES(2, 2, 200);
INSERT INTO Catalog VALUES(3, 3, 70);
INSERT INTO Catalog VALUES(4, 4, 20);
INSERT INTO Catalog VALUES(2, 5, 175);
INSERT INTO Catalog VALUES(2, 1, 235);
/* OUTPUT
1 row(s) affected	0.000 sec
1 row(s) affected	0.000 sec
1 row(s) affected	0.000 sec
1 row(s) affected	0.015 sec
1 row(s) affected	0.000 sec
1 row(s) affected	0.000 sec */

# PART B - QUERIES
-- Find the pnames of parts for which there is some supplier.
SELECT DISTINCT P.pname
FROM parts P, Catalog C 
WHERE P.pid = C.pid;
/* OUTPUT
+-----------+
| pname     |
+-----------+
| Keyboard  |
| RAM       |
| SSD       |
| Mouse Pad |
| Head Set  |
+-----------+
5 row(s) returned	0.000 sec / 0.000 sec */

-- Find the snames of suppliers who supply every part.
SELECT sname FROM Suppliers;
/* OUTPUT
+-----------------------+
| sname 	        |
+-----------------------+
| Razer  	   	|
| HyperX   		|
| Corsair  		|
| Acme Widget Suppliers |
+-----------------------+
4 row(s) returned	0.000 sec / 0.000 sec */

-- Find the snames of suppliers who supply every red part.
SELECT Suppliers.sname 
FROM ((Suppliers inner join Catalog on Suppliers.sid=Catalog.sid) inner join Parts on Catalog.pid=Parts.pid) 
WHERE Parts.color="red";
/* OUTPUT
+-----------------------+
| sname	                |
+-----------------------+
| HyperX                |
| Acme Widget Suppliers |
| HyperX                |
+-----------------------+
3 row(s) returned	0.000 sec / 0.000 sec */

-- Find the pnames of parts supplied by Acme Widget Suppliers and no one else.
SELECT P.pname 
FROM Parts P 
INNER JOIN Catalog C ON C.pid = P.pid
INNER JOIN Suppliers S on C.sid=S.sid
WHERE S.sname = 'Acme Widget Suppliers';
/* OUTPUT
+------------+
| pname	     |
+------------+
| Mouse Pad  |
+------------+
1 row(s) returned	0.000 sec / 0.000 sec */

-- Find the sids of suppliers who charge more for some part than the average cost of that part (averaged over all the suppliers who supply that part).
SELECT S.sname Supplier, 
	avg(c.cost) averageCost, 
    max(c.cost) supplierCost,
    P.pname,
    P.pid
FROM Parts P
INNER JOIN Catalog C ON P.pid=C.pid
INNER JOIN Suppliers S ON S.sid=C.sid
GROUP BY C.pid;
/* OUTPUT
+-----------------------+-------------+--------------+-----------+-----+
| Supplier              | averageCost | supplierCost | pname     | pid |
+-----------------------+-------------+--------------+-----------+-----+
| Razer                 | 192.5       | 235          | Keyboard  | 1   |
| HyperX                | 200         | 200          | RAM       | 2   |
| HyperX                | 175         | 175          | Head Set  | 5   |
| Corsair               | 70          | 70           | SSD       | 3   |
| Acme Widget Suppliers | 20          | 20           | Mouse Pad | 4   |
+-----------------------+-------------+--------------+-----------+-----+
5 row(s) returned	0.000 sec / 0.000 sec */

-- For each part, ﬁnd the sname of the supplier who charges the most for that part.
SELECT S.sname as Supplier, P.pname as pname, max(cost)
FROM Suppliers S
INNER JOIN Catalog C ON S.sid = C.sid
INNER JOIN Parts P ON P.pid=C.pid
GROUP BY S.sname;
/* OUTPUT
+-----------------------+-------------+-----------+
| Supplier              | pname       | max(cost) |
+-----------------------+-------------+-----------+
| Razer                 | Keyboard    | 235       |
| HyperX                | RAM         | 200       |
| Corsair               | SSD         | 70        |
| Acme Widget Suppliers | Mouse Pad   | 20        |
+-----------------------+-------------+-----------+
4 row(s) returned	0.000 sec / 0.000 sec */

-- Find the sids of suppliers who supply only red parts.
SELECT DISTINCT C.sid AS sid
FROM Catalog C
WHERE NOT EXISTS ( 
	SELECT *
	FROM Parts P
	WHERE P.pid = C.pid AND P.color <> "Red" );
/* OUTPUT
+-----+
| sid |
+-----+
| 2   |
| 4   |
+-----+
2 row(s) returned	0.000 sec / 0.000 sec */

-- Find the sids of suppliers who supply a red part and a green part.
SELECT DISTINCT C.sid
FROM Catalog C, Parts P
WHERE C.pid = P.pid AND P.color = "Red";
SELECT DISTINCT C1.sid
FROM Catalog C1, Parts P1
WHERE C1.pid = P1.pid AND P1.color = "Green";
/* OUTPUT
+-----+      +-----+ 
| sid |      | sid |
+-----+      +-----+
| 1   |      | 2   |
| 2   |      | 4   |
| 3   |	     +-----+
+-----+
3 row(s) returned	0.000 sec / 0.000 sec
2 row(s) returned	0.000 sec / 0.000 sec */

-- Find the sids of suppliers who supply a red part or a green part.
SELECT DISTINCT C.sid
FROM Catalog C, Parts P
WHERE C.pid = P.pid AND P.color = "Red"
UNION
SELECT DISTINCT C1.sid
FROM Catalog C1, Parts P1
WHERE C1.pid = P1.pid AND P1.color = "Green";
/* OUTPUT
+-----+
| sid |
+-----+
| 2   |
| 4   |
| 1   |
| 3   |
+-----+
4 row(s) returned	0.000 sec / 0.000 sec */

-- For every supplier that only supplies green parts, print the name of the supplier and the total number of parts that she supplies.
SELECT COUNT(DISTINCT(C.pid)) NumParts, S.sname, C.pid, P.pname
FROM Catalog C
INNER JOIN Parts P ON C.pid=P.pid
INNER JOIN Suppliers S ON C.sid=S.sid
WHERE P.color = 'green';
/* OUTPUT
+----------+-------+-----+----------+
| NumParts | sname | pid | pname    |
+----------+-------+-----+----------+
| 2        | Razer | 1   | Keyboard |
+----------+-------+-----+----------+
1 row(s) returned	0.000 sec / 0.000 sec */

-- For every supplier that supplies a green part and a red part, print the name and price of the most expensive part that she supplies.
SELECT S.sname AS sname, MAX(C.cost) as most$$$
FROM Suppliers S, Parts P, Catalog C
WHERE P.pid = C.pid AND C.sid = S.sid;
/* OUTPUT
+-------+---------+
| sname | most$$$ |
+-------+---------+
| Razer | 235     |
+-------+---------+
1 row(s) returned	0.000 sec / 0.000 sec */

-- when complete
DROP TABLE Catalog;
DROP TABLE Suppliers;
DROP TABLE Parts;
DROP DATABASE CSC315Lab2;



