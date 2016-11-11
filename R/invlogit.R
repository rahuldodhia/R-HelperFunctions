#' Inverse logit.
#'
#' @param x a numeric vector or scalar
#'
#' @return Vector or scalar of the inverse logit of x
#' @author Rahul Dodhia
#' @examples
#' y = invlogit(x = c(-4,0,100,3))
#' @export


invlogit=function(x) {
  exp(x)/(1+exp(x))
}