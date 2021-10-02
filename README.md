<!-- badges: start -->
[![R build status](https://github.com/privefl/runonce/workflows/R-CMD-check/badge.svg)](https://github.com/privefl/runonce)
[![Codecov test coverage](https://codecov.io/gh/privefl/runonce/branch/master/graph/badge.svg)](https://codecov.io/gh/privefl/runonce?branch=master)
<!-- badges: end -->

# runonce

Run once and save result. Then, just read the result.

## Code example

```r
tmp <- tempfile(fileext = ".rds")

save_run({
  Sys.sleep(2)
  1
}, file = tmp)

save_run({
  Sys.sleep(2)
  1
}, file = tmp)
```
