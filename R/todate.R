#' Add date formats to data
#' @description Appends several date formats to a data.table. Assumes that one of the columns in the input data is labeled "date" and is in Y-m-d format.
#' @param d a data.table or data.frame
#'
#' @return the input data d with several columns appended
#'
#'
#'
#' @author Rahul M Dodhia
#' @export

todate=function(d) {
  library(lubridate)
  library(fasttime)

  setDT(d)
  x=d[,date]

  x=as.Date(fastPOSIXct(x,required.components = 3))
  dow=format(x,'%u')
  weekend=ifelse(dow>=6,T,F)
  dom=day(x)
  doy=format(x,'%j')
  day=format(x,'%A')
  month=format(x,'%B')
  monthnumber=as.numeric(format(x,'%m'))
  out=data.table(d,date=x,dow,weekend,dom,doy,day,month,monthnumber)
  out
}
