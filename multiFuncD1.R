Depth0.myFunction <- function() {
  print(">>> Depth0.myFunction")
  ret <- Depth1.myFunctionA()
  ret <- Depth1.myFunctionB()
}

Depth1.myFunctionA <- function() {
  print(">>> Depth1.myFunctionA")
  return("D1.mFA")
}

Depth1.myFunctionB <- function() {
  print(">>> Depth1.myFunctionB")
  return("D1.mFB")
}