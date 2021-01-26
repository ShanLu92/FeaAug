#' Feature Extraction
#'
#' Use the result of kernel density estimation to transform therefore augment certain feature of train/test set.
#'
#' For dataset d0 and d1, the default algorithm use Mkex( ) and Mkey( ) to estimate kernel density. Use f( ) and g( ), the outcome of estimation, to transform the ith feature of dataset m by log(f(m)) - log(g(m)).
#'
#' @param i a index of feature that needs to be transformed.
#' @param m dataset consisting of features.
#' @param d0 samples’ data in one class
#' @param d1 samples’ data in the other class.
#' @param yname the name of result-column.
#' @param Mkex a function to estimate kernel density of x.
#' @param Mkey a function to estimate kernel density of y.
#'
#' @return The transform function outputs augmented feature.
#' @source
#' For transformation, based on
#' Wang H , Gu J , Wang S . An effective intrusion detection framework based on SVM with feature augmentation[J]. Knowledge-Based Systems, 2017, 136(Nov.15):130-139.
#' Fan J , Feng Y , Jiang J , et al. Feature Augmentation via Nonparametrics and Selection (FANS) in High Dimensional Classification[J]. Journal of the American Statal Association, 2016, 111(513):275.
#' @export logInPred
#'
#' @examples
#' intest = subnum(rawdata, k=10)[[1]]
#' test = rawdata[intest,]
#' training = rawdata[-intest,]
#' groups = subgroup(training, 'class', c('attack', 'normal'))
#' d0 = groups[[1]]
#' d1 = groups[[2]]
#' denx0 = Mkex(d0, yname)
#' deny0 = Mkey(d0, yname)
#' logInPred(1, training, d0, d1, class, Mkex = Mkex, Mkey = Mkey)
logInPred=function(i,m,d0,d1,yname,Mkex=Mkex,Mkey=Mkey){
  denx0=Mkex(d0,yname)
  deny0=Mkey(d0,yname)
  denx1=Mkex(d1,yname)
  deny1=Mkey(d1,yname)
  K=m
  g=approxfun(denx0[,i],deny0[,i])
  d0=sapply(m[,i], g)
  d0[which(is.na(d0))]=0
  d0[d0<0.01]=0.01
  f=approxfun(denx1[,i],deny1[,i])
  d1=sapply(m[,i], f)
  d1[which(is.na(d1))]=0
  d1[d1<0.01]=0.01
  K[,i]=log(d1)-log(d0)
  return(K[,i])
}
