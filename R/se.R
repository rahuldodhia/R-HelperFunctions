#' Standard error of the mean
#' @description R has a built-in sd() function which calculates the standard deviation of a sample. This function is used to derive the s.e. of the mean. Missing values will be ignored.
#' @param x numeric vector
#'
#' @return A scalar
#' @author Rahul Dodhia
#' @examples
#' y = se(c(3,8,NA,3,1,10))
#' @export

se=function(x) {
  sd(x,na.rm=T)/sqrt(sum(!is.na(x))-1)
}
