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
INSERT INTO Parts VALUES(1, 'Keyboard', 'Pink');
INSERT INTO Parts VALUES(2, 'RAM', 'Red');
INSERT INTO Parts VALUES(3, 'SSD', 'Green');
INSERT INTO Parts VALUES(4, 'Mouse Pad', 'Lilac');
INSERT INTO Parts VALUES(5, 'Head Set', 'White');
/* OUTPUT
0.016 sec
0.000 sec
0.000 sec
1 row(s) affected	0.000 sec
1 row(s) affected	0.000 sec */
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
/* OUTPUT
1 row(s) affected	0.000 sec
1 row(s) affected	0.000 sec
1 row(s) affected	0.000 sec
1 row(s) affected	0.000 sec
1 row(s) affected	0.000 sec */

# PART B - QUERIES
-- Find the pnames of parts for which there is some supplier.
SELECT DISTINCT P.pname
FROM parts P, Catalog C 
WHERE P.pid = C.pid;
/* OUTPUT
+----------+
| pname    |
+----------+
| Keyboard |
| RAM      |
| SSD      |
| Mouse Pad|
| Head Set |
+----------+
5 row(s) returned	0.000 sec / 0.000 sec */

-- Find the snames of suppliers who supply every part.
SELECT sname FROM Suppliers;
/* OUTPUT
+-----------------------+
| pname 			    |
+-----------------------+
| Razer  			    |
| HyperX   				|
| Corsair  				|
| Acme Widget Suppliers |
+-----------------------+
4 row(s) returned	0.000 sec / 0.000 sec */

-- Find the snames of suppliers who supply every red part.
SELECT S.sname
FROM Suppliers S, parts P, catalog C 
WHERE S.sid=C.sid
and C.pid=P.pid
and P.color='red'
GROUP BY S.sname
HAVING COUNT(DISTINCT(C.pid)) >= (SELECT COUNT(*)
	FROM Parts P
	WHERE P.color = 'red'
);
/* OUTPUT
+---------+
| sname	  |
+---------+
| HyperX  |
+---------+
1 row(s) returned	0.000 sec / 0.000 sec */

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
GROUP BY C.pid
/* OUTPUT
+-----------------------+-------------+--------------+-----------+-----+
| Supplier              | averageCost | supplierCost | pname     | pid |
+-----------------------+-------------+--------------+-----------+-----+
| Razer                 | 150         | 150          | Keyboard  | 1   |
| HyperX                | 200         | 200          | RAM       | 2   |
| HyperX                | 175         | 175          | Head Set  | 5   |
| Corsair               | 70          | 70           | SSD       | 3   |
| Acme Widget Suppliers | 20          | 20           | Mouse Pad | 4   |
+-----------------------+-------------+--------------+-----------+-----+
5 row(s) returned	0.000 sec / 0.000 sec */

-- For each part, ﬁnd the sname of the supplier who charges the most for that part.
SELECT S.sname, P.pname AS 








