test_that("rm_dl_raw() works", {
  expect_identical(rm_dl_raw("aaa.txt"),       "aaa.txt")
  expect_identical(rm_dl_raw("aaa.txt?dl=1"),  "aaa.txt")
  expect_identical(rm_dl_raw("aaa.txt?dl=0"),  "aaa.txt")
  expect_identical(rm_dl_raw("aaa.txt?raw=1"), "aaa.txt")
  expect_identical(rm_dl_raw("aaa.txt?raw=0"), "aaa.txt")
})

test_that("download_file() works", {

  myurl <- "https://github.com/privefl.png"
  png <- download_file(myurl, quiet = TRUE)
  expect_identical(png, file.path(tempdir(), "privefl.png"))
  mtime <- file.info(png)[["mtime"]]

  expect_identical(download_file(myurl), png)
  expect_identical(file.info(png)[["mtime"]], mtime)  # file was not modified

  Sys.sleep(2)
  download_file(myurl, overwrite = TRUE, quiet = TRUE)
  expect_gt(file.info(png)[["mtime"]], mtime)  # file was modified
})
