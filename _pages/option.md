---
layout: home
permalink: /option/
title: "Option pricing using Bionomial Tree and Black Scholes Models"
author_profile: true
toc: true
---
##  <a name="toc"/>
- [Introduction](#Introduction)
- [Binomial Tree model](#Binomial)
- [Black-Scholes model](#Black)
- [Conclusion](#Conclusion)

## Introduction <a name="Introduction"/> 
[Return to Top](#toc)

There are several models used for pricing options. Binomial tree and Black-Scholes are the most common models. The current stock price ![S](https://latex.codecogs.com/gif.latex?S), intrinsic value or the option strike price ![K](https://latex.codecogs.com/gif.latex?K), Maturity lenth ![T](https://latex.codecogs.com/gif.latex?T), risk-free interest rate ![r](https://latex.codecogs.com/gif.latex?r), volatility ![sigma](https://latex.codecogs.com/gif.latex?%5Csigma) are common factors for both models that determine the price of the option. 

For instance, if the stock price ![S](https://latex.codecogs.com/gif.latex?S) rises, there is high probability that the price of a call option will rise and the price of a put option will fall. If the stock price goes down, the reverse will most likely happen to the price of the calls and puts. Intrinsic value is the amount by which the strike price of an option is in the money. It is the portion of an option's price not lost due to the passage of time.


## Binomial Tree model <a name="Binomial"/>
In this model, consider a stock (with an initial price of ![S_0](https://latex.codecogs.com/gif.latex?S_0) undergoing a random walk. Over a time step ![delta_t](https://latex.codecogs.com/gif.latex?dt), the stock has a probability p of rising by a factor u, and a probability 1-p of  falling in price by a factor d. This is illustrated by the following diagram.

<img src="{{ site.url }}{{ site.baseurl }}/images/options/binomial.png"> 

Cox, Ross and Rubenstein (CRR) suggested a method for calculating p, u and d. Over a small period of time, the binomial model acts similarly to an asset that exists in a risk neutral world. This results in the following equation, which implies that the effective return of the binomial model (on the right-hand side) is equal to the risk-free rate:
![CRR](https://latex.codecogs.com/gif.latex?pu&plus;%281-p%29d%3De%5E%7Br%20dt%7D)
Additionally, the variance of a risk-neutral asset and an asset in a risk neutral world match. This gives the following equation.
![CRR2](https://latex.codecogs.com/gif.latex?pu%5E2&plus;%281-p%29d%5E2-e%5E%7B2rdt%7D%3D%5Csigma%5E2dt)
The CRR model suggests the following relationship between the upside and downside factors.
![CRR3](https://latex.codecogs.com/gif.latex?u%3D1/d)
Rearranging these equations gives the following equations for p, u and d.
![CRR4](https://latex.codecogs.com/gif.latex?p%3D%5Cfrac%7Be%5E%7Brdt%7D-d%7D%7Bu-d%7D)
![CRR5](https://latex.codecogs.com/gif.latex?u%3De%5E%7B%5Csigma%5Csqrt%20dt%7D)
![CRR6](https://latex.codecogs.com/gif.latex?d%3De%5E%7B-%5Csigma%5Csqrt%20dt%7D)
The values of p, u and d given by the CRR model means that the underlying initial asset price is symmetric for a multi-step binomial model.

``` Python



```