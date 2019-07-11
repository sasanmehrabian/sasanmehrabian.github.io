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

There are several models used for pricing options. Binomial tree and Black-Scholes are the most common models. The current stock price ![S](https://latex.codecogs.com/gif.latex?S), the option strike price ![K](https://latex.codecogs.com/gif.latex?K), Maturity lenth ![T](https://latex.codecogs.com/gif.latex?T), risk-free interest rate ![r](https://latex.codecogs.com/gif.latex?r), volatility ![sigma](https://latex.codecogs.com/gif.latex?%5Csigma) are common factors for both models that determine the price of the option. 

For instance, if the stock price ![S](https://latex.codecogs.com/gif.latex?S) rises, there is high probability that the price of a call option will rise and the price of a put option will fall. If the stock price goes down, the reverse will most likely happen to the price of the calls and puts. Intrinsic value is the amount by which the strike price of an option is in the money. It is the portion of an option's price not lost due to the passage of time.


## Binomial Tree model <a name="Binomial"/>
[Return to Top](#toc)
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

We will consider the following payoff functions at maturity time. 

For call option: ![call](https://latex.codecogs.com/gif.latex?C%3Dmax%280%2C%20S-K%29)

For put option: ![put](https://latex.codecogs.com/gif.latex?P%3Dmax%280%2C%20K-S%29)

Also, the value of the option at each node can be computed using the following equation:

![option](https://latex.codecogs.com/gif.latex?C_%7Bt-dt%2Ci%7D%3De%5E%7B-rdt%7D%5Cbigg%28pC_%7Bt%2Ci%7D&plus;%281-p%29C_%7Bt%2Ci&plus;1%7D%20%5Cbigg%29)

The above equation implies that we need to initially calculate the option price at maturity time (last node), and then move backwards to calculate the option price of each node until we reach today's date (first node). The code for such algorithm in R is given below:

``` r
binomial_tree <- function(N,T,S,K,r,sigma, option){
  # N: Number of nodes e.g. 100
  # T: Maturity time in days e.g. 31
  # S: Stock price
  # K: Option Strike price
  # r: risk-free interest rate
  # sigma: Volatility 
  # option: Type of option "call" or "put"

  # convert the maturity length into years
  T = T / 365
  dt = T/N
  u = exp(sigma*sqrt(dt))
  d = 1/u 
  p = (exp(r*dt) - d)/(u-d)
  # Create a zero matrix for Stock price
  M = matrix( rep( 0, len=(N+1)*(N+1)), nrow = N+1)
  # Initialize the matrix with the value S
  M[1,1] = S
  
  b = 2
  up_N = 0 
  down_N = 0
  for (i in seq(2,N + 1)){
    down_N = 0
    up_N = i - 1
    for (j in seq(1, b)){
      M[j,i] = S*u**(up_N)*d**(down_N)
      up_N = up_N - 1
      down_N = down_N + 1
    }
    b = b + 1
  }
  # Create a zero matrix for the option price
  O = matrix( rep( 0, len=(N+1)*(N+1)), nrow = N+1)
  # calculate the option value at expiration date
  if (option == 'call'){
    for (i in seq(1, N + 1)){
      O[i, N + 1] = max(0, M[i, N + 1]-K)
    }
  }
  if (option == 'put'){
    for (i in seq(1, N + 1)){
      O[i, N + 1] = max(K-M[i, N + 1], 0)
    }
  }
  for (i in seq(N, 1, -1)){
    for (j in seq(1, i)){
      O[j, i] = exp(-r*dt) * (p*O[j, i+1]+(1-p)*O[j+1, i+1])
    }
  }
  return(O[1, 1])
}
```


## Black-Scholes model <a name="Black"/>
[Return to Top](#toc)

The Black-Scholes model is used to determine the price of a European call option, which simply means that the option can only be exercised on the expiration date. Black-Scholes pricing model is largely used by option traders who buy options that are priced under the formula calculated value, and sell options that are priced higher than the Black-Schole calculated value.

The formula for calculating the option price is:
![call_b](https://latex.codecogs.com/gif.latex?C%3De%5E%7B-r%28T-t%29%7D%5Cbigg%5BN%28d_1%29S_te%5E%7B%28r-q%29%28T-t%29%7D-N%28d_2%29Ke%5E%7B-r%28T-t%29%7D%20%5Cbigg%5D)
![put_b](https://latex.codecogs.com/gif.latex?P%3De%5E%7B-r%28T-t%29%7D%5Cbigg%5BN%28-d_2%29Ke%5E%7B-r%28T-t%29%7D-N%28-d_1%29S_te%5E%7B%28r-q%29%28T-t%29%7D%20%5Cbigg%5D)

![d1](https://latex.codecogs.com/gif.latex?d_1%3D%5Cfrac%7B1%7D%7B%5Csigma%5Csqrt%28T-t%29%7D%20%5Cbigg%5Bln%5Cbigg%28%5Cfrac%7BS_t%7D%7BK%7D%5Cbigg%29&plus;%5Cbigg%28r-q&plus;%5Cfrac%7B%5Csigma%5E2%7D%7B2%7D%20%5Cbigg%29%28T-t%29%20%5Cbigg%5D)

![d2](https://latex.codecogs.com/gif.latex?d_2%3Dd_1-%5Csigma%5Csqrt%28T-t%29)

The R code for Black-Scholes is:
``` r
black_scholes <- function(S, K, T, r,q, sigma, option){
  # S: Stock price
  # K: Option Strike price
  # T: Maturity time in days e.g. 31
  # r: risk-free interest rate
  # q: dividend rate
  # sigma: Volatility 
  # option: Type of option "call" or "put"
  
  #convert the maturity length into years
  T = T / 365
  d1 = (log(S / K) + (r - q + 0.5 * sigma ** 2) * T) / (sigma * sqrt(T))
  d2 = (log(S / K) + (r - q - 0.5 * sigma ** 2) * T) / (sigma * sqrt(T))
  
  if (option == 'call'){
    result = (S * pnorm(d1, 0.0, 1.0) - K * exp(-r * T) * pnorm(d2, 0.0, 1.0))
  }
  if (option == 'put'){
    result = (K * exp(-r * T) * pnorm(-d2, 0.0, 1.0) - S * pnorm(-d1, 0.0, 1.0))
  }
  return(result)
}
```

## Conclusion with example: <a name="Conclusion"/>
[Return to Top](#toc)

As an example, I will get the price of the call option for APPLE Inc. (AAPL) using both models. The current stock price ![S](https://latex.codecogs.com/gif.latex?S), The option strike price ![K](https://latex.codecogs.com/gif.latex?K), and the volatility ![sigma](https://latex.codecogs.com/gif.latex?%5Csigma) for a 35 days maturity time (Expiration date Aug 16, 2019) obtained from [YAHOO finance](https://finance.yahoo.com/quote/AAPL/options?p=AAPL&date=1565913600) website on July 11, 2019 are 201.75, 200, and 26.22%, respectively. The Bid and Ask price shown on YAHOO is between 7.5 and 7.6 after market close.  If we assume that the risk-free interest rate is 1% and there are no dividends, the option call price based on the Black-Scholes model is 7.72. Assuming that we choose 100 nodes for the Binomial Tree, the option call price is estimated at 7.73.
``` r
N = 100
T = 35
S = 201.75
K = 200
sigma = 0.27
r = 0.01
q = 0
option = 'call'
black_scholes(S, K, T, r, q, sigma, option)
binomial_tree(N, T, S, K, r, sigma, option)
```
It can be seen that the binomial pricing method and the black-scholes pricing method produce almost identical results when the dividend yeild for the black sholes pricing method is equal to zero. Given the nature of the code it is more efficient to use the black-scholes method of calculating the price of options becuase the binomial tress require 100 iterations which takes up more processing power and takes longer. With iterations less than 100 the bionomial tress method was seen to be less accurate. When dividends are factored into the black-scholes method it can be seen that the price of the options changes slightly.