#' Skip code
#'
#' Skip code if all conditions are fulfilled.
#' The code should not return anything.
#'
#' @inheritParams runonce-package
#' @param cond Condition to be fulfilled to skip running `code`.
#'   Default is `NULL` (not used).
#'   Should evaluate to either `TRUE` or `FALSE` otherwise.
#' @param files Character vector of file path(s). Default is `NULL` (not used).
#'   This function checks if all these files exist, and if they all do exist,
#'   it skips running `code`.
#'
#' @return `NULL`, invisibly.
#' @export
#'
#' @examples
#' # Prepare some temporary file
#' tmp <- tempfile(fileext = ".txt")
#'
#' # Run once because file does not exist yet
#' skip_run_if({
#'   Sys.sleep(2)
#'   write.table(iris, tmp)
#' }, cond = file.exists(tmp))
#'
#' # Skip run because `cond` is `TRUE`
#' skip_run_if({
#'   Sys.sleep(2)
#'   write.table(iris, tmp)
#' }, cond = file.exists(tmp))
#'
#' # Skip run because file exists
#' skip_run_if({
#'   Sys.sleep(2)
#'   write.table(iris, tmp)
#' }, files = tmp)
#'
skip_run_if <- function(code, cond = NULL, files = NULL, timing = TRUE) {

  if (is.null(cond)) {
    cond <- TRUE
    if (is.null(files))
      stop2("Please specify one of 'cond' or 'files' parameters.")
  } else {
    if (!isTRUE(cond) && !isTRUE(!cond))
      stop2("'cond' should be either TRUE or FALSE.")
  }

  cond_files <- is.null(files) || all(file.exists(path.expand(files)))

  if (cond && cond_files) {

    # skip running code

  } else {

    time <- system.time(code)
    if (timing) print(time)

  }

  invisible(NULL)
}
