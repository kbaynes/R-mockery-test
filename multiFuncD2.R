Depth0.myFunction <- function() {
  print(">>> Depth0.myFunction")
  ret <- Depth1.myFunction()
}

Depth1.myFunction <- function() {
  print(">>> Depth1.myFunction")
  ret <- Depth2.myFunctionA()
  ret <- Depth2.myFunctionB()
}

Depth2.myFunctionA <- function() {
  print(">>> Depth2.myFunctionA")
  return("D2.mFA")
}

Depth2.myFunctionB <- function() {
  print(">>> Depth2.myFunctionB")
  return("D2.mFB")
}
