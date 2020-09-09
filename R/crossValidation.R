#' Cross Validation
#'
#' Use k-fold cross-validation to guarantee the accuracy and reduce variability of LMDRT-SVM classification in this package.
#'
#' One round of cross-validation involves partitioning a sample of data into complementary subsets, performing the analysis on train set, and validating the analysis on test set. To reduce variability, k rounds of cross-validation are performed using different partitions, and the validation results are combined over the rounds to give an estimate of the LMDRT-SVM model's predictive performance.
#'
#' @param rawdata original data set.
#' @param yname the name of result-column.
#' @param levels results in result-column.
#' @param svm type of support vector machine.
#' @param k the number of folds in cross-validation.
#'
#' @return
#' The function gives the result of prediction combined over k-round validation include confusion matrix and some derivations from it.
#' When TP, TN, FP, FN represent 4 type in confusion matrix respectively, the function gives accuracy(ACC) , positive predictive value (PPV), true positive rate (TPR), true negative rate (TNR) and negative predictive value (NPV).
#' @source
#' For cross vaildation, based on
#' Kohavi, Ron (1995). "A study of cross-validation and bootstrap for accuracy estimation and model selection". Proceedings of the Fourteenth International Joint Conference on Artificial Intelligence. San Mateo, CA: Morgan Kaufmann. 2 (12): 1137–1143. CiteSeerX 10.1.1.48.529.
#' Devijver, Pierre A.; Kittler, Josef (1982). Pattern Recognition: A Statistical Approach. London, GB: Prentice-Hall. ISBN 0-13-654236-0.
#' @export crossValidation
#'
#' @examples
#' crossValidation(rawdata, ‘class’, c(‘attack’, ‘normal’), k = 3)

crossValidation=function(rawdata,yname,levels,svm=c('svmt'),k=10){
  subnum=subnum(rawdata,k=k)
  results=list()
  for(j in 1:k){
    print(paste("#####","the outer",j,"loop","#####"))
    intest=subnum[[j]]
    test=rawdata[intest,]
    training=rawdata[-intest,]
    n=length(svm)
    result=list()
    classify=classifier(training,test,yname,levels,yflag=T,svm=svm)
    for (i in 1:n){
      conf=classify[[i]][[3]]
      x=svm[i]
      result[x]=list(ConfusionMatrix=conf)
    }
    if (j==1){
      results=result
    } else {
      for (i in 1:n){
        results[[i]]=mapply('+',results[[i]],result[[i]])
      }
    }
  }
  for (i in 1:n){
    conf=results[[i]][[1]]
    results[[i]]['ACC']=(conf[1,1]+conf[2,2])/sum(conf)
    results[[i]]['PPV']=conf[1,1]/sum(conf[,1])
    results[[i]]['TPR']=conf[1,1]/sum(conf[1,])
    results[[i]]['TNR']=conf[2,2]/sum(conf[,2])
    results[[i]]['NPV']=conf[2,2]/sum(conf[2,])
  }
  return(results)
}
