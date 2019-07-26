---
layout: home
permalink: /reg2/
title: "Multivariate Linear Regression and Regularization"
author_profile: true
toc: true
---

##  <a name="toc"/>
- [Introduction](#Introduction)
- [Example of Multi-variate linear regression](#example)


## Introduction <a name="Introduction"/> 
[Return to Top](#toc)

Multiple linear regression is an extension of simple linear regression used to predict an outcome variable (![y](https://latex.codecogs.com/gif.latex?y)) on the basis of multiple distinct predictor variables (![x](https://latex.codecogs.com/gif.latex?x)). The prediction of y with n predictor variables is expressed by the following equation:

![mlr](https://latex.codecogs.com/gif.latex?y%3D%5Cbeta_0%20&plus;%5Cbeta_1x_1&plus;%5Cbeta_2x_2&plus;%5Ccdot%5Ccdot%5Ccdot&plus;%5Cbeta_nx_n)

The beta coefficients measure the association between the predictor variable and the outcome. “![beta_i](https://latex.codecogs.com/gif.latex?%5Cbeta_i)” can be interpreted as the average effect on ![y](https://latex.codecogs.com/gif.latex?y) of a one unit increase in “![x_i](https://latex.codecogs.com/gif.latex?x_i)”, holding all other predictors fixed.
