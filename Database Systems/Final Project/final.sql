CREATE DATABASE CSC315Final2021;
USE CSC315Final2021;


CREATE TABLE Genre (
	gid INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	gname CHAR(20) NOT NULL
);

INSERT INTO Genre (gname) VALUES ('Rock'), ('Jazz'), ('Country'), ('Classical'), ('Throat Singing');

CREATE TABLE Sub_Genre (
	sgid INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	gname CHAR(20) NOT NULL,
	sgname CHAR(20) NOT NULL
);

INSERT INTO Sub_Genre (gname, sgname) VALUES ('Rock', 'Blues'), ('Rock', 'Classic Rock'), ('Rock', 'Power Metal'), ('Rock', 'Thrash Metal'), ('Rock', 'Death Metal'), ('Rock', 'Folk Metal');
INSERT INTO Sub_Genre (gname, sgname) VALUES ('Jazz', 'Swing'), ('Jazz', 'Smooth Jazz'), ('Jazz', 'Bossa Nova'), ('Jazz', 'Ragtime');
INSERT INTO Sub_Genre (gname, sgname) VALUES ('Country', 'Bluegrass'), ('Country', 'Country and Western'), ('Country', 'Jug Band');
INSERT INTO Sub_Genre (gname, sgname) VALUES ('Classical', 'Chamber Music'), ('Classical', 'Opera'), ('Classical', 'Orchestral');
INSERT INTO Sub_Genre (gname, sgname) VALUES ('Throat Singing', 'Khoomii'), ('Throat Singing', 'Kargyraa'), ('Throat Singing', 'Khamryn');

CREATE TABLE Region (
	rid INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	rname CHAR(20) NOT NULL
);

INSERT INTO Region (rname) VALUES ('Central Asia'), ('Europe'), ('North Americ'), ('South America');

CREATE TABLE Country (
	rid INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	rname CHAR(20) NOT NULL,
	cname CHAR(20) NOT NULL
);

INSERT INTO Country (rname, cname) VALUES ('Central Asia', 'Mongolia'), ('Central Asia', 'Tibet'), ('Central Asia', 'Tuva');
INSERT INTO Country (rname, cname) VALUES ('North Americ', 'Canada'), ('North Americ', 'United States'), ('North Americ', 'Mexico');
INSERT INTO Country (rname, cname) VALUES ('South Americ', 'Brazil');
INSERT INTO Country (rname, cname) VALUES ('Europe', 'Norway'), ('Europe', 'Austria'), ('Europe', 'England'), ('Europe', 'Russia');

CREATE TABLE Bands (
	bid INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	bname CHAR(20) NOT NULL
);

INSERT INTO Bands (bname) VALUES ('Seputura'), ('Death'), ('Muddy Waters'), ('Led Zeppelin'), ('The Guess Who');
INSERT INTO Bands (bname) VALUES ('The Hu'), ('Huun-Huur-Tu'), ('Paul Pena'), ('Battuvshin'), ('Sade');
INSERT INTO Bands (bname) VALUES ('Mozart'), ('Tchaikovsky'), ('Twisted Sister'), ('Testament'), ('Tengger Cavalry');

CREATE TABLE Band_Origins (
	boid INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	bname CHAR(20) NOT NULL,
	cname CHAR(20) NOT NULL
);

INSERT INTO Band_Origins (bname, cname) VALUES ('Seputura', 'Brazil');
INSERT INTO Band_Origins (bname, cname) VALUES ('Death', 'United States');
INSERT INTO Band_Origins (bname, cname) VALUES ('Muddy Waters', 'United States');
INSERT INTO Band_Origins (bname, cname) VALUES ('Led Zeppelin', 'England');
INSERT INTO Band_Origins (bname, cname) VALUES ('The Guess Who', 'Canada');
INSERT INTO Band_Origins (bname, cname) VALUES ('The Hu', 'Mongolia');
INSERT INTO Band_Origins (bname, cname) VALUES ('Huun-Huur-Tu', 'Tuva');
INSERT INTO Band_Origins (bname, cname) VALUES ('Paul Pena', 'United States');
INSERT INTO Band_Origins (bname, cname) VALUES ('Battuvshin', 'Mongolia');
INSERT INTO Band_Origins (bname, cname) VALUES ('Sade', 'England');
INSERT INTO Band_Origins (bname, cname) VALUES ('Mozart', 'Austria');
INSERT INTO Band_Origins (bname, cname) VALUES ('Tchaikovsky', 'Russia');
INSERT INTO Band_Origins (bname, cname) VALUES ('Twisted Sister', 'United States');
INSERT INTO Band_Origins (bname, cname) VALUES ('Testament', 'United States');
INSERT INTO Band_Origins (bname, cname) VALUES ('Tengger Cavalry', 'United States');

