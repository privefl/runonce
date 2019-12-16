#' Cache result
#'
#' @inheritParams runonce-package
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
#' # Skip run because result exists
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
