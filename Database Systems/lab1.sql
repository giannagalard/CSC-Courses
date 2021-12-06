# Gianna Galard, CSC315 LAB 1

# init db  with PRIMARY KEY and FOREIGN KEY
CREATE DATABASE airtraffic;
USE airtraffic;

CREATE TABLE plane (
    ID INTEGER,
    Type CHAR(20),
    NumPassenger INTEGER,
    CargoSize INTEGER,
    PRIMARY KEY(ID)
);

INSERT INTO plane (ID,Type,NumPassenger,CargoSize) VALUES (1,'Boeing 747',300,150);
INSERT INTO plane (ID,Type,NumPassenger,CargoSize) VALUES (2,'Airbus A330',320,130);
INSERT INTO plane (ID,Type,NumPassenger,CargoSize) VALUES (3,'DC-10',280,150);
INSERT INTO plane (ID,Type,NumPassenger,CargoSize) VALUES (4,'Boeing 737',200,75);
INSERT INTO plane (ID,Type,NumPassenger,CargoSize) VALUES (5,'Airbus A320',180,100);
INSERT INTO plane (ID,Type,NumPassenger,CargoSize) VALUES (6,'Tu-204',150,150);
INSERT INTO plane (ID,Type,NumPassenger,CargoSize) VALUES (7,'ATR 42',70,50);
INSERT INTO plane (ID,Type,NumPassenger,CargoSize) VALUES (8,'Saab 340',60,30);

CREATE TABLE city (
    Name CHAR(20),
    Nation CHAR(10),
    Population INTEGER,
    PRIMARY KEY(Name,Nation)
);

INSERT INTO city (Name,Nation,Population) VALUES ('Belfast','UK',330000);
INSERT INTO city (Name,Nation,Population) VALUES ('Chicago','USA',2700000);
INSERT INTO city (Name,Nation,Population) VALUES ('Denver','USA',680000);
INSERT INTO city (Name,Nation,Population) VALUES ('Edmonton','CA',900000);
INSERT INTO city (Name,Nation,Population) VALUES ('Kyoto','JP',1400000);
INSERT INTO city (Name,Nation,Population) VALUES ('London','UK',8700000);
INSERT INTO city (Name,Nation,Population) VALUES ('Lyon','FR',480000);
INSERT INTO city (Name,Nation,Population) VALUES ('Montreal','CA',1700000);
INSERT INTO city (Name,Nation,Population) VALUES ('Moscow','RS',12200000);
INSERT INTO city (Name,Nation,Population) VALUES ('New York','USA',8500000);
INSERT INTO city (Name,Nation,Population) VALUES ('Paris','FR',2200000);
INSERT INTO city (Name,Nation,Population) VALUES ('Perth','AU',1600000);
INSERT INTO city (Name,Nation,Population) VALUES ('Portland','USA',640000);
INSERT INTO city (Name,Nation,Population) VALUES ('Seattle','USA',700000);
INSERT INTO city (Name,Nation,Population) VALUES ('Sydney','AU',4000000);
INSERT INTO city (Name,Nation,Population) VALUES ('Tokyo','JP',13600000);
INSERT INTO city (Name,Nation,Population) VALUES ('Vancouver','CA',650000);

CREATE TABLE airport (
    Code CHAR(3),
    City_FK CHAR(20),
    Nation_FK CHAR(10),
    NumTracks INTEGER,
    PRIMARY KEY(Code),
    FOREIGN KEY (City_FK,Nation_FK) REFERENCES city(Name,Nation)
);

INSERT INTO airport (Code,City_FK,Nation_FK,NumTracks) VALUES ('BFS','Belfast','UK',1);
INSERT INTO airport (Code,City_FK,Nation_FK,NumTracks) VALUES ('CDG','Paris','FR',6);
INSERT INTO airport (Code,City_FK,Nation_FK,NumTracks) VALUES ('DEN','Denver','USA',2);
INSERT INTO airport (Code,City_FK,Nation_FK,NumTracks) VALUES ('DME','Moscow','RS',10);
INSERT INTO airport (Code,City_FK,Nation_FK,NumTracks) VALUES ('JFK','New York','USA',8);
INSERT INTO airport (Code,City_FK,Nation_FK) VALUES ('KIX','Kyoto','JP');
INSERT INTO airport (Code,City_FK,Nation_FK,NumTracks) VALUES ('LGA','New York','USA',3);
INSERT INTO airport (Code,City_FK,Nation_FK,NumTracks) VALUES ('LHR','London','UK',12);
INSERT INTO airport (Code,City_FK,Nation_FK,NumTracks) VALUES ('LTN','London','UK',1);
INSERT INTO airport (Code,City_FK,Nation_FK,NumTracks) VALUES ('LYS','Lyon','FR',1);
INSERT INTO airport (Code,City_FK,Nation_FK,NumTracks) VALUES ('NRT','Tokyo','JP',5);
INSERT INTO airport (Code,City_FK,Nation_FK,NumTracks) VALUES ('ORD','Chicago','USA',3);
INSERT INTO airport (Code,City_FK,Nation_FK,NumTracks) VALUES ('ORY','Paris','FR',2);
INSERT INTO airport (Code,City_FK,Nation_FK,NumTracks) VALUES ('PDX','Portland','USA',1);
INSERT INTO airport (Code,City_FK,Nation_FK,NumTracks) VALUES ('PER','Perth','AU',1);
INSERT INTO airport (Code,City_FK,Nation_FK,NumTracks) VALUES ('SEA','Seattle','USA',1);
INSERT INTO airport (Code,City_FK,Nation_FK,NumTracks) VALUES ('STN','London','UK',4);
INSERT INTO airport (Code,City_FK,Nation_FK,NumTracks) VALUES ('SYD','Sydney','AU',1);
INSERT INTO airport (Code,City_FK,Nation_FK,NumTracks) VALUES ('YEG','Edmonton','CA',1);
INSERT INTO airport (Code,City_FK,Nation_FK,NumTracks) VALUES ('YUL','Montreal','CA',1);
INSERT INTO airport (Code,City_FK,Nation_FK,NumTracks) VALUES ('YVR','Vancouver','CA',1);