CREATE TABLE Band_Styles (
	boid INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	bname CHAR(20) NOT NULL,
	sgname CHAR(20) NOT NULL
);

INSERT INTO Band_Styles (bname, sgname) VALUES ('Seputura', 'Death Metal');
INSERT INTO Band_Styles (bname, sgname) VALUES ('Seputura', 'Thrash Metal');
INSERT INTO Band_Styles (bname, sgname) VALUES ('Death', 'Death Metal');
INSERT INTO Band_Styles (bname, sgname) VALUES ('Muddy Waters', 'Blues');
INSERT INTO Band_Styles (bname, sgname) VALUES ('Led Zeppelin', 'Classic Rock');
INSERT INTO Band_Styles (bname, sgname) VALUES ('The Guess Who', 'Classic Rock');
INSERT INTO Band_Styles (bname, sgname) VALUES ('The Hu', 'Folk Metal');
INSERT INTO Band_Styles (bname, sgname) VALUES ('The Hu', 'Khoomii');
INSERT INTO Band_Styles (bname, sgname) VALUES ('Huun-Huur-Tu', 'Khoomii');
INSERT INTO Band_Styles (bname, sgname) VALUES ('Huun-Huur-Tu', 'Kargyraa');
INSERT INTO Band_Styles (bname, sgname) VALUES ('Paul Pena', 'Blues');
INSERT INTO Band_Styles (bname, sgname) VALUES ('Paul Pena', 'Kargyraa');
INSERT INTO Band_Styles (bname, sgname) VALUES ('Battuvshin', 'Khoomii');
INSERT INTO Band_Styles (bname, sgname) VALUES ('Battuvshin', 'Smooth Jazz');
INSERT INTO Band_Styles (bname, sgname) VALUES ('Sade', 'Smooth Jazz');
INSERT INTO Band_Styles (bname, sgname) VALUES ('Mozart', 'Opera');
INSERT INTO Band_Styles (bname, sgname) VALUES ('Tchaikovsky', 'Opera');
INSERT INTO Band_Styles (bname, sgname) VALUES ('Tchaikovsky', 'Orchestral');
INSERT INTO Band_Styles (bname, sgname) VALUES ('Twisted Sister', 'Thrash Metal');
INSERT INTO Band_Styles (bname, sgname) VALUES ('Testament', 'Thrash Metal');
INSERT INTO Band_Styles (bname, sgname) VALUES ('Tengger Cavalry', 'Folk Metal');
INSERT INTO Band_Styles (bname, sgname) VALUES ('Tengger Cavalry', 'Khoomii');

-- END OF GIVEN SQL ------------------------

-- 1. (9 points) Create db user called “api” with limited access of read only of initially given 
-- tables in the template, and read/write/update permissions for all additional tables created 
-- for this project in the next steps.
CREATE USER 'api'@'localhost' IDENTIFIED BY 'luna';
GRANT SELECT ON Genre TO 'api'@'localhost';
GRANT SELECT ON Sub_Genre TO 'api'@'localhost';
GRANT SELECT ON Region TO 'api'@'localhost';
GRANT SELECT ON Country TO 'api'@'localhost';
GRANT SELECT ON Bands TO 'api'@'localhost';
GRANT SELECT ON Band_Origins TO 'api'@'localhost';
GRANT SELECT ON Band_Styles TO 'api'@'localhost';

SHOW GRANTS;

-- 2. (9 points) Create a User relation. User needs an ID, name, and home country.
CREATE TABLE Users (
	uid int NOT NULL AUTO_INCREMENT PRIMARY KEY,
	username VARCHAR(20),
    homeCountry VARCHAR(20)
);

-- 3. (9 points) Create a Favorites relation. Favorites needs to reference user, and bands.
CREATE TABLE Favorites (
    uid int NOT NULL,
    bid int NOT NULL,
    FOREIGN KEY (uid) REFERENCES Users(uid),
    FOREIGN KEY (bid) REFERENCES Bands(bid)
);

-- 4. (9 points) Create a query to determine which sub_genres come from which regions.
SELECT DISTINCT S.sgname, R.rname FROM Band_Styles S JOIN
    (SELECT O.bname, C.rname FROM Band_Origins O JOIN Country C
        WHERE C.cname = O.cname
    ) AS R
    WHERE S.bname = R.bname;

