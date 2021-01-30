library(jsonlite)

#' get_secrets
#'
#' @return map of keys by name to their values
#' @export
#'
#' @examples
get_secrets <- function() {
    path <- "./secrets.txt"
    if (!file.exists(path)) {
        stop("Can't find secret file: '", path, "'")
    }

    jsonlite::read_json(path)
}
