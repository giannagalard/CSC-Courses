
#   ____        _           ____ _                  _             
#  |  _ \  __ _| |_ __ _   / ___| | ___  __ _ _ __ (_)_ __   __ _ 
#  | | | |/ _` | __/ _` | | |   | |/ _ \/ _` | '_ \| | '_ \ / _` |
#  | |_| | (_| | || (_| | | |___| |  __/ (_| | | | | | | | | (_| |
#  |____/ \__,_|\__\__,_|  \____|_|\___|\__,_|_| |_|_|_| |_|\__, |
#                                                           |___/ 

# AUTHORS : Gianna Galard, George Melek, Austin Li
# CSC412 PROFESSOR IMBERMAN
# DATE : 11/23/2021

import pandas as pd 
import numpy as np
from sklearn.tree import DecisionTreeClassifier
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score

# load the heart data
df = pd.read_csv('heartdata.csv') 

# print the first 5 rows of the data set
print(df.head()) 

# determine the datatype of each column
print(df.dtypes)

# print the unique values for the columns **ca** and **thal**
print(df.ca.unique()) 
print(df.thal.unique())

# determine how many rows contain missing values in the columns **ca** and **thal**
# print(df.ca.isnull().sum()) 
# print(df.thal.isnull().sum()) 

# determine how many rows contain missing values, the python code is below
len(df.loc[(df['ca'] == '?') | (df['thal'] == '?')]) 

# since only 6 rows have missing values, let's look at them
missing = df.loc[(df['ca'] == '?') | (df['thal'] == '?')]
missing

# count the number of rows in the full dataset
len(df)

# remove the rows with missing values
# df = df.dropna() # dropna() is a method of the pandas dataframe that removes all rows with missing values
df.drop(missing.index, inplace=True) # inplace=True means that the changes are made in the original dataframe

# verify that the rows with missing values have been removed
print(len(df)) # the length of the dataframe should be reduced by 6 rows

# verify using the unique function that "ca" and "thal" do not have missing values
print(df.ca.unique())
print(df.thal.unique())

# split the data into dependent and independent variables
# the column of data that we will to to make classifications
#X = df.iloc[:,:-1] # this line of code is the same as X = df.drop(['hd'], axis=1)
X = df.copy()
X.drop(['hd'], axis=1, inplace=True)
# the column of data that we want to predict
y = df.copy()
y = y['hd']
#y = df.iloc[:,-1] # this line of code is the same as y = df['hd']

# print the head of both the X and y dataframes so that you can verify this worked correctly
print(X.head()) # this is the independent variables
print(y.head()) # this is the dependent variables

X['restecg'].unique() # this is the unique values for the restecg column

X_encoded = pd.get_dummies(X, columns=['cp',
 'restecg',
'slope',
 'thal'])

X_encoded.head()

y.unique() # this should return the unique values in the dependent variable

y_not_zero_idx = y > 0 # this is a boolean array that is true if the dependent variable is greater than 0
y[y_not_zero_idx] = 1 # this changes the dependent variable to 1 if it is greater than 0
y.unique()

# split the data into training and testing sets
X_train, X_test, y_train, y_test = train_test_split(X_encoded, y, test_size=0.2, random_state=0) 

# use this data to run a decision tree on the data
tree = DecisionTreeClassifier(max_depth=None, random_state=0) # create a decision tree classifier
tree.fit(X_train, y_train) # fit the data to the tree
y_pred = tree.predict(X_test) # this is the actual prediction

# print how many levels of the tree were created and the accuracy of the model
print(tree.tree_.max_depth) # this is the number of levels in the tree
print(accuracy_score(y_test, y_pred)) # this is the accuracy of the model