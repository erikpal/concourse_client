#' Get Concourse Change Log Info 
#'
#' @param id An internal or external id for the course
#' @param type Options are "external_id" or "course_id"
#' @param server Options are "sandbox", "production", or a provided URL
#' @param ... Optional info for callConcourse
#' 
#' @export
getChangeLog <- function(id,
                          type = "external_id",
                          server = "sandbox",
                          ...) {
  
  url <- loadURL(server)
  
  url$path <- "api"
  
  url$query <- list(api = 0,
                    operation = "change_log")
  
  url$query[[type]] <- id
  
  ##Pass the url to the request processor
  results <- callConcourse(url, ...)
  
  results <- jsonlite::fromJSON(results, simplifyVector = FALSE)
  
  return(results)
  
}