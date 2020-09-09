#' Logarithm Marginal Density Ratios Transformation and Support Vector Machine
#'
#' Train SVM model based on train set which is logarithm marginal density ratio transformed. Apply trained model on test set to predict.
#'
#' First, apply logarithm marginal density ratio transformation on train and test set. Then, train SVM model based on transformed train set. Finally, exert the model to predict category by transformed test set.
#'
#' @param training original train set.
#' @param test original test set.
#' @param yname the name of result-column.
#' @param levels results in result-column.
#' @param yflag a flag that describes whether there is result-column in the test set.
#' @param svm type of support vector machine.
#'
#' @return The function gives the result of prediction base train and test set.
#' @source
#' For transformation, based on
#' Wang H , Gu J , Wang S . An effective intrusion detection framework based on SVM with feature augmentation[J]. Knowledge-Based Systems, 2017, 136(Nov.15):130-139.
#' Fan J , Feng Y , Jiang J , et al. Feature Augmentation via Nonparametrics and Selection (FANS) in High Dimensional Classification[J]. Journal of the American Statal Association, 2016, 111(513):275.
#' For SVM, based on
#' •	Chang, Chih-Chung and Lin, Chih-Jen:
#'   LIBSVM: a library for Support Vector Machines
#'   http://www.csie.ntu.edu.tw/~cjlin/libsvm
#' •	Exact formulations of models, algorithms, etc. can be found in the document:
#'   Chang, Chih-Chung and Lin, Chih-Jen:
#'   LIBSVM: a library for Support Vector Machines
#'   http://www.csie.ntu.edu.tw/~cjlin/papers/libsvm.ps.gz
#' •	More implementation details and speed benchmarks can be found on: Rong-En Fan and Pai-Hsune Chen and Chih-Jen Lin:
#'   Working Set Selection Using the Second Order Information for Training SVM
#'   http://www.csie.ntu.edu.tw/~cjlin/papers/quadworkset.pdf

#' @export classifier
#'
#' @examples
#' intest = subnum(rawdata, k = 10)[[1]]
#' test = rawdata[intest,]
#' training = rawdata[-intest,]
#' classifier(training, test, 'class', c('normal', 'attack'), T, c('scmf', 'svmt'))

classifier=function(training,test,yname,levels,yflag=T,svm=c('svmt')){
  ind=which(names(training)==yname)
  data=LMDRT(training,test,yname,levels,yflag)
  traindata=data[[1]]
  testdata=data[[2]]
  resultt=list()
  resultf=list()
  resultn=list()
  if (any(svm=='svmf')){
    resultf=svm0(yflag=yflag,train,test,yname)
  } else if (any(svm=='svmt')){
    resultt=svm1(yflag=yflag,traindata,testdata,train[,ind],ytest=ifelse(yflag,test[,ind],NAN))
  } else if (any(svm=='svmn')){
    resultn=svm2(yflag=yflag,traindata,train,testdata,test,yname)
  }
  return(list(resultf,resultt,resultn))
}
