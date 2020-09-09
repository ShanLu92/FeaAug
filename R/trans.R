#' Features Extraction
#'
#' Use the result of kernel density estimation to transform therefore augment features of train and test set.
#'
#' For dataset d0 and d1, the default algorithm use Mkex( ) and Mkey( ) to estimate kernel density. Use f( ) and g( ), the outcome of estimation, to transform features in train and test set by log(f(x)) - log(g(x)).
#'
#' @param train a train set that needs to be transformed.
#' @param test a test set that needs to be transformed.
#' @param d0 samples’ data in one class
#' @param d1 samples’ data in one class
#' @param yname the name of result-column.
#' @param yflag a flag that describes whether there is result-column in the test set.
#'
#' @return The transform function outputs dataset of augmented features.
#' @source
#' For transformation, based on
#' Wang H , Gu J , Wang S . An effective intrusion detection framework based on SVM with feature augmentation[J]. Knowledge-Based Systems, 2017, 136(Nov.15):130-139.
#' Fan J , Feng Y , Jiang J , et al. Feature Augmentation via Nonparametrics and Selection (FANS) in High Dimensional Classification[J]. Journal of the American Statal Association, 2016, 111(513):275.

#' @export trans
#' @importFrom parallel detectCores
#' @importFrom parallel makeCluster
#' @importFrom parallel clusterExport
#' @importFrom parallel parSapply
#' @importFrom parallel stopCluster
#' @examples
#' intest = subnum(rawdata, k=10)[[1]]
#' test = rawdata[intest,]
#' training = rawdata[-intest,]
#' groups = subgroup(training, 'class', c('attack', 'normal'))
#' d0 = groups[[1]]
#' d1 = groups[[2]]
#' train=groups[[3]]
#' data=trans(train,test,d0,d1,'class',yflag=T)

trans=function(train,test,d0,d1,yname,yflag=T){
  ind=which(names(d0)==yname)
  traindata=sapply((1:ncol(train))[-ind],logInPred,m=train,d0=d0,d1=d1,yname=yname,Mkex=Mkex,Mkey=Mkey)
  if (yflag==T){
    testdata=sapply((1:ncol(test))[-ind],logInPred,m=test,d0=d0,d1=d1,yname=yname,Mkex=Mkex,Mkey=Mkey)
  } else{
    testdata=sapply((1:ncol(test)),logInPred,m=test,d0=d0,d1=d1,yname=yname,Mkex=Mkex,Mkey=Mkey)
  }
  return(list(traindata=traindata,testdata=testdata))
}
