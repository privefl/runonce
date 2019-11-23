#' Cache result
#'
#' @param code Code to run. Do not forget to wrap it witt `{ }`.
#' @param file File where the result is stored. Should have extension `rds`.
#' @param timing Whether to print timing of running code? Default is `TRUE`.
#'
#' @return The evaluation of `code` the first time, the content of `file` otherwise.
#' @export
#'
#' @examples
#' tmp <- tempfile(fileext = ".rds")
#'
#' save_run({
#'   Sys.sleep(2)
#'   1
#' }, file = tmp)
#'
#' save_run({
#'   Sys.sleep(2)
#'   1
#' }, file = tmp)
#'
save_run <- function(code, file, timing = TRUE) {

  file <- path.expand(file)
  bigassertr::assert_ext(file, "rds")
  bigassertr::assert_dir(dirname(file))

  if (file.exists(file)) {

    readRDS(file)

  } else {

    time <- system.time(res <- code)
    if (timing) print(time)

    saveRDS(res, file)
    res

  }
}
