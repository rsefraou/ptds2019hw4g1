#' @title Run demonstration of app
#'
#' @describeIn  returns  an estimated value of π and simulated points
#' @import magrittr dplyr scales stringr kableExtra ggplot2 stats ptds2019hw4g1
#' @export
runDemo <- function() {
  appDir <- system.file("shiny-examples", "pi",  package = "ptds2019hw4g1")
  if (appDir == "") {
    stop(
      # REPLACE N BY YOUR GROUP NUMBER AND DELETE THIS COMMENT
      "Could not find example directory. Try re-installing ptds2019hw4g1.",
      call. = FALSE
    )
  }

  shiny::runApp(appDir, display.mode = "normal")

}

