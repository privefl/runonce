################################################################################

url_basename <- function(url) {
  urltools::url_decode(basename(urltools::path(url)))
}

################################################################################

#' Download once
#'
#' Download file if does not exist yet.
#'
#' @param url URL of file to be downloaded.
#' @param dir Directory where to download the file.
#' @param fname Base name of the downloaded file (`dir` will be prefixed).
#' @param overwrite Whether to overwrite? Default is `FALSE`.
#' @param mode See parameter of [download.file()].
#'   Default of "wb" seems useful for Windows systems.
#' @param timeout Number of seconds before timeout. Default is 300 (5 minutes),
#'   or `getOption("timeout")` when larger.
#' @inheritDotParams utils::download.file -url -destfile -mode
#'
#' @return Path to the downloaded (or existing) file.
#' @export
#'
#' @examples
#' download_file("https://github.com/privefl.png")
#' download_file("https://github.com/privefl.png")
#' download_file("https://github.com/privefl.png", overwrite = TRUE)
#'
download_file <- function(url,
                          dir = tempdir(),
                          fname = url_basename(url),
                          overwrite = FALSE,
                          mode = "wb",
                          timeout = max(300, getOption("timeout")),
                          ...) {

  bigassertr::assert_dir(dir)
  fname <- file.path(dir, fname)

  if (overwrite || !file.exists(fname)) {

    opt_saved <- options(timeout = timeout)
    on.exit(options(opt_saved), add = TRUE)  # reset to as before

    utils::download.file(url, destfile = fname, mode = mode, ...)
  }

  fname
}

################################################################################
