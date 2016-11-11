#' Read files
#'
#' @param x file name, include file path
#'
#' @return data.table
#'
#' @examples
#' y = read('file.csv')
#' y = read('file.tab')
read=function(x){
    if(length(grep('csv',x))>0)
        r=read.csv(x,header=T)
    else
        r=read.table(x,header=T)
    names(r)=tolower(names(r))
    setDT(r)
    r
}
