#' Wrapper for k-means.
#'
#' @description Makes all columns numeric, removes row with missing values, standardizes columns to mean 1 and standard deviation 0.
#' @param x numeric matrix of data, or an object that can be coerced to such a matrix (such as a numeric vector or a data frame with all numeric columns).
#' @param ... any arguments that can be passed to kmeans().
#'
#' @return List with 2 elements.
#' \describe{
#'  \item{out}{contains standard kmeans() output,}
#'  \item{realcenters}{gives the centers on the original, non-standardized variables.}
#' }
#' @author Rahul Dodhia
#' @examples
#' y = km(m, centers=10, iter.max=20)
#' @export
#'
km=function(x,minnum=4,...){
  x=x[apply(x,1,function(z) sum(is.na(z))==0),] #remove rows with missing values
  print(2)
  x1=standardize(x,full=T)
  y=x1$y
  print(names(x1$class)[x1$class])
  y=y[,names(x1$class)[x1$class],with=F]
  out=kmeans(y,...)

  tempe2=x[,names(x1$class)[x1$class],with=F]
  if(sum(x1$class)==1) tempe2=as.matrix(tempe2)
  x=cbind(x,cluster=out$cl)
  checknum=x[,.N,by=cluster][N<=minnum]
  if(dim(checknum)[1]>0){
    dm=as.matrix(dist(out$centers))
    dm1=dm[checknum$cluster,,drop=FALSE]
    dm2=data.frame(to=apply(dm1,1,function(z) which(z==min(z[-checknum$cluster],na.rm=T))))
      for(i in dimnames(dm2)[[1]])
      x[cluster==as.numeric(i),cluster:=dm2[i,'to']]
    x$cluster=as.numeric(as.factor(x$cluster)) #resequence cluster numbers
  }
  list(k=x,realcenters=apply(tempe2,2,function(z) tapply(z,x$cluster,mean)))
}
