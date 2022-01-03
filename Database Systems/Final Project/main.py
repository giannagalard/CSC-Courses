
#  /$$      /$$                     /$$                 /$$$$$$$  /$$                                        
# | $$$    /$$$                    |__/                | $$__  $$| $$                                        
# | $$$$  /$$$$ /$$   /$$  /$$$$$$$ /$$  /$$$$$$$      | $$  \ $$| $$  /$$$$$$  /$$   /$$  /$$$$$$   /$$$$$$ 
# | $$ $$/$$ $$| $$  | $$ /$$_____/| $$ /$$_____/      | $$$$$$$/| $$ |____  $$| $$  | $$ /$$__  $$ /$$__  $$
# | $$  $$$| $$| $$  | $$|  $$$$$$ | $$| $$            | $$____/ | $$  /$$$$$$$| $$  | $$| $$$$$$$$| $$  \__/
# | $$\  $ | $$| $$  | $$ \____  $$| $$| $$            | $$      | $$ /$$__  $$| $$  | $$| $$_____/| $$      
# | $$ \/  | $$|  $$$$$$/ /$$$$$$$/| $$|  $$$$$$$      | $$      | $$|  $$$$$$$|  $$$$$$$|  $$$$$$$| $$      
# |__/     |__/ \______/ |_______/ |__/ \_______/      |__/      |__/ \_______/ \____  $$ \_______/|__/      
#                                                                               /$$  | $$                    
#                                                                              |  $$$$$$/                    
#                                                                               \______/                     
# Author: Gianna Galard (github.com/giannagalard)
# Date:   Dec 2021
# Description: This is a music recommendation service

# import mysql connector
# python3 -m pip install mysql-connector-python
import mysql.connector
import sys

# connect to db as user 'api'
try: 
    mydb = mysql.connector.connect(
        host="localhost",
        user="root",
        passwd="root",
        database="CSC315FINALPROJECT"
    )

# if connection fails, print error
except mysql.connector.Error as err:
    print(err)
    sys.exit(1)

# create cursor object to execute queries
cursor = mydb.cursor()

def getError(error, result): # error handling func
    return (error, result) # return error and result (e.g. None)

def queryExecution(query, *args): # query execution func
    try:
        cursor.execute(query, *args)
        result = cursor.fetchall()
        return result
    except mysql.connector.Error as err:
        return getError(err, None)
    return getError(None, result)

# insert a new user into the database
def insertUser(user_id, name, country):
    query = "INSERT INTO users (user_id, name, country) VALUES (%s, %s, %s)"
    args = (user_id, name, country)
    return queryExecution(query, args)

# check if band exists in the database and obtain band_id then insert into favorites
def insertFavorite(user_id, band_id):
    query = "SELECT band_id FROM bands WHERE band_id = %s"
    args = (band_id,)
    result = queryExecution(query, args)
    if result[0][0] == band_id:
        query = "INSERT INTO favorites (user_id, band_id) VALUES (%s, %s)"
        args = (user_id, band_id)
        return queryExecution(query, args)
    else:
        return getError("Band does not exist", None)

# check if band exists in the database and then obtain the band_id to remove from favorites
def removeFavorite(user_id, band_id):
    query = "SELECT band_id FROM bands WHERE band_id = %s"
    args = (band_id,)
    result = queryExecution(query, args)
    if result[0][0] == band_id:
        query = "DELETE FROM favorites WHERE user_id = %s AND band_id = %s"
        args = (user_id, band_id)
        return queryExecution(query, args)
    else:
        return getError("Band does not exist", None)

# inserting users into the database
def insertUsers(users):
    for user in users:
        insertUser(0, 'Gianna Galard', 'United States')
        insertUser(1, '', '')

