# R-mockery-test

## Abstract

There appears to be a bug with r-lib/mockery `expect_called()` and `stub()` for multiple functions at depth >=2. `stub()` and `expect_called()` works as expected for multiple functions at a depth of 1. At depth >= 2, the first stubbed/mocked function (A) is called, but the subsequent stubbed/mocked functions (B,C,...) are not called, instead the actual function is called. Either there is a bug, or I do not understand something. :-)

### Files Overview

There are three test files in the project (`test_*.R`), which test the three `multiFuncD*.R` scripts. `test_multiFuncD1.R` tests `mockery::stub(f,'g',m,depth=1)`, and `test*D2` tests `depth=2` and so on.

### Observed Behavior

#### test_multiFuncD1.R

All tests pass, even stubbing multiple functions at depth=1

#### test_multiFuncD2.R

All tests pass, except the last test which stubs multiple functions at depth=2.

```
mD2A <- mock(TRUE)
mD2B <- mock(TRUE)
stub(Depth0.myFunction,'Depth2.myFunctionA',mD2A,depth=2)
stub(Depth0.myFunction,'Depth2.myFunctionB',mD2B,depth=2)
Depth0.myFunction()
expect_called(mD2A,1)
expect_called(mD2B,1)
```

The second mock/stub (`mD2B` for `Depth2.myFunctionB`) is created, but fails to pass the `expect_called()` check and the internal print() is called from within `Depth2.myFunctionB`.
This will happen for any additional functions (`Depth2.myFunctionC`, etc) at this depth and greater.

#### test_multiFuncD3.R

All tests pass, except the last test which stubs multiple functions at depth=3. This test shows the same behavior as depth=2, but I have not tested deeper than three.

### Test Outputs

#### test_multiFuncD1.R

```
> source('~/Documents/MyGitRepos/GitHub/R-mockery-test/test_multiFuncD1.R')
[1] "can stub a single function at default depth (1)"
[1] ">>> Depth0.myFunction"
[1] ">>> Depth1.myFunctionB"
Test passed 🌈
[1] "can stub a single function at depth=1"
[1] ">>> Depth0.myFunction"
[1] ">>> Depth1.myFunctionB"
Test passed 🥳
[1] "can stub multiple functions at depth=1"
[1] ">>> Depth0.myFunction"
Test passed 🥳
```

#### test_multiFuncD2.R

Here we see that the internal `print()` of `Depth2.myFunctionA` has not been called, but the second mocked function `Depth2.myFunctionB` is called and prints, and `expect_called()` fails for that mock.

```
> source('~/Documents/MyGitRepos/GitHub/R-mockery-test/test_multiFuncD2.R')
[1] "can stub a single function at default depth (1)"
[1] ">>> Depth0.myFunction"
Test passed 😀
[1] "can stub a single function at depth=1"
[1] ">>> Depth0.myFunction"
Test passed 🥳
[1] "can stub a single function at depth=2"
[1] ">>> Depth0.myFunction"
[1] ">>> Depth1.myFunction"
[1] ">>> Depth2.myFunctionB"
Test passed 🎉
[1] "can stub multiple functions at depth=2"
[1] ">>> Depth0.myFunction"
[1] ">>> Depth1.myFunction"
[1] ">>> Depth2.myFunctionB"
── Failure (test_multiFuncD2.R:38:5): Test Multiple Functions at depth=2: can stub multiple functions at depth=2 ─────────────────────
mock object has not been called 1 time
```

#### test_multiFuncD3.R

This test duplicates the previous one, but at a greater depth. Here we see that the internal `print()` of `Depth3.myFunctionA` has not been called, but the second mocked function `Depth3.myFunctionB` is called and prints, and `expect_called()` fails for that mock.

```
> source('~/Documents/MyGitRepos/GitHub/R-mockery-test/test_multiFuncD3.R')
[1] "can stub a single function at default depth (1)"
[1] ">>> Depth0.myFunction"
Test passed 🥳
[1] "can stub a single function at depth=1"
[1] ">>> Depth0.myFunction"
Test passed 🌈
[1] "can stub a single function at depth=2"
[1] ">>> Depth0.myFunction"
[1] ">>> Depth1.myFunction"
Test passed 🥇
[1] "can stub a single function at depth=3"
[1] ">>> Depth0.myFunction"
[1] ">>> Depth1.myFunction"
[1] ">>> Depth2.myFunction"
[1] ">>> Depth3.myFunctionB"
Test passed 🌈
[1] "can stub multiple functions at depth=3"
[1] ">>> Depth0.myFunction"
[1] ">>> Depth1.myFunction"
[1] ">>> Depth2.myFunction"
[1] ">>> Depth3.myFunctionB"
── Failure (test_multiFuncD3.R:46:5): Test Multiple Functions at depth=3: can stub multiple functions at depth=3 ─────────────────────
mock object has not been called 1 time
```
