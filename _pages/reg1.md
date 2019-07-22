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
- [Example of linear regression](#example)


## Introduction <a name="Introduction"/> 
[Return to Top](#toc)

Simple linear regression is useful for finding relationship between two continuous variables. One is predictor or independent variable (X) and other is response or dependent variable (Y). It looks for statistical relationship but not deterministic relationship. Relationship between two variables is said to be deterministic if one variable can be accurately expressed by the other. For example, using temperature in degree Celsius it is possible to accurately predict Fahrenheit. Statistical relationship is not accurate in determining relationship between two variables. For example, relationship between height and weight. Linear regression models provide a simple approach towards supervised learning. They are simple yet effective. The linear equation for univariate linear regression is given below:

![lm](https://latex.codecogs.com/gif.latex?y%3D%5Cbeta_0x&plus;%5Cbeta_1)

![y](https://latex.codecogs.com/gif.latex?y) is the dependent variable, ![x](https://latex.codecogs.com/gif.latex?x) independent variable, ![b0](https://latex.codecogs.com/gif.latex?\beta_0), ![b1](https://latex.codecogs.com/gif.latex?\beta_1) are the intercept and slope of the best fit line, respectively.

## Assumptions of Linear Regression <a name="assumptions"/> 
[Return to Top](#toc)

1. **Linear Relationship between the features and target:** According to this assumption there is linear relationship between the features and target. Linear regression captures only linear relationship. This can be validated by plotting a scatter plot between the features and the target. The left scatter plot tells us that as x increases y also increases linearly. However, the right scatter plot shows no significant linear relation between x and y.
<img src="{{ site.url }}{{ site.baseurl }}/images/reg/reg1.png"> 
2. **Little or no Multicollinearity between the features:** Multicollinearity is a state of very high inter-correlations or inter-associations among the independent variables. Pair plots and heatmaps(correlation matrix) can be used for identifying highly correlated features. If we have 2 features which are highly correlated we can drop one feature or combine the 2 features to form a new feature,which can further be used for prediction.

3. **Homoscedasticity Assumption:** Homoscedasticity describes a situation in which the error term (that is, the “noise” or random disturbance in the relationship between the features and the target) is the same across all values of the independent variables.A scatter plot of residual values vs predicted values is a goodway to check for homoscedasticity. There should be no clear pattern in the distribution and if there is a specific pattern,the data is heteroscedastic.
<img src="{{ site.url }}{{ site.baseurl }}/images/reg/reg2.png">

4. **Normal distribution of error terms:** Normal distribution of the residuals can be validated by plotting a q-q plot. The left graph shows a normal distribution, whereas, the right graph does not.
<img src="{{ site.url }}{{ site.baseurl }}/images/reg/reg3.png">

5. **Little or No autocorrelation in the residuals:** Autocorrelation occurs when the residual errors are dependent on each other.The presence of correlation in error terms drastically reduces model’s accuracy. This usually occurs in time series models where the next instant is dependent on previous instant. Autocorrelation can be tested with the help of Durbin-Watson test.The null hypothesis of the test is that there is no serial correlation. The Durbin-Watson test statistics is defined as:

	![DW](https://latex.codecogs.com/gif.latex?DW_%7Btest%7D%3D%5Cfrac%7B%5Csum_%7Bt%3D2%7D%5E%7BT%7D%28e_t-e_%7Bt-1%7D%29%5E2%7D%7B%5Csum_%7Bt%3D1%7D%5E%7BT%7De_t%5E2%7D)

	The test statistic is approximately equal to ![DW2](https://latex.codecogs.com/gif.latex?2%281-r%29) where r is the sample autocorrelation of the residuals. Thus, for r = 0, indicating no serial correlation, the test statistic equals 2. This statistic will always be between 0 and 4. The closer to 0 the statistic, the more evidence for positive serial correlation. The closer to 4, the more evidence for negative serial correlation.


## Example of linear regression <a name="example"/> 
[Return to Top](#toc)

In this post, I’ll walk you through how to build a linear regression in R and use built-in diagnostic plots for linear regression analysis. The data I will be using shows the height and weight of 50 random women. You can download the data here. The first step is to read the data and assign variables x and y to each column.
```r
data=read.csv(file="C:/Users/User/Desktop/GitHub/sasanmehrabian.github.io/data/women.csv")
x=data$height
y=data$weight
plot(x, y, xlab="Height (cm)", ylab="Weight (kg)", pch=18, col="blue")
```
<img src="{{ site.url }}{{ site.baseurl }}/images/reg/women1.png">


Use the lm function to build the model, and use the "summary" command line to see the coefficients and statistical parameters:
``` r
model = lm(y~x, data = data)
summary(model)
```
<img src="{{ site.url }}{{ site.baseurl }}/images/reg/women2.png">

There are a lot of statistics in the above figure. 
1) **Residuals:** Provide a quick view of the distribution of the residuals, which by definition have a mean zero. Therefore, the median should not be far from zero, and the minimum and maximum should be roughly equal in absolute value.
2) **Coefficients:** Shows the regression beta coefficients and their statistical significance. Predictor variables, that are significantly associated to the outcome variable, are marked by stars.

Mathematically, the beta coefficients (![b0](https://latex.codecogs.com/gif.latex?\beta_0), ![b1](https://latex.codecogs.com/gif.latex?\beta_1)) are determined so that the RSS is as minimal as possible. This method of determining the beta coefficients is technically called least squares regression or ordinary least squares (OLS) regression. Once, the beta coefficients are calculated, a t-test is performed to check whether or not these coefficients are significantly different from zero. A non-zero beta coefficients means that there is a significant relationship between the predictors (![x](https://latex.codecogs.com/gif.latex?x)) and the outcome variable (![y](https://latex.codecogs.com/gif.latex?y)).

For a given predictor (![x](https://latex.codecogs.com/gif.latex?x)), the t-statistic (and its associated p-value) tests whether or not there is a statistically significant relationship between a given predictor and the outcome variable (![y](https://latex.codecogs.com/gif.latex?y)), that is whether or not the beta coefficient of the predictor is significantly different from zero.

The statistical hypotheses are as follow:
- **Null hypothesis (H0):** the coefficients are equal to zero (i.e., no relationship between x and y)
- **Alternative Hypothesis (Ha):** the coefficients are not equal to zero (i.e., there is some relationship between x and y)

Mathematically, for a given beta coefficient (![bi](https://latex.codecogs.com/gif.latex?\beta_i)), the t-test measures the number of standard deviations that beta is away from 0. Thus a large t-statistic will produce a small p-value. The higher the t-statistic (and the lower the p-value), the more significant the predictor. The symbols to the right visually specifies the level of significance. The line below the table shows the definition of these symbols; one star means 0.01 < p < 0.05. The more the stars beside the variable’s p-value, the more significant the variable.

The t-statistic is a very useful guide for whether or not to include a predictor in a model. This will be useful in multi-variate linear regression. High t-statistics (which go with low p-values near 0) indicate that a predictor should be retained in a model, while very low t-statistics indicate a predictor could be dropped.

In our example, both the p-values for the intercept and the predictor variable are highly significant, so we can reject the null hypothesis and accept the alternative hypothesis, which means that there is a significant association between the predictor and the outcome variables.


3) **Residual standard error (RSE)**, **R-squared (R2)** and the **F-statistic** are metrics that are used to check how well the model fits to our data.


**Standard errors and confidence intervals:**