CREATE TABLE flight (
    FlightID CHAR(10),
    DayOfWeek CHAR(10),
    DepartureAirport_FK CHAR(3),
    DepartureTime TIME,
    ArrivalAirport_FK CHAR(3),
    ArrivalTime TIME,
    Plane_FK INTEGER,
    PRIMARY KEY(FlightID),
    FOREIGN KEY (DepartureAirport_FK) REFERENCES airport(Code),
    FOREIGN KEY (ArrivalAirport_FK) REFERENCES airport(Code),
    FOREIGN KEY (Plane_FK) REFERENCES plane(ID)
);

INSERT INTO flight (FlightID,DayOfWeek,DepartureAirport_FK,DepartureTime,ArrivalAirport_FK,ArrivalTime,Plane_FK) VALUES ('AZ101','Wednesday','DEN','22:00','CDG','6:00',1);
INSERT INTO flight (FlightID,DayOfWeek,DepartureAirport_FK,DepartureTime,ArrivalAirport_FK,ArrivalTime,Plane_FK) VALUES ('AZ159','Thursday','SEA','9:00','DME','17:00',2);
INSERT INTO flight (FlightID,DayOfWeek,DepartureAirport_FK,DepartureTime,ArrivalAirport_FK,ArrivalTime,Plane_FK) VALUES ('AZ178','Sunday','YUL','16:00','JFK','17:00',6);
INSERT INTO flight (FlightID,DayOfWeek,DepartureAirport_FK,DepartureTime,ArrivalAirport_FK,ArrivalTime,Plane_FK) VALUES ('BA921','Monday','BFS','6:00','LHR','7:00',8);
INSERT INTO flight (FlightID,DayOfWeek,DepartureAirport_FK,DepartureTime,ArrivalAirport_FK,ArrivalTime,Plane_FK) VALUES ('LH522','Wednesday','NRT','12:00','DEN','20:00',3);
INSERT INTO flight (FlightID,DayOfWeek,DepartureAirport_FK,DepartureTime,ArrivalAirport_FK,ArrivalTime,Plane_FK) VALUES ('LH532','Friday','YUL','10:00','DEN','13:00',8);
INSERT INTO flight (FlightID,DayOfWeek,DepartureAirport_FK,DepartureTime,ArrivalAirport_FK,ArrivalTime,Plane_FK) VALUES ('LH542','Thursday','YVR','22:00','PDX','23:00',3);
INSERT INTO flight (FlightID,DayOfWeek,DepartureAirport_FK,DepartureTime,ArrivalAirport_FK,ArrivalTime,Plane_FK) VALUES ('LH575','Sunday','ORD','16:00','PDX','19:00',5);
INSERT INTO flight (FlightID,DayOfWeek,DepartureAirport_FK,DepartureTime,ArrivalAirport_FK,ArrivalTime,Plane_FK) VALUES ('LH581','Sunday','ORD','6:00','KIX','14:00',1);
INSERT INTO flight (FlightID,DayOfWeek,DepartureAirport_FK,DepartureTime,ArrivalAirport_FK,ArrivalTime,Plane_FK) VALUES ('TW211','Thursday','DEN','8:00','JFK','12:00',4);
INSERT INTO flight (FlightID,DayOfWeek,DepartureAirport_FK,DepartureTime,ArrivalAirport_FK,ArrivalTime,Plane_FK) VALUES ('TW250','Monday','YEG','9:00','PDX','11:00',8);
INSERT INTO flight (FlightID,DayOfWeek,DepartureAirport_FK,DepartureTime,ArrivalAirport_FK,ArrivalTime,Plane_FK) VALUES ('UA412','Thursday','SEA','16:00','SYD','2:00',1);
INSERT INTO flight (FlightID,DayOfWeek,DepartureAirport_FK,DepartureTime,ArrivalAirport_FK,ArrivalTime,Plane_FK) VALUES ('UA431','Friday','PER','11:00','SYD','15:00',6);
INSERT INTO flight (FlightID,DayOfWeek,DepartureAirport_FK,DepartureTime,ArrivalAirport_FK,ArrivalTime,Plane_FK) VALUES ('UA455','Saturday','ORD','15:00','DEN','17:00',5);
INSERT INTO flight (FlightID,DayOfWeek,DepartureAirport_FK,DepartureTime,ArrivalAirport_FK,ArrivalTime,Plane_FK) VALUES ('UA465','Saturday','YUL','11:00','ORD','14:00',3);
INSERT INTO flight (FlightID,DayOfWeek,DepartureAirport_FK,DepartureTime,ArrivalAirport_FK,ArrivalTime,Plane_FK) VALUES ('UA472','Tuesday','JFK','10:00','LHR','17:00',2);
INSERT INTO flight (FlightID,DayOfWeek,DepartureAirport_FK,DepartureTime,ArrivalAirport_FK,ArrivalTime,Plane_FK) VALUES ('UA499','Wednesday','YEG','18:00','JFK','21:00',4);

