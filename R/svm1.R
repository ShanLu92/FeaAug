#' @rdname svm0
#' @param traindata a dataset that the train set transforms into.
#' @param testdata a dataset that the test set transforms into.
#' @param ytrain the result-column of train set.
#' @param ytest the result-column of test set.
#'
svm1=function(yflag=F,traindata,testdata,ytest){
  if (yflag==T){
    time=system.time({svt=svm(as.matrix(traindata[,-ncol(traindata)]),as.factor(traindata[,ncol(traindata)]),type="C-classification",scale = FALSE,kernel = "radial")})
    psvt=predict(svt,testdata)
    conf=table(psvt,ytest)
    out=list(time=time,predict=psvt,confusion_matrix=conf)}
  else {
    time=system.time({svt=svm(as.matrix(traindata[,-ncol(traindata)]),as.factor(traindata[,ncol(traindata)]),type="C-classification",scale = FALSE,kernel = "radial")})
    psvt=predict(svt,testdata)
    out=list(time=time,predict=psvt)}
  return(out)
}
