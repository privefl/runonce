#' Cache result
#'
#' Cache the result of `code` in an RDS file.
#'
#' @inheritParams runonce-package
#' @param code Code to run. Do not forget to wrap it with `{ }`. Also, beware
#'   that it is your job to make sure your code and data has not changed. If this
#'   is the case, you need to remove the `file` storing the outdated result.
#' @param file File path where the result is stored. Should have extension `rds`.
#'
#' @return The evaluation of `code` the first time, the content of `file` otherwise.
#' @export
#'
#' @examples
#' # Prepare some temporary file
#' tmp <- tempfile(fileext = ".rds")
#'
#' # Run once because result does not exist yet
#' save_run({
#'   Sys.sleep(2)
#'   1
#' }, file = tmp)
#'
#' # Skip run because the result already exists
#' # (but still output how long it took the first time)
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

    res <- readRDS(file)

    time <- attr(res, "RUNONCE_TIMING")
    attr(res, "RUNONCE_TIMING") <- NULL

  } else {

    time <- system.time(
      res <- code
    )

    saveRDS(structure(res, RUNONCE_TIMING = time), file)

  }

  if (timing && !is.null(time)) print(time)

  res
}
