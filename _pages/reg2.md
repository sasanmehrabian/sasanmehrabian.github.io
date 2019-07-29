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

	2.1. [Data extraction and data explotorary analysis](#data)

	2.2. [Building a regression model and some statistical analysis](#build)

## 1. Introduction <a name="Introduction"/> 
[Return to Top](#toc)

Multiple linear regression is an extension of simple linear regression used to predict an outcome variable (![y](https://latex.codecogs.com/gif.latex?y)) on the basis of multiple distinct predictor variables (![x](https://latex.codecogs.com/gif.latex?x)). The prediction of ![y](https://latex.codecogs.com/gif.latex?y) with n predictor variables is expressed by the following equation:

![mlr](https://latex.codecogs.com/gif.latex?y%3D%5Cbeta_0%20&plus;%5Cbeta_1x_1&plus;%5Cbeta_2x_2&plus;%5Ccdot%5Ccdot%5Ccdot&plus;%5Cbeta_nx_n)

The beta coefficients measure the association between the predictor variable and the outcome. “![beta_i](https://latex.codecogs.com/gif.latex?%5Cbeta_i)” can be interpreted as the average effect on ![y](https://latex.codecogs.com/gif.latex?y) of a one unit increase in “![x_i](https://latex.codecogs.com/gif.latex?x_i)”, holding all other predictors fixed.

## 2. Example of Multi-variate linear regression <a name="example"/> 

In this section, you will learn how to build and interpret a multiple linear regression model in R and check the overall quality of the model. The "mtcars" data set will be used for this example. This data set gives a comparison between different car models in terms of mileage per gallon (mpg), cylinder displacement("disp"), horse power("hp"), weight of the car("wt") and some more parameters. Click [here](https://github.com/sasanmehrabian/sasanmehrabian.github.io/tree/master/data/mtcars.csv) to download the data.

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
|VS| 0 = V-engine, 1 = S-engine |
|am| Transmission (0 = automatic, 1 = manual) |
|gear| Number of forward gear |
|carb| Number of Carburetors |


## 2.1. Data Extraction and Data Explotorary Analysis <a name="data"/>

We begin the analysis by performing some initial explaratory data analysis to get a better idea of the existing patterns between variables in the data set. Normally in regression analysis correlation plot is a very effective tool. Below we create a nice correlation plot using the "pearson" method. This is a nice way to investigate the relationship between all the variables in this data set.
```r
# read the data
cars=read.csv(file="C:/Users/User/Desktop/GitHub/sasanmehrabian.github.io/data/mtcars.csv")

# import necessary libraries
library(corrplot)
library(ggplot2)
library(stats) 

# create the correlation matrix and plot it
corr<-cor(cars[,2:12], method=c("pearson"))
corrplot(corr, type="upper", method = "pie", main="Pearson correlation for all the variables")
```
<img src="{{ site.url }}{{ site.baseurl }}/images/reg/car1.png">

We can see that mpg has high correlation with cyl, disp, hp, and wt. It is also worthwhile check how mpg varies by automatic versus manual transmission. For that purpose we create a Violin plot of mpg by automatic and manual transmissions. In our dataset 0 represents an automatic transmission and 1 means a manual transmission.
```r
ggplot(cars, aes(y=mpg, x=factor(am, labels = c("automatic", "manual")), fill=factor(am)))+
  geom_violin(colour="black", size=1)+
  xlab("transmission") + ylab("MPG")
```
<img src="{{ site.url }}{{ site.baseurl }}/images/reg/car2.png">

We can form a clear hypothesis from this visualization: it appears that automatic cars have a lower miles per gallon, and therefore a lower fuel efficiency, than manual cars do. But it is possible that this apparent pattern happened by random chance- that is, that we just happened to pick a group of automatic cars with low efficiency and a group of manual cars with higher efficiency. So to check whether that’s the case, we have to use a statistical test.

## 2.2. Building a regression model and some statistical analysis <a name="build"/>

Looking atthe definition of the variables, we can see that "am" and "vs" variable are categorical variables, and therefore are treated differently. We will use the "factor" built-in command in R for these two when building the model. We want to know what combination of predictors will best predict fuel efficiency. Which predictors increase our accuracy by a statistically significant amount? We might be able to guess at the some of the trends from the graph, but really we want to perform a statistical test to determine which predictors are significant, and to determine the ideal formula for prediction. 

Including variables that we should’t have increases actuall standard errors of the regression variables. Thus we don’t want to idly throw variables into the model. To confirm this fact, you can see below that if we include all the variables, not all of them will be significant predictor of MPG (judging by p-value at the 95% confidence level).
```r
model = lm(mpg ~ cyl + disp + hp + drat + wt + qsec 
           + factor(vs) + factor(am) + gear + carb, data = cars)

summary(model)
```
<img src="{{ site.url }}{{ site.baseurl }}/images/reg/car3.png">

The above figure shows high p-values meaning that the model is not good because of having so many variables, even though the R-squared is relatively high. A major problem with multivariate regression is collinearity. If two or more predictor variables are highly correlated, and they are both entered into a regression model, it increases the true standard error and you get a very unstable estimates of the slope. We can assess the collinearity by variance inflation factor (VIF). Lets look at the variance inflation factors if we throw all the variables into the model.

```r
# first install the KableExtra package:
# install.packages("kableExtra")
```

https://www.youtube.com/watch?v=QruEcbgfhzo