#' Reads data from impala, using your ODBC connection.
#'
#' @param file sql file
#' @param query a string with a sql query.
#' @param user kerberos username
#' @param dsn The name ofthe ODBC connection on your computer. Defaults to "Cloudera Impala".
#'
#' @return Data.table containing output of sql query
#' @details If a file and query are both given, the file will be used.
#' @author Rahul Dodhia
#' @examples
#' x = readimpala('~/project_folder/example.sql','rdodhia')
#' @export

readimpala=function(file='',query='',user='rdodhia',dsn='Cloudera Impala',type='file')
{
#Needs function onelineq
library(RODBC)
library(data.table)
odbcCloseAll()
ch=odbcConnect(dsn,user,'#')
print("connected to impala")
if(file=='')
  if(query=='') stop("No file or string provided with sql query",call. = F) else {
      file=query
      type='string'
      } else
        type='file'

x=sqlQuery(channel=ch,query=onelineq(file,type),believeNRows=F)
if(typeof(x)!='list') stop("Data not returned, check query syntax.",call. = F)
setDT(x)
x
}