-- 5. (9 points) Create a query to determine what other bands, not currently in their favorites,
-- are of the same sub_genres as those which are.
SELECT bname FROM
(SELECT DISTINCT sgname FROM 
    (SELECT bname FROM Bands WHERE bid IN 
        (SELECT bid FROM Favorites WHERE uid = 1)
    ) AS UsersFavorites
    JOIN
    (SELECT bname,sgname FROM Band_Styles) AS Styles 
    WHERE UsersFavorites.bname = Styles.bname) AS SGUsersFavorites
JOIN
(SELECT DISTINCT NotFavorites.bname,sgname FROM 
    (SELECT bid,bname FROM Bands WHERE bid NOT IN 
        (SELECT bid FROM Favorites WHERE uid=1)
    ) as NotFavorites
    JOIN
    (SELECT bname,sgname FROM Band_Styles) AS Styles 
    WHERE NotFavorites.bname = Styles.bname) AS SGNotUsersFavorites
WHERE SGNotUsersFavorites.sgname = SGUsersFavorites.sgname; 

-- 6. (9 points) Create a query to determine what other bands, not currently in their favorites, 
-- are of the same genres as those which are.
SELECT DISTINCT GNotUsersFavorites.bname,GNotUsersFavorites.gname FROM

    (SELECT DISTINCT UsersFavorites.bname,BGenre.gname FROM 
        (SELECT bname FROM Bands WHERE bid IN 
            (SELECT bid FROM Favorites WHERE uid=1)
        ) AS UsersFavorites
        JOIN
        (SELECT Style.bname,Style.sgname,SGenre.gname FROM
            Band_Styles Style JOIN Sub_Genre SGenre 
                WHERE Style.sgname=SGenre.sgname
            ) AS BGenre
    WHERE UsersFavorites.bname=BGenre.bname) AS GUsersFavorites
    JOIN
    (SELECT DISTINCT NotUsersFavorites.bname,BGenre.gname FROM 
        (SELECT bname FROM Bands WHERE bid NOT IN
            (SELECT bid FROM Favorites WHERE uid=1)
        ) AS NotUsersFavorites
        JOIN
        (SELECT Style.bname,Style.sgname,SGenre.gname FROM 
            Band_Styles Style JOIN Sub_Genre SGenre 
                WHERE Style.sgname=SGenre.sgname
            ) AS BGenre
    WHERE NotUsersFavorites.bname=BGenre.bname) AS GNotUsersFavorites

WHERE GNotUsersFavorites.gname=GUsersFavorites.gname;

-- 7. (9 points) Create a query which finds other users who have the same band in their favorites, 
-- and list their other favorite bands.
SELECT bname FROM Bands JOIN
    (SELECT DISTINCT bid FROM
        (SELECT uid FROM Favorites WHERE bid IN 
            (SELECT bid FROM Favorites WHERE uid=1)
                AND uid!=1) AS OtherUsers
        JOIN
        (select * from Favorites) AS F
    WHERE F.uid=OtherUsers.uid) AS OtherFavorites
WHERE Bands.bid=OtherFavorites.bid;

-- 8. (9 points) Create a query to list other countries, excluding the user’s home country, 
-- where they could travel to where they could hear the same genres as the bands in their favorites.
SELECT DISTINCT cname FROM Band_Origins
JOIN
    (SELECT DISTINCT BGenre.* FROM 
        (SELECT bname FROM Bands WHERE bid IN
            (SELECT bid FROM Favorites WHERE uid=1)
        ) AS UsersFavorites
        JOIN
        (SELECT Style.bname,Style.sgname,SGenre.gname FROM  
            Band_Styles Style JOIN Sub_Genre SGenre 
                where Style.sgname=SGenre.sgname
            ) AS BGenre
    WHERE UsersFavorites.bname=BGenre.bname) AS UserGenres
WHERE Band_Origins.bname=UserGenres.bname AND
cname NOT IN (SELECT homeCountry FROM Users WHERE uid=1);


-- cleanup
DROP TABLE Favorites;
DROP TABLE Users;
DROP TABLE Band_Styles;
DROP TABLE Band_Origins;
DROP TABLE Bands;
DROP TABLE Country;
DROP TABLE Region;
DROP TABLE Sub_Genre;
DROP TABLE Genre;
DROP DATABASE CSC315Final2021;
