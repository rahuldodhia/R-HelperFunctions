#' Group together low frequency values of a categorical variable
#'
#' @description The intenttion is to take a categorical variable with many values and transform it into a another categorical variable with a manageable number of values. For example, convert zipcode with 32000 values into a variable with 250 values. THe retained values will map 1-1 with the original values, except for <other>, which will map to all the low frequency original values.
#' @param data a dataframe
#' @param categvar a string containing the name of the categorical variable in d that will be grouped
#' @param metric a string containing the name of a numeric variable in d which will be used to determine which values of x to map into <other>
#' @param p a threshold indicating the percent of metric under which values of x will be mapped to <other>
#'
#' @return a data.frame with one new column, x.new, where x is the name of the column to be grouped.
#'
#' @author Rahul Dodhia
#' @examples
#' y = grouper(data = mydata, categvar='Species', metric='population', p=.03)
#' @export

grouper=function(data,categvar,metric,p=.03,suggestp=F,noutcat=NULL,type="recode") {
  setDT(data)
  if(metric=='') m=rep(1,dim(data)[1]) else m=data[,get(metric)]
  temp=tapply(m,data[,get(categvar)],sum,na.rm=T)
  temp1=sort(temp,decreasing=T)
  n=names(temp1)
  nnew=n
  if(!is.null(noutcat)==1) {
    cat("Using",noutcat,'categories instead of frequency cutoff')
    if(noutcat>=length(unique(data[,get(categvar)]))) warning("Number of output categories is not less than number of existing categories")
    quantile(temp1,seq(0,1,length.out = noutcat+1))
    groups=data.frame(categvar=names(temp1),group=cut(temp,quantile(temp,seq(0,1,length.out = noutcat+1))))
    groups$group=as.numeric(groups$group)
    out=merge(data,groups,by.y="categvar",by.x=categvar,all.x=T)
    names(out)[dim(out)[2]]=paste(categvar,'new',sep='.')
  } else {
    if(suggestp)
      p=unique(quantile(temp1,seq(0,1,.1)))[1]*1.1
    temp1=temp1/sum(temp1)
    nnew[temp1<p]='<other>'
    out=merge(data,data.frame(n,nnew),by.x=categvar,by.y='n',all.x=T)
    names(out)[dim(out)[2]]=paste(categvar,'new',sep='.')
    print(c(length(n),length(unique(nnew))))
  }
  out
}
