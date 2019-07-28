---
layout: home
permalink: /reg2/
title: "Multivariate Linear Regression and Regularization"
author_profile: true
toc: true
---

##  <a name="toc"/>
1. [Introduction](#Introduction)
2. [Example of Multi-variate linear regression](#example)

	2.1. [Data Extraction and Data Explotorary Analysis](#data)


## 1. Introduction <a name="Introduction"/> 
[Return to Top](#toc)

Multiple linear regression is an extension of simple linear regression used to predict an outcome variable (![y](https://latex.codecogs.com/gif.latex?y)) on the basis of multiple distinct predictor variables (![x](https://latex.codecogs.com/gif.latex?x)). The prediction of ![y](https://latex.codecogs.com/gif.latex?y) with n predictor variables is expressed by the following equation:

![mlr](https://latex.codecogs.com/gif.latex?y%3D%5Cbeta_0%20&plus;%5Cbeta_1x_1&plus;%5Cbeta_2x_2&plus;%5Ccdot%5Ccdot%5Ccdot&plus;%5Cbeta_nx_n)

The beta coefficients measure the association between the predictor variable and the outcome. “![beta_i](https://latex.codecogs.com/gif.latex?%5Cbeta_i)” can be interpreted as the average effect on ![y](https://latex.codecogs.com/gif.latex?y) of a one unit increase in “![x_i](https://latex.codecogs.com/gif.latex?x_i)”, holding all other predictors fixed.

## 2. Example of Multi-variate linear regression <a name="example"/> 

In this section, you will learn how to build and interpret a multiple linear regression model in R and check the overall quality of the model. The "mtcars" data set will be used for this example. This data set gives a comparison between different car models in terms of mileage per gallon (mpg), cylinder displacement("disp"), horse power("hp"), weight of the car("wt") and some more parameters. Click here to download the data.

The goal of the model is to establish the relationship between "mpg" as a response variable with "disp", "cyl", "hp", "wt", "drat", "qsec", "VS", "am", "gear", "carb" as predictor variables. The definitions of these variables are:

|**Variable**|**Meaning**|
|---|---|
|mpg| Miles per gallon (US) |
|cyl| Number of cylinders |
|disp| Displacement (cu.in.) |
|hp| Gross horsepower |
|drat| Rear axle ratio |
|wt| Weight (lb/1000) |
|qsec| 1/4 mile time |
|VS| V/S |
|am| Transmission (0=automatic, 1=manual) |
|gear| Number of forward gear |
|carb| Number of Carburetors |


## 2.1. Data Extraction and Data Explotorary Analysis <a name="data"/>
