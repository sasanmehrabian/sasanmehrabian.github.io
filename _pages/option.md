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


## Binomial Tree model < name="Binomial"/>
In this model, consider a stock (with an initial price of ![S_0](https://latex.codecogs.com/gif.latex?S_0) undergoing a random walk. Over a time step ![delta_t](https://latex.codecogs.com/gif.latex?dt), the stock has a probability p of rising by a factor u, and a probability 1-p of  falling in price by a factor d. This is illustrated by the following diagram.
<img src="{{ site.url }}{{ site.baseurl }}/images/options/Binomial.png"> 

``` Python



```