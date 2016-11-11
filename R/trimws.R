#' Remove whitespace
#'
#' @description Removes whitespace before and after a string
#' @param x A string
#'
#' @return String whithout leading and trailingwhitespace
#' @author Rahul Dodhia
#' @examples
#' y = trim('  hello  ')
#' sapply(x,trim) #x is a vector of strings
#' @export

trimws = function (x) gsub("^\\s+|\\s+$", "", x)
