#' get_vrd_api
#'
#' @return A string that is your VRD_API key
#' @export
#'
#' @examples
get_vrd_api <- function() {
    x <- Sys.getenv("VRD_API")
    if (x == "") {
        stop("You must set your VRD_API with `Sys.setenv(VRD_API = 'xxxxx')`")
    }
    return(x)
}
