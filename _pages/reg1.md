---
layout: home
permalink: /reg1/
title: "Simple Linear Regression"
author_profile: true
toc: true
---

##  <a name="toc"/>
- [Introduction](#Introduction)
- [Assumptions of linear regression](#assumptions)
- [Term structure](#Term)
- [Distribution of LIBOR interest rates]
- [Non-stationary vs. stationary time series](#Stationary)



## Introduction <a name="Introduction"/> 
[Return to Top](#toc)
Simple linear regression is useful for finding relationship between two continuous variables. One is predictor or independent variable (X) and other is response or dependent variable (Y). It looks for statistical relationship but not deterministic relationship. Relationship between two variables is said to be deterministic if one variable can be accurately expressed by the other. For example, using temperature in degree Celsius it is possible to accurately predict Fahrenheit. Statistical relationship is not accurate in determining relationship between two variables. For example, relationship between height and weight. Linear regression models provide a simple approach towards supervised learning. They are simple yet effective. The linear equation for univariate linear regression is given below:

![lm](https://latex.codecogs.com/gif.latex?y%3D%5Cbeta_0x&plus;%5Cbeta_1)

![y](https://latex.codecogs.com/gif.latex?y) is the dependent variable, ![x](https://latex.codecogs.com/gif.latex?x) independent variable, ![b0](https://latex.codecogs.com/gif.latex?\beta_0), ![b1](https://latex.codecogs.com/gif.latex?\beta_1) are the intercept and slope of the best fit line, respectively.

## Introduction <a name="assumptions"/> 
[Return to Top](#toc)