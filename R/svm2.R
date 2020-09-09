#' @rdname svm0
svm2=function(yflag=F,traindata,train,testdata,test,yname){
  if (yflag==T){
    trainn=cbind(traindata,train)
    ind=which(names(trainn)==yname)
    testn=cbind(testdata,test)
    time=system.time({svn=svm(as.matrix(trainn[,-ind]),as.factor(trainn[,ind]),type="C-classification",scale = FALSE,kernel = "radial")})
    psvn=predict(svn,testn[,-ind])
    conf=table(psvn,testn[,ind])
    out=list(time=time,predict=psvn,confusion_matrix=conf)}
  else {
    trainn=cbind(traindata,train)
    ind=which(names(trainn)==yname)
    testn=cbind(testdata,test)
    time=system.time({svn=svm(as.matrix(trainn[,-ind]),as.factor(trainn[,ind]),type="C-classification",scale = FALSE,kernel = "radial")})
    psvn=predict(svn,testn)
    out=list(time=time,predict=psvn)}
  return(out)
}
