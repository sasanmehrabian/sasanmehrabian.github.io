---
layout: home
permalink: /libor/
title: "LIBOR Interest Rates Analysis"
author_profile: true
toc: true
---
## 1. Introduction
LIBOR, which stands for London Interbank Offered Rate, is the average interbank interest rate at which a selection of banks on the London money market are prepared to lend to one another. LIBOR comes in 7 maturities (from overnight to 12 months) and in 5 different currencies including the US dollar, the euro, the British pound, the Japanese yen, and the Swiss franc. The official LIBOR interest rates are announced once per working day at around 11:45 a.m. 

LIBOR is also the basis for consumer loans in countries around the world, so it impacts consumers just as much as it does financial institutions. The interest rates on various credit products such as credit cards, car loans, and adjustable rate mortgages fluctuate based on the interbank rate. This change in rate helps determine the ease of borrowing between banks and consumers.

In this project I will present some statistical analysis on the LIBOR interest rates for various CAD and USD maturities obtained from [FRED](https://fred.stlouisfed.org/) website.

## 2. Extract data

Here is the list of libraries that I will be using for this project:
``` r
library(quantmod) 
library(tidyr)
library(ggplot2)
library(corrplot)
library(fitdistrplus)
library(ggpubr)
library(VarianceGamma)
library(factoextra)
require(gridExtra)
```

In order to get the LIBOR IR I defined a function that requires the ticker of the maturity from FRED website and the date range. 
``` r
setDefaults(getSymbols, src="FRED")
"getSymbols.warning4.0"=FALSE

get_data <- function(ticker,date_range)
{
  t=getSymbols(as.character(ticker), env=.GlobalEnv, auto.assign = F)
  t=t[date_range]
  colnames(t) <- c("IR")  # change col name
  sum(is.na(t$IR))        # count the number of NA
  t= t[!is.na(t),]        # remove the NA rows
  return (t)
}  

### For this example I will be using data from 1998 to 2012
date_range='199801/201112'
#USD
USDON=get_data("USDONTD156N", date_range)
USD1M=get_data("USD1MTD156N", date_range)
USD3M=get_data("USD3MTD156N", date_range)
USD6M=get_data("USD6MTD156N", date_range)
USD9M=get_data("USD9MTD156N", date_range)
USD12M=get_data("USD12MD156N", date_range)

#CAD
CADON=get_data("CADONTD156N", date_range)
CAD1M=get_data("CAD1MTD156N", date_range)
CAD3M=get_data("CAD3MTD156N", date_range)
CAD6M=get_data("CAD6MTD156N", date_range)
CAD9M=get_data("CAD9MTD156N", date_range)
CAD12M=get_data("CAD12MD156N", date_range)



  
A=ggplot() + 
      geom_line(data = USDON, aes(x = index(USDON), y =USDON, col="USD", group=1), size=1.5) +
      geom_line(data = CADON, aes(x = index(CADON), y =CADON, col="CAD", group=1),size=1.5) +
      xlab('Date') +
      ylab('IR %')+
      ggtitle("Over Night Interest Rates")+
      theme(text = element_text(size=20))+
      theme(axis.text.y = element_text(size=15, angle = 90, face = "bold" , colour = "black"))+
      theme(axis.text.x = element_text(size=15, face= "bold", colour = 'black'))+
      theme(plot.title = element_text(size = 20, face = "bold"))+  
      theme(legend.title=element_blank())+
      theme(legend.position = c(0.9, 0.9))+
      theme(legend.background = element_rect(fill="lightblue", linetype="solid", colour ="darkblue"))
    
    
B=ggplot() + 
      geom_line(data = USD1M, aes(x = index(USD1M), y =USD1M, col="USD", group=1), size=1.5) +
      geom_line(data = CAD1M, aes(x = index(CAD1M), y =CAD1M, col="CAD", group=1),size=1.5) +
      xlab('Date') +
      ylab('IR %')+
      ggtitle("1 Month Interest Rates")+
      theme(text = element_text(size=20))+
      theme(axis.text.y = element_text(size=15, angle = 90, face = "bold" , colour = "black"))+
      theme(axis.text.x = element_text(size=15, face= "bold", colour = 'black'))+
      theme(plot.title = element_text(size = 20, face = "bold"))+  
      theme(legend.title=element_blank())+
      theme(legend.position = c(0.9, 0.9))+
      theme(legend.background = element_rect(fill="lightblue", linetype="solid", colour ="darkblue"))
    
    
C=ggplot() + 
      geom_line(data = USD6M, aes(x = index(USD6M), y =USD6M, col="USD", group=1), size=1.5) +
      geom_line(data = CAD6M, aes(x = index(CAD6M), y =CAD6M, col="CAD", group=1),size=1.5) +
      xlab('Date') +
      ylab('IR %')+
      ggtitle("6 Months Interest Rates")+
      theme(text = element_text(size=20))+
      theme(axis.text.y = element_text(size=15, angle = 90, face = "bold" , colour = "black"))+
      theme(axis.text.x = element_text(size=15, face= "bold", colour = 'black'))+
      theme(plot.title = element_text(size = 20, face = "bold"))+  
      theme(legend.title=element_blank())+
      theme(legend.position = c(0.9, 0.9))+
      theme(legend.background = element_rect(fill="lightblue", linetype="solid", colour ="darkblue"))
    
    
D=ggplot() + 
      geom_line(data = USD12M, aes(x = index(USD12M), y =USD12M, col="USD", group=1), size=1.5) +
      geom_line(data = CAD12M, aes(x = index(CAD12M), y =CAD12M, col="CAD", group=1),size=1.5) +
      xlab('Date') +
      ylab('IR %')+
      ggtitle("12 Months Interest Rates")+
      theme(text = element_text(size=20))+
      theme(axis.text.y = element_text(size=15, angle = 90, face = "bold" , colour = "black"))+
      theme(axis.text.x = element_text(size=15, face= "bold", colour = 'black'))+
      theme(plot.title = element_text(size = 20, face = "bold"))+  
      theme(legend.title=element_blank())+
      theme(legend.position = c(0.9, 0.9))+
      theme(legend.background = element_rect(fill="lightblue", linetype="solid", colour ="darkblue"))
    
ggarrange(A,B,C,D)
```
dsds
<img src="{{ site.url }}{{ site.baseurl }}/images/LIBOR/IR.jpeg" alt="my description">