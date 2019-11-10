#' @title Simple Pi estimation
#'
#' @description returns  an estimated value of π and simulated points
#' @param B A \code{numeric} (integer) used to denote the number of points simulated
#' @param seed A \code{numeric} used to control the seed of the random number
#' generator used by this function.
#' @return A \code{list} of class pi with the attributes
#' @import magrittr dplyr tydiverse scales stringr kableExtra ggplot2 stats
#' \describe{
#'      \item{estimated_pi}{Estimated value of pi}
#'      \item{points}{Estimated points}
#' }
#' @export
#' @examples
#' estimate_pi(500, 6)
estimate_pi <- function(B = 5000, seed = 10) {
  if (B <= 0 | !is.numeric(B))
    stop("Please specify B as a numeric positive value")
  if (seed <= 0 || !is.numeric(seed))
    stop("Please specify seed as a numeric positive value")

  # set a seed
  set.seed(seed)
  # simulate B points
  points <- data.frame(
    x = runif(n = B, min = -1, max = 1),
    y = runif(n = B, min = -1, max = 1),
    inside = rep(NA, B)
  )
  #define if a point is inside the circle and assign it to column inside
  for(i in 1:nrow(points)){
    points[i,3] <- ifelse((points[i,1] ^ 2 + points[i,2] ^ 2) < 1, T, F)
  }

  estimated_pi = 4*sum(points[,3])/nrow(points)

  # create a new list
  rval <- list(
    estimated_pi = estimated_pi,
    points = points
  )
  # assign pi class to rval
  class(rval) <- "pi"
  # return rval
  return(rval)
}

#' @title Plot of pi
#'
#' @description plots simulated points
#' @param x A \code{lits} of class pi returned by the function simulate_pi
#' @return A \code{list} of class pi with the attributes
#' @export
#' @import magrittr dplyr tydiverse scales stringr kableExtra ggplot2 stats
plot.pi <- function(x) {
  points <- x[["points"]]


  #create circle
  circleFun <- function(center = c(0,0),r = 1, npoints = 100){
    tt <- seq(0,2*pi,length.out = npoints)
    xx <- center[1] + r * cos(tt)
    yy <- center[2] + r * sin(tt)
    return(data.frame(x = xx, y = yy))
  }
  dat <- circleFun()

  #create a cube
  cube <- dplyr::data_frame(x = c(1, 1, -1, -1, 1), y = c(1, -1 , -1, 1, 1))

  #plot
  ggplot(points) +
    geom_point(aes(x, y, color = inside), alpha = 0.5) +
    theme_classic() +
    guides(color = FALSE) +
    ylab("Y") +
    xlab("X") +
    ggtitle(bquote("Estimation of value of" ~ pi)) +
    geom_path(data = dat,  aes(x, y)) +
    geom_path(data = cube,  aes(x, y)) +
    coord_fixed() +
    theme(panel.background = element_rect(fill = "white", colour = "black"))
}
estimate_pi() %>% plot.pi()
