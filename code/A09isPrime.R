# # source(paste0(.z$RX, "A09isPrime", ".R")) ==================================#

## ---- A09A-isPrime ----
f_isPrime <- function(x) {
  # #Check if the number is Prime
  if(!is.integer(x)) {
    cat("Error! Integer required. \n")
    stop()
  } else if(x <= 0L) {
    cat("Error! Positive Integer required. \n")
    stop()
  } else if(x > 2147483647L) {
    cat(paste0("Doubles are stored as approximation. Prime will not be calculated for value higher than '2147483647' \n"))
    stop()
  }
  # #However, this checks the number against ALL Smaller values including non-primes
  if(x == 2L || all(x %% 2L:ceiling(sqrt(x)) != 0)) {
    # # "seq.int(3, ceiling(sqrt(x)), 2)" is slower
    return(TRUE)
  } else {
    ## (any(x %% 2L:ceiling(sqrt(x)) == 0))
    ## (any(x %% seq.int(3, ceiling(sqrt(x)), 2) == 0))
    ## NOTE Further, if sequence starts from 3, add 2 also as a Prime Number
    return(FALSE)
  }
}

## ---- A09B-isPrimeV ----
# #Vectorise Version
f_isPrimeV <- Vectorize(f_isPrime)

## ---- A09C-isPrimeC ----
# #Compiled Version
f_isPrimeC <- cmpfun(f_isPrime)

## ---- A09D-getPrimeUpto ----
f_getPrimeUpto <- function(x){
  # #Get a Vector of Primes upto the given Number (Max. 524287)
  if(x < 2) {
    print("NOT ALLOWED!")
    return(NULL)
  } else if(x > 524287){
    print("Sadly, beyond this number it is difficult to generate the List of Primes!")
    return(NULL)
  }
  y <- 2:x
  i <- 1
  while (y[i] <= sqrt(x)) {
    y <-  y[y %% y[i] != 0 | y == y[i]]
    i <- i+1
  }
  return(y)
}
