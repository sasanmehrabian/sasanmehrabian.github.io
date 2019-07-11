rm(list=ls())
cat("\f")
dev.off()

# N: Number of nodes
# S: Stock price
# K: Option Strike price
# T: Maturity time in days e.g. 31
# r: risk-free interest rate
# q: dividend rate
# sigma: Volatility 
# option: Type of option "call" or "put"


black_scholes <- function(S, K, T, r,q, sigma, option){
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



binomial_tree <- function(N,T,S,K,r,sigma, option){
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
  for (i in seq(2,N+1)){
    down_N=0
    up_N=i-1
    for (j in seq(1,b)){
      M[j,i] = S*u**(up_N)*d**(down_N)
      up_N = up_N - 1
      down_N = down_N + 1
    }
    b=b+1
  }
  # Create a zero matrix for the option price
  O = matrix( rep( 0, len=(N+1)*(N+1)), nrow = N+1)
  # calculate the option value at expiration date
  if (option == 'call'){
    for (i in seq(1, N+1)){
      O[i,N+1] = max(0, M[i,N+1]-K)
    }
  }
  if (option == 'put'){
    for (i in seq(1, N+1)){
      O[i,N+1] = max(K-M[i,N+1],0)
    }
  }
  for (i in seq(N,1,-1)){
    for (j in seq(1, i)){
      O[j,i] = exp(-r*dt) * (p*O[j,i+1]+(1-p)*O[j+1,i+1])
    }
  }
  return( O[1,1])
}



N=100
T=35
S=201.75
K=200
sigma=0.27
r=0.01
option='call'
q=0.015


binomial_tree(N,T,S,K,r,sigma, option)  
black_scholes(S, K, T, r,q, sigma, option)


#N = as.integer( readline("Enter the number of nodes: ") )
#T = as.numeric( readline("Enter the maturity length in days (e.g. 30): ") )
#S = as.numeric( readline("Enter the Stock price: ") ) 
#K = as.numeric( readline("Enter the option price: ") )
#r = as.numeric( readline("Enter the risk free rate (e.g. 0.10): ") )
#sigma = as.numeric( readline("Enter the volatility: "))
#option = readline( "Enter the type of option (call or put): ")
#q = as.numeric( readline("Enter the dividend yield: ") )
