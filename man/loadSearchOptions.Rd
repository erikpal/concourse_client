% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/loadSearchOptions.R
\name{loadSearchOptions}
\alias{loadSearchOptions}
\title{Load the search parameters from a page}
\usage{
loadSearchOptions(server = "sandbox")
}
\arguments{
\item{server}{Options are "sandbox", "production", or a provided URL}
}
\value{
url A named list of search options
}
\description{
This isn't an API function, but scrapes the search options from the base URL and returns a named list.
}
