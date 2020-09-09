#' Random Grouping I
#'
#' Random grouping function for indexes of dataset’s row to divide into k groups.
#'
#' Randomly split the number of dataset’s rows into k mutually exclusive groups.
#' Divide the number of dataset’s rows by k and round the outcome. The result is regarded as the number of samples of each group. Use the sample( ) to extract k-1 groups out in the index of dataset’s rows, until the last group remains.
#'
#' @param data dataset that needs to be grouped by row.
#' @param k the number of groups.
#'
#' @return The value returned is a list of k-group-index, each element of the list is the sample in indexes of rows of the grouping results.
#' @export
#'
#' @source
#' For sample, based on
#'
#' Becker, R. A., Chambers, J. M. and Wilks, A. R. (1988) The New S Language. Wadsworth & Brooks/Cole.
#'
#' Ripley, B. D. (1987) Stochastic Simulation. Wiley.
#' @examples
#' intest = subnum(rawdata, k=10)
subnum=function(data,k=10){
  sub=list()
  N=1:nrow(data)
  for(i in 1:(k-1)){
    set.seed(12+i)
    sub[[i]]=sample(N,round(nrow(data)/k,0))
    N=setdiff(N,sub[[i]])
  }
  sub[[k]]=N
  return(sub)
}
