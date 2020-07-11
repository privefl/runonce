# Used e.g. after dropbox urls
rm_dl_raw <- function(url) {
  sub("\\?raw.+$", "",
      sub("\\?dl.+$", "",
          url))
}

#' Download
#'
#' Download file if does not exist yet.
#'
#' @param url URL of file to be downloaded.
#' @param dir Directory where to download the file.
#' @param fname Base name of the downloaded file (`dir` will be prefixed).
#' @param overwrite Whether to overwrite? Default is `FALSE`.
#' @param mode See parameter of [download.file()].
#'   Default of "wb" seems useful for Windows systems.
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
download_file <- function(url, dir = tempdir(),
                          fname = basename(rm_dl_raw(url)),
                          overwrite = FALSE,
                          mode = "wb",
                          ...) {

  bigassertr::assert_dir(dir)
  fname <- file.path(dir, fname)

  if (overwrite || !file.exists(fname))
    utils::download.file(url, destfile = fname, mode = mode, ...)

  fname
}
