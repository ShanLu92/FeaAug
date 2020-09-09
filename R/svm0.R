#' Classification by SVM
#'
#' Use different datasets to train SVM model in order to classify the test set.
#'
#' The function svm0 need original data to train SVM model.
#' The function svm1 need transformed data to train SVM model.
#' The function svm2 need transformed data augmented by original data to train SVM model.
#' These functions train SVM model and predict classification result of test set.
#'
#' @param yflag a flag that describes whether there is result-column in the test set.
#' @param train a train set that needs to be transformed.
#' @param test a test set that needs to be transformed.
#' @param yname the name of result-column.
#'
#' @return If there is result-column in test set, these functions give time of running, predicted result and the confusion matrix of actual and predicted class. Otherwise, these functions only give time and predicted result.
#' @source
#' For SVM, based on
#' •	Chang, Chih-Chung and Lin, Chih-Jen:
#'  LIBSVM: a library for Support Vector Machines
#'  http://www.csie.ntu.edu.tw/~cjlin/libsvm
#'•	Exact formulations of models, algorithms, etc. can be found in the document:
#'  Chang, Chih-Chung and Lin, Chih-Jen:
#'  LIBSVM: a library for Support Vector Machines
#'  http://www.csie.ntu.edu.tw/~cjlin/papers/libsvm.ps.gz
#'•	More implementation details and speed benchmarks can be found on: Rong-En Fan and Pai-Hsune Chen and Chih-Jen Lin:
#'  Working Set Selection Using the Second Order Information for Training SVM
#'  http://www.csie.ntu.edu.tw/~cjlin/papers/quadworkset.pdf
#' @export svm0
#' @import parallel
#' @importFrom e1071 svm
#' @examples
#' intest = subnum(rawdata, k = 10)[[1]]
#' test = rawdata[intest, ]
#' training = rawdata[-intest,]
#' groups = subgroup(training, 'class', c('attack', 'normal'))
#' d0 = groups[[1]]
#' d1 = groups[[2]]
#' train = groups[[3]]
#' data = trans(train, test, d0, d1, 'class', yflag=T)
#' traindata = data[[1]]
#' testdata = data[[2]]
#' svm0(yflag = T, train, test, 'class')
#' svm0(yflag = F, train, test[, -40], 'class')
#' svm1(yflag = T, traindata, testdata, ytrain = train[, 40], ytest = test[, 40])
#' svm1(yflag = F, traindata, testdata, ytrain = train[, 40])
#' svm2(yflag = T, traindata, train, testdata, test, 'class')
#' svm2(yflag = F, traindata, train, testdata, test[,-40],'class')

svm0=function(yflag=F,train,test,yname){
  ind=which(names(train)==yname)
  if (yflag==T){
    time=system.time({svf=svm(as.matrix(train[,-ind]),as.factor(train[,ind]),type="C-classification",scale = FALSE,kernel = "radial")})
    psvf=predict(svf,test[,-ind])
    conf=table(psvf,test[,ind])
    out=list(time=time,predict=psvf,confusion_matrix=conf)}
  else {
    time=system.time({svf=svm(as.matrix(train[,-ind]),as.factor(train[,ind]),type="C-classification",scale = FALSE,kernel = "radial")})
    psvf=predict(svf,test)
    out=list(time=time,predict=psvf)}
  return(out)
}