-- ----------------------------------------------------------------------------------------------------------------------
# QUERIES AND CHANGES

-- Query all flights out of Chicago's ORD airport
SELECT * FROM flight WHERE DepartureAirport_FK='ORD';
/* OUTPUT
+----------+-----------+---------------------+---------------+-------------------+-------------+----------+
| FlightID | DayOfWeek | DepartureAirport_FK | DepartureTime | ArrivalAirport_FK | ArrivalTime | Plane_FK |
+----------+-----------+---------------------+---------------+-------------------+-------------+----------+
| LH575    | Sunday    | ORD                 | 16:00:00      | PDX               | 19:00:00    |        5 |
| LH581    | Sunday    | ORD                 | 06:00:00      | KIX               | 14:00:00    |        1 |
| UA455    | Saturday  | ORD                 | 15:00:00      | DEN               | 17:00:00    |        5 |
+----------+-----------+---------------------+---------------+-------------------+-------------+----------+
3 row(s) returned	0.000 sec / 0.000 sec */

-- Query all Thursday morning flights
SELECT * FROM flight WHERE DepartureTime < '12:00:00';
/* OUTPUT
+----------+-----------+---------------------+---------------+-------------------+-------------+----------+
| FlightID | DayOfWeek | DepartureAirport_FK | DepartureTime | ArrivalAirport_FK | ArrivalTime | Plane_FK |
+----------+-----------+---------------------+---------------+-------------------+-------------+----------+
| AZ159    | Thursday  | SEA                 | 09:00:00      | DME               | 17:00:00    |        2 |
| BA921    | Monday    | BFS                 | 06:00:00      | LHR               | 07:00:00    |        8 |
| LH532    | Friday    | YUL                 | 10:00:00      | DEN               | 13:00:00    |        8 |
| LH581    | Sunday    | ORD                 | 06:00:00      | KIX               | 14:00:00    |        1 |
| TW211    | Thursday  | DEN                 | 08:00:00      | JFK               | 12:00:00    |        4 |
| TW250    | Monday    | YEG                 | 09:00:00      | PDX               | 11:00:00    |        8 |
| UA431    | Friday    | PER                 | 11:00:00      | SYD               | 15:00:00    |        6 |
| UA465    | Saturday  | YUL                 | 11:00:00      | ORD               | 14:00:00    |        3 |
| UA472    | Tuesday   | JFK                 | 10:00:00      | LHR               | 17:00:00    |        2 |
+----------+-----------+---------------------+---------------+-------------------+-------------+----------+
9 row(s) returned	0.000 sec / 0.000 sec */

-- Insert a new flight with a new flight ID
INSERT INTO flight (FlightID,DayOfWeek,DepartureAirport_FK,DepartureTime,ArrivalAirport_FK,ArrivalTime,Plane_FK) VALUES ('YE420', 'Friday','JFK','4:20:00','DEN','8:40:00',4);
/* OUTPUT
1 row(s) affected	0.000 sec */

-- Delete the Friday morning flight out of PER
DELETE from flight WHERE DayOfWeek="Friday" AND DepartureAirport_FK="PER" AND DepartureTime < "12:00:00";
/* OUTPUT
1 row(s) affected	0.000 sec */

-- ----------------------------------------------------------------------------------------------------------------------

-- when complete
DROP TABLE flight;
DROP TABLE airport;
DROP TABLE city;
DROP TABLE plane;
DROP DATABASE airtraffic;