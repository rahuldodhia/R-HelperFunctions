#' Title
#'
#' @param x data.table
#'
#' @export
#'
#' @author Rahul Dodhia
standardize=function(x,full=F)
{

  xnames=names(x)
  cl=sapply(x,class)
  ni=cl=='integer' | cl=='numeric'
  e1=x[,!ni,with=F]
  tempe2=x[,ni,with=F]
  print(head(tempe2))
  e2=apply(tempe2,2,function(z) (z-mean(z,na.rm=T))/sd(z,na.rm=T))
  if(length(e1)==0)
    out=data.table(e2) else
      out=data.table(e1,e2)


  setnames(out,c(names(e1),setdiff(xnames,names(e1))))
  if(full) out=list(y=out,class=ni)
  print('standardize finished')
  out

}
