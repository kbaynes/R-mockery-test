Depth0.myFunction <- function() {
  print(">>> Depth0.myFunction")
  ret <- Depth1.myFunction()
}

Depth1.myFunction <- function() {
  print(">>> Depth1.myFunction")
  ret <- Depth2.myFunction()
}

Depth2.myFunction <- function() {
  print(">>> Depth2.myFunction")
  ret <- Depth3.myFunctionA()
  ret <- Depth3.myFunctionB()
}

Depth3.myFunctionA <- function() {
  print(">>> Depth3.myFunctionA")
  return("D3.mFA")
}

Depth3.myFunctionB <- function() {
  print(">>> Depth3.myFunctionB")
  return("D3.mFB")
}
