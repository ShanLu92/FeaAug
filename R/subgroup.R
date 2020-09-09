#' Random Grouping II
#'
#' Random grouping function for index of train set’s row to divide into 2 groups.
#'
#' Randomly split train set into two mutually exclusive parts. Classify the first part based on levels of yname.
#'
#' @param training a train set that needs to be grouped by row.
#' @param yname the name of result-column.
#' @param levels results in result-column.
#'
#' @return
#' The value returned is a list of 3 sets. The first set X1_0 and second set X1_1 are samples of two different levels in the first part of train set respectively. The third set X2 is the second part of train set.
#' @source
#' For sample, based on
#'
#' Becker, R. A., Chambers, J. M. and Wilks, A. R. (1988) The New S Language. Wadsworth & Brooks/Cole.
#'
#' Ripley, B. D. (1987) Stochastic Simulation. Wiley.
#' @export
#'
#' @examples
#' intest = subnum(rawdata, k=10)[[1]]
#' test = rawdata[intest,]
#' training = rawdata[-intest,]
#' groups = subgroup(training, 'class', c('attack', 'normal'))
subgroup=function(training,yname,levels){
  Trawdata=data.frame(Index=1:nrow(training),training)
  eval(parse(text = paste("T0=subset(Trawdata,",yname,"== levels[1])")))
  eval(parse(text = paste("T1=subset(Trawdata,",yname,"== levels[2])")))
  t0=sample(1:nrow(T0),ceiling(nrow(T0)/2))
  t1=sample(1:nrow(T1),ceiling(nrow(T1)/2))
  d0=T0[t0,-1]
  d1=T1[t1,-1]
  #Trawdata1=Trawdata[-c(T0[t0,1],T1[t1,1]),]
  Trawdata1=Trawdata[-c(T0[t0,1],T1[t1,1]),]
  train=Trawdata1[,-1]
  return(list(X1_0=d0,X1_1=d1,X2=train))
}

