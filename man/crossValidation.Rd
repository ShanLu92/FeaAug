% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/crossValidation.R
\name{crossValidation}
\alias{crossValidation}
\title{Cross Validation}
\source{
For cross vaildation, based on
Kohavi, Ron (1995). "A study of cross-validation and bootstrap for accuracy estimation and model selection". Proceedings of the Fourteenth International Joint Conference on Artificial Intelligence. San Mateo, CA: Morgan Kaufmann. 2 (12): 1137–1143. CiteSeerX 10.1.1.48.529.
Devijver, Pierre A.; Kittler, Josef (1982). Pattern Recognition: A Statistical Approach. London, GB: Prentice-Hall. ISBN 0-13-654236-0.
}
\usage{
crossValidation(rawdata, yname, levels, svm = c("svmt"), k = 10)
}
\arguments{
\item{rawdata}{original data set.}

\item{yname}{the name of result-column.}

\item{levels}{results in result-column.}

\item{svm}{type of support vector machine.}

\item{k}{the number of folds in cross-validation.}
}
\value{
The function gives the result of prediction combined over k-round validation include confusion matrix and some derivations from it.
When TP, TN, FP, FN represent 4 type in confusion matrix respectively, the function gives accuracy(ACC) , positive predictive value (PPV), true positive rate (TPR), true negative rate (TNR) and negative predictive value (NPV).
}
\description{
Use k-fold cross-validation to guarantee the accuracy and reduce variability of LMDRT-SVM classification in this package.
}
\details{
One round of cross-validation involves partitioning a sample of data into complementary subsets, performing the analysis on train set, and validating the analysis on test set. To reduce variability, k rounds of cross-validation are performed using different partitions, and the validation results are combined over the rounds to give an estimate of the LMDRT-SVM model's predictive performance.
}
\examples{
crossValidation(rawdata, ‘class’, c(‘attack’, ‘normal’), k = 3)
}
