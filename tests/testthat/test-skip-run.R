context("SKIP_RUN")

test_that("skip_run() works", {

  expect_error(
    skip_run_if({
      Sys.sleep(2)
      write.table(iris, tmp)
    }),
    "Please specify one of 'cond' or 'files' parameters."
  )

  tmp <- tempfile(fileext = ".rds")

  time1 <- system.time(
    expect_null(
      skip_run_if({
        Sys.sleep(2)
        write.table(iris, tmp)
      }, cond = file.exists(tmp))
    )
  )
  expect_gte(time1[[3]], 2)
  size1 <- file.size(tmp)

  time2 <- system.time(
    expect_null(
      skip_run_if({
        Sys.sleep(2)
        write.table(cbind(iris, iris), tmp)
      }, cond = file.exists(tmp))
    )
  )
  expect_lte(time2[[3]], 0.1)
  expect_identical(file.size(tmp), size1)


  tmp2 <- tempfile(fileext = ".rds")

  time3 <- system.time(
    expect_null(
      skip_run_if({
        Sys.sleep(2)
        write.table(cbind(iris, iris), tmp)
      }, files = tmp)
    )
  )
  expect_lte(time3[[3]], 0.1)

  time4 <- system.time(
    expect_null(
      skip_run_if({
        Sys.sleep(2)
        write.table(cbind(iris, iris), tmp)
      }, files = c(tmp, tmp))
    )
  )
  expect_lte(time4[[3]], 0.1)

  time5 <- system.time(
    expect_null(
      skip_run_if({
        Sys.sleep(2)
        write.table(cbind(iris, iris), tmp)
      }, files = c(tmp, tmp2))
    )
  )
  expect_gte(time5[[3]], 2)
  expect_lte(file.size(tmp), 2 * size1)

})
