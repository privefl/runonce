context("SAVE_RUN")

test_that("save_run() works", {

  tmp <- tempfile(fileext = ".rds")

  expect_output({
    res1 <- save_run({
      Sys.sleep(2)
      1
    }, file = tmp)
  })
  expect_identical(res1, 1)

  time2 <- system.time(
    res2 <- save_run({
      Sys.sleep(2)
      2
    }, file = tmp)
  )
  expect_lte(time2[[3]], 0.1)
  expect_identical(res2, 1)


  tmp2 <- tempfile(fileext = ".rds")

  expect_failure(expect_output({
    res3 <- save_run({
      Sys.sleep(2)
      3
    }, file = tmp2, timing = FALSE)
  }))
  expect_identical(res3, 3)
})
