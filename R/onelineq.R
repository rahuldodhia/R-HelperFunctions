#' Helper function for readimpala()
#' @description  Cleans up sql query for use in readimpala(). Not usually run by itself, called by readimpala().
#'
#' @param x character vector or list of character vectors
#' @param sqlfile file containing sql query
#'
#' @return character variable for use in readimpala()
#' @author Rahul Dodhia
#' @examples
#' x = readimpala('~/project_folder/example.sql','rdodhia')
#' @export
onelineq = function(sqlfile,type="file") {
  if(type=='file')
    A = readLines(sqlfile) # read in the query to a list of lines
  if(type=='string')
        A=sqlfile
  B = lapply(sapply(A,strsplit,'--'),function(x) x[1]) # remove comments in same lien as other code
  C = lapply(B,lineclean) # process each line
  D = Filter(function(x) x != "",C) # remove blank and/or comment lines
  E = paste(unlist(D),collapse=" ") # paste lines together into one-line string, spaces between.
  print('finishing onelineq')
  return(E)
}

lineclean = function(x) {
  x = gsub("\t+", "", x, perl=TRUE); # remove all tabs
  x = gsub("^\\s+", "", x, perl=TRUE); # remove leading whitespace
  x = gsub("\\s+$", "", x, perl=TRUE); # remove trailing whitespace
  x = gsub("[ ]+", " ", x, perl=TRUE); # collapse multiple spaces to a single space
  x = gsub("^[--]+.*$", "", x, perl=TRUE); # destroy any comments
  return(x)
}

