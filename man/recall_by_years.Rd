% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/recall_data.R
\name{recall_by_years}
\alias{recall_by_years}
\title{Summary of recalls searching by years}
\usage{
recall_by_years(start_year = 1900, end_year = 2100, limit = 25, api_key = NULL)
}
\arguments{
\item{start_year}{Start of year range.}

\item{end_year}{End of year range.}

\item{limit}{Number indicating how many recall entries should be returned.
Defaults to 25 which is the default of the API.}

\item{api_key}{API access key to use, if not set in environment.}
}
\value{
A tibble of recall summary information from the Vehicle Recalls
Database. Includes six columns.
}
\description{
Returns summary information of recalls in the Vehicle Recalls Database based
on a year range search term.
}
\details{
Queries the Vehicle Recalls Database API by year range and returns
summary recall information. If \code{start_year} and/or \code{end_year} are
not specified, the function will default to the start and/or end years
available in the database. Note that the year range is based on the
manufactured year and not the year a recall occurred.

An API key is required to run the function and query the Vehicle Recalls
Database. The key can be acquired at
\url{https://tc.api.canada.ca/en/detail?api=VRDB}.

The API key can be set in the environment using
\code{Sys.setenv(VRD_API = 'your_API_key_here')} and will be used by the
function, or can be passed into the function using the \code{api_key}
argument.
}
\examples{
\dontrun{
recall_by_years(2010, 2012, limit = 100)
API_KEY <- "xxxxxxxxxxx"
recall_by_years(end_year = 1970, api_key = API_KEY)
}
}
