#' Count of recalls searching by make or manufacturer
#'
#' Returns the count of recalls in the Vehicle Recalls Database based on a
#' make or manufacturer search term.
#'
#' @details
#' Queries the Vehicle Recalls Database API by make or manufacturer and returns
#' the count of recalls in the database. The year range of the search can be
#' specified and is based on the manufactured year and not the year a recall
#' occurred.
#'
#' An API key is required to run the function and query the Vehicle Recalls
#' Database. The key can be acquired at
#' \url{https://tc.api.canada.ca/en/detail?api=VRDB}.
#'
#' The API key can be set in the environment using
#' \code{Sys.setenv(VRD_API = 'your_API_key_here')} and will be used by the
#' function, or can be passed into the function using the \code{api_key}
#' argument.
#'
#' @param make List of make or manufacturer names.
#' @param manufacturer Logical; if TRUE, manufacturer is searched on instead
#' of make.
#' @param start_year Start of year range (optional).
#' @param end_year End of year range (optional).
#' @param api_key API access key to use, if not set in environment.
#'
#' @return A tibble providing the count of recalls from the Vehicle Recalls.
#' @export
#'
#' @examples
#' \dontrun{
#' count_recall_by_make("Nissan")
#' count_recall_by_make(c("Mazda", "Toyota"), start_year = 2008)
#' API_KEY <- "xxxxxxxxxxx"
#' count_recall_by_make("Maz", end_year = 2000, api_key = API_KEY)
#' }
count_recall_by_make <- function(make, manufacturer = FALSE, start_year = NULL,
                                 end_year = NULL, api_key = NULL) {

  # create multiple requests from input list
  input_request <- paste(make, collapse = "|")

  # format the url string
  if (manufacturer) {
    url_ <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall/manufacturer-name/"
  } else {
    url_ <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall/make-name/"
  }

  url_ <- paste(url_, input_request, sep = "")

  # append year range criteria to url if input by user
  if (!is.null(start_year) | !is.null(end_year)) {

    # add start or end year if value one of the values is NULL
    if (is.null(start_year)) start_year <- 1900
    if (is.null(end_year)) end_year <- 2100

    year_range <- paste(toString(start_year), toString(end_year), sep = "-")
    url_ <- paste(url_, "/year-range/", year_range, sep = "")
  }

  # add count to url
  url_ <- paste(url_, "/count", sep = "")

  # API call, returns class vrd_api
  api_output <- call_vrd_api(url_, make, api_key = api_key)

  # convert content to a dataframe
  contents_df <- clean_vrd_api(api_output)

  # outputs dataframe
  contents_df
}

#' Count of recalls searching by model
#'
#' Returns the count of recalls in the Vehicle Recalls Database based on a
#' model search term.
#'
#' @details
#' Queries the Vehicle Recalls Database API by model and returns the count of
#' recalls in the database. The year range of the search can be specified and
#' is based on the manufactured year and not the year a recall occurred.
#'
#' An API key is required to run the function and query the Vehicle Recalls
#' Database. The key can be acquired at
#' \url{https://tc.api.canada.ca/en/detail?api=VRDB}.
#'
#' The API key can be set in the environment using
#' \code{Sys.setenv(VRD_API = 'your_API_key_here')} and will be used by the
#' function, or can be passed into the function using the \code{api_key}
#' argument.
#'
#' @param model List of model names.
#' @param start_year Start of year range (optional).
#' @param end_year End of year range (optional).
#' @param api_key API access key to use, if not set in environment.
#'
#' @return A tibble providing the count of recalls from the Vehicle Recalls.
#' @export
#'
#' @examples
#' \dontrun{
#' count_recall_by_model("civic")
#' count_recall_by_model(c("Subaru", "Toyota"), start_year = 2008)
#' API_KEY <- "xxxxxxxxxxx"
#' count_recall_by_model("Sub", end_year = 2000, api_key = API_KEY)
#' }
count_recall_by_model <- function(model, start_year = NULL, end_year = NULL,
                                  api_key = NULL) {

  # create multiple requests from input list
  input_request <- paste(model, collapse = "|")

  # format the url string
  url_ <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall/model-name/"
  url_ <- paste(url_, input_request, sep = "")

  # append year range criteria to url if input by user
  if (!is.null(start_year) | !is.null(end_year)) {

    # add start or end year if value one of the values is NULL
    if (is.null(start_year)) start_year <- 1900
    if (is.null(end_year)) end_year <- 2100

    year_range <- paste(toString(start_year), toString(end_year), sep = "-")
    url_ <- paste(url_, "/year-range/", year_range, sep = "")
  }
  # add count to url
  url_ <- paste(url_, "/count", sep = "")

  # API call, returns class vrd_api
  api_output <- call_vrd_api(url_, model, api_key = api_key)

  # convert content to a dataframe
  contents_df <- clean_vrd_api(api_output)

  # outputs dataframe
  contents_df
}

#' Count of recalls searching by year
#'
#' Returns the count of recalls in the Vehicle Recalls Database based on a
#' year range search term.
#'
#' @details
#' Queries the Vehicle Recalls Database API by year range and returns the count
#' of recalls in the database. If \code{start_year} and/or \code{end_year} are
#' not specified, the function will default to the start and/or end years
#' available in the database. Note that the year range is based on the
#' manufactured year and not the year a recall occurred.
#'
#' An API key is required to run the function and query the Vehicle Recalls
#' Database. The key can be acquired at
#' \url{https://tc.api.canada.ca/en/detail?api=VRDB}.
#'
#' The API key can be set in the environment using
#' \code{Sys.setenv(VRD_API = 'your_API_key_here')} and will be used by the
#' function, or can be passed into the function using the \code{api_key}
#' argument.
#'
#' @param start_year Start of year range (optional).
#' @param end_year End of year range (optional).
#' @param api_key API access key to use, if not set in environment.
#'
#' @return A tibble providing the count of recalls from the Vehicle Recalls.
#' @export
#'
#' @examples
#' \dontrun{
#' count_recall_by_years(2010, 2012)
#' API_KEY <- "xxxxxxxxxxx"
#' count_recall_by_years(end_year = 1970, api_key = API_KEY)
#' }
count_recall_by_years <- function(start_year = 1900, end_year = 2100,
                                  api_key = NULL) {

  # format the url string
  year_range <- paste(toString(start_year), toString(end_year), sep = "-")
  url_ <- "https://vrdb-tc-apicast-production.api.canada.ca/eng/vehicle-recall-database/v1/recall/year-range/"
  url_ <- paste(url_, year_range, "/count", sep = "")

  # api call, returns class vrd_api
  api_output <- call_vrd_api(url_, year_range, api_key = api_key)

  # convert content to a dataframe
  contents_df <- clean_vrd_api(api_output)

  # outputs dataframe
  contents_df
}
