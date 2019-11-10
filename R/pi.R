estimate_pi <- function(B , seed, make_plot){

  # interruption
  if (B <= 0 || !is.numeric(B))
    stop("Please specify a numeric positive value of B")
  if (! is.numeric(seed))
    stop("Please specify a numeric value for the seed")
  if ((! is.logical(make_plot)))
    stop("Please specify a logical value TRUE to print a graph FALSE to only have the pi value")

  # Control seed
  set.seed(seed)

  # Generate B points
  point = matrix(runif(2 * B, -1, 1), nrow = B, ncol = 2)

  # function to define if a point is inside the circle
  is_incircle <- function(i){
    ifelse((i[1] ^ 2 + i[2] ^ 2) < 1, 1, 0)
  }

  # apply the function over all points
  Z<-NULL
  for (i in 1:B){
    Z[i] <- is_incircle(point[i, ])
  }

  # Create the data.frame
  final <- data.frame(point, Z)

  # estimate the pi value from the points
  pi <- 4 * (sum(final$Z) / nrow(final))

  #create a circle
  get_circle <- function(r, n) {
    dplyr::data_frame(theta = seq(0, 2 * pi, length.out =  n),
                      x     = cos(theta) * r,
                      y     = sin(theta) * r)
  }

  circ <- get_circle(1,200)

  #create a cube
  cube <- dplyr::data_frame(x = c(1, 1, -1, -1, 1), y = c(1, -1 , -1, 1, 1))

  #plot
  cercle <- ggplot(final) +
    geom_point(aes(X1, X2, color = as.character(Z)), alpha = 0.5) +
    theme_classic() +
    guides(color = FALSE) +
    ylab("y") +
    xlab("x") +
    geom_path(data = circ,  aes(x, y)) +
    geom_path(data = cube,  aes(x, y)) +
    coord_fixed() +
    theme(panel.background = element_rect(fill = "white", colour = "black"))


  #define which output is wanted

  hat_pi <- if (make_plot == TRUE) {
    cercle
  } else {
    pi
  }

  return(hat_pi)
}



plot_pi <- function(Vec_B){


  # Interruption
  if (Vec_B <= 0 || ! is.numeric(Vec_B))
    stop("Please specify numeric positive values for the input vector")

  a <- NULL
  for (i in 1:(length(Vec_B) - 1)){
    a <- c(a, ((Vec_B[i] < Vec_B[i + 1]) & Vec_B[i] > 0))
  }

  if (any(a == FALSE))
    stop("Please specify ascending numeric positive values for the input vector")

  # generate dataframe of convergence
  pi_vec <- NULL
  B <- NULL

  for (i in Vec_B){
    pi_vec <- c(pi_vec, find_pi(i, 10, FALSE))
    B <- c(B, i)
  }

  pi_convergence <- data.frame("pi_estimate" = pi_vec, "B" = B)

  #plot
  pi_convergence %>% ggplot(aes(B, pi_estimate)) +
    ggtitle("Estimated Pi depending on B") +
    theme_bw()+
    geom_point()+
    ylab("Estimation of pi") +
    xlab("B") +
    theme(plot.title = element_text(hjust = 0.5))

}
