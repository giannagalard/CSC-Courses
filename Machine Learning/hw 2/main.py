"""
This program: 
Reads the data
Plots the data as a scatter plot
Calculates and plots the linear regression for this data
Calculates the MSE for the data
Calculates the price of a:
- 1,200 square foot house
- 3,500 square foot house.
"""

# import header files
import numpy as np
import matplotlib.pyplot as plt 
from sklearn import linear_model
from sklearn.metrics import mean_squared_error 

# open txt file
infile = open('PortlandHousingData.txt')

# initialize two empty lists, size and price
size = []
price = []

# read the data into the var reader
print(infile.readline()) 
reader = infile.readline()
print(infile.readline())

# iterate through reader until eof
while reader:
    # split into a list of lists and assign the list to vals
    vals = reader.split() 

    # append 1st val from the list of vals to the list price
    price.append(int(vals[0]))
    # append 2nd val from the list of vals to the list vals
    size.append(int(vals[1]))
    reader = infile.readline()  
# close file
infile.close()

# create a linear regression model and store in var regression
regression = linear_model.LinearRegression()

# create two arrays, X = size, Y = price
X = np.array(size) 
Y = np.array(price)

# reshape X and Y into a single dataframe
X = X.reshape(X.size,1)
Y = Y.reshape(Y.size,1)

# take in data to be fitted
# fit a regression line to the data
regression.fit(X,Y)

# predicts y based off of X size
predictedVal = regression.predict(X)

# func calcs and outputs the mse of the predicted values and the actual values of y
print('Mean Squared Error (MSE) =  %.2f' % mean_squared_error(Y,predictedVal))
# calc and output price of 1200 sqft house
sqft1200 = regression.coef_*1200 + regression.intercept_
print('$$ 1200 SQFT $$ = ', sqft1200)
# calc and output price of 3500 sqft house
sqft3500 = regression.coef_*3500 + regression.intercept_
print('$$ 3500 SQFT $$ = ', sqft3500)

# ----- CUSTOMIZE GRAPH -----
figure = plt.figure()
figure.patch.set_facecolor(color = "lavenderblush")
ax = plt.gca()
ax.set_facecolor(color = "lavender")
figure.canvas.manager.set_window_title("Portland Housing Data")
plt.scatter(X,Y, color = "mediumpurple")
plt.plot(X, predictedVal, color = "rebeccapurple", linewidth = 1.7)
plt.xlabel("Size")
plt.ylabel("Price")
plt.show()