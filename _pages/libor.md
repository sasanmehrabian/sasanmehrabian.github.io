---
layout: home
permalink: /libor/
title: "LIBOR Interest Rates Analysis"
author_profile: true
toc: true
---

R code block
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
  
date_range='198601/201912'
{
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
 
}

```