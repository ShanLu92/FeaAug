#' Logarithm Marginal Density Ratios Transformation
#'
#' Features augmentation via logarithm marginal density ratios transformation in train and test set.
#'
#' First, split train set into 2 part. Then, apply the first part on kernel estimation of class conditional densities and use the result of kernel density estimation to transform therefore augment features in train and test set.
#'
#' @param Train a train set that needs to be transformed.
#' @param Test a train set that needs to be transformed.
#' @param yname a train set that needs to be transformed.
#' @param levels results in result-column.
#' @param yflag a flag that describes whether there is result-column in the test set.
#'
#' @return The function gives transformed datasets from train and test set.
#' @source
#' For transformation, based on
#' Wang H , Gu J , Wang S . An effective intrusion detection framework based on SVM with feature augmentation[J]. Knowledge-Based Systems, 2017, 136(Nov.15):130-139.
#' Fan J , Feng Y , Jiang J , et al. Feature Augmentation via Nonparametrics and Selection (FANS) in High Dimensional Classification[J]. Journal of the American Statal Association, 2016, 111(513):275.
#'
#' @export LMDRT
#'
#' @examples
#' intest = subnum(rawdata, k = 10)[[1]]
#' test = rawdata[intest,]
#' training = rawdata[-intest,]
#' LMDRT(training, test, 'class', c('normal', 'attack'), T)

LMDRT=function(Train,Test,yname,levels,yflag){
  groups=subgroup(training = Train,yname = yname, levels = levels)
  d0=groups[[1]]
  d1=groups[[2]]
  train=groups[[3]]
  tran=trans(train = train,test = Test,d0 = d0,d1 = d1,yname = yname,yflag = yflag)
  traindata=tran[[1]]
  testdata=tran[[2]]
  return(list(traindata=traindata,testdata=testdata))
}
