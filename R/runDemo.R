#' @title Run demonstration of app
#'
#' @describe runDemo returns  an estimated value of π and simulated points
#' @import magrittr dplyr scales stringr  ggplot2 stats
#' @export
runDemo <- function() {
  appDir <- system.file("shiny-examples", "pi",  package = "ptds2019hw4g1")
  if (appDir == "") {
    stop(
      "Could not find example directory. Try re-installing ptds2019hw4g1.",
      call. = FALSE
    )
  }

  shiny::runApp(appDir, display.mode = "normal")

}

