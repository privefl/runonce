#' Cache result
#'
#' Cache the result of `code` in an RDS file.
#'
#' @inheritParams runonce-package
#' @param code Code to run. Do not forget to wrap it with `{ }`. Also, beware
#'   that **it is your job to make sure your code and data has not changed**. If
#'   this is the case, you need to remove the `file` storing the outdated result.
#' @param file File path where the result is stored. Should have extension `rds`.
#' @param output Whether to print any message output of `code`? Default is `TRUE`.
#'
#' @return The evaluation of `code` the first time, the content of `file` otherwise.
#' @export
#'
#' @examples
#' # Prepare some temporary file
#' tmp <- tempfile(fileext = ".rds")
#'
#' # Run once because result does not exist yet
#' save_run({ Sys.sleep(1); 1 }, file = tmp)
#'
#' # Skip run because the result already exists
#' # (but still output how long it took the first time)
#' Sys.sleep(1); save_run({ Sys.sleep(1); 1 }, file = tmp)
#'
save_run <- function(code, file, timing = TRUE, output = TRUE) {

  file <- path.expand(file)
  bigassertr::assert_ext(file, "rds")
  bigassertr::assert_dir(dirname(file))

  if (file.exists(file)) {

    res <- readRDS(file)

    runtime <- attr(res, "RUNONCE_TIMING"); attr(res, "RUNONCE_TIMING") <- NULL
    time    <- attr(res, "RUNONCE_TIME");   attr(res, "RUNONCE_TIME")   <- NULL
    out     <- attr(res, "RUNONCE_OUTPUT"); attr(res, "RUNONCE_OUTPUT") <- NULL

  } else {

    runtime <- system.time(
      out <- utils::capture.output(
        res <- code
      )
    )
    time <- Sys.time()

    saveRDS(file = file,
            structure(res,
                      RUNONCE_TIMING = runtime,
                      RUNONCE_TIME   = time,
                      RUNONCE_OUTPUT = out))

  }

  if (output && length(out) > 0) writeLines(out)
  if (timing && !is.null(runtime)) print(runtime)
  if (timing && !is.null(time))
    cat("Code finished running at", format(time, "%Y-%m-%d %H:%M:%S %Z"), "\n")

  res
}
