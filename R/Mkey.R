#' @rdname Mkex
Mkey=function(m,yname,kernel='gaussian')  {
  deny=data.frame(rep(0,512),rep(0,512))
  ind=which(names(m)==yname)
  ran=range(m[,-ind])
  for (i in (1:ncol(m))[-ind]) {
    den=density(m[,i],kernel = kernel,from = ran[1]-0.1,to=ran[2]+0.1)
    deny[,i]=den$y
  }
  return(deny)
}
