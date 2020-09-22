#' Get Concourse Course IDs
#'
#' @param keyword String of keyword
#' @param keyword_mode Options are "any" or "all"
#' @param title String of title
#' @param prefix String of course prefix
#' @param number String of course number/code 
#' @param campus_id String of campus ID
#' @param school_id String of college/school ID
#' @param department_id String of department ID
#' @param instructor String of instructor name
#' @param session String of session
#' @param year String of year
#' @param timeframe Options are "past", "past_current", "current", "current_future", or "future"
#' @param delivery String of delivery
#' @param credits String of the number of course credits
#' @param template Options are "templates" or "non"
#' @param audit_status One of "0", "1", "2", "3", or "4".  1 means In Progress, 2 means Reviewed, 3 means Modified Since Review, and 4 means Submitted For Review.
#' @param server Options are "sandbox", "production", or a provided URL
#' @param ... Optional info for callConcourse
#' 
#' @export
getCourseIDs <- function(keyword = NULL,
                         keyword_mode = NULL,
                         title = NULL,
                         prefix = NULL,
                         number = NULL,
                         campus_id = NULL,
                         school_id = NULL,
                         department_id = NULL,
                         instructor = NULL,
                         session = NULL,
                         year = NULL,
                         timeframe = NULL,
                         delivery = NULL,
                         credits = NULL,
                         template = NULL,
                         audit_status = NULL,
                         server = "sandbox",
                         ...) {
  
  url <- loadURL(server)

  url$path <- "api"
  
  url$query <- list(api = 0,
                    operation = "course_ids",
                    keyword = keyword,
                    keyword_mode = keyword_mode,
                    title = title,
                    prefix = prefix,
                    number = number,
                    campus_id = campus_id,
                    school_id = school_id,
                    department_id = department_id,
                    instructor = instructor,
                    session = session,
                    year = year,
                    timeframe = timeframe,
                    delivery = delivery,
                    credits = credits,
                    template = template,
                    audit_status = audit_status)
  
  ##Pass the url to the request processor
  results <- callConcourse(url, ...)
  
  results <- jsonlite::fromJSON(results, flatten = TRUE)
  
  
  return(results)
  
}