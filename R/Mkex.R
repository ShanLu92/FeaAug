#' Kernel Density Estimation
#'
#' The function Mkex and Mkey return results of kernel density estimates about x and y.
#'
#' For dataset m, the default algorithm use density( ) to disperses the mass of the empirical distribution function over a regular grid of at least 512 points and then uses the fast Fourier transform to convolve this approximation with a discretized version of the kernel and then uses linear approximation to evaluate the density at the specified points.
#'
#' @param m dataset that needs to be estimated.
#' @param yname the name of result-column.
#' @param kernel a character string giving the smoothing kernel to be used. This must partially match one of "gaussian", "rectangular", "triangular", "epanechnikov", "biweight", "cosine" or "optcosine", with default "gaussian", and may be abbreviated to a unique prefix (single letter).
#'
#' @return
#' Mkex gives the n coordinates of the points where the density is estimated.
#' Mkey gives the estimated density values. These will be non-negative, but can be zero.
#' @export Mkex
#'
#' @source
#' For density, based on
#'
#' Becker, R. A., Chambers, J. M. and Wilks, A. R. (1988). The New S Language. Wadsworth & Brooks/Cole (for S version).
#'
#' Scott, D. W. (1992). Multivariate Density Estimation. Theory, Practice and Visualization. New York: Wiley
#'
#' Sheather, S. J. and Jones, M. C. (1991). A reliable data-based bandwidth selection method for kernel density estimation. Journal of the Royal Statistical Society series B, 53, 683–690.http://www.jstor.org/stable/2345597.
#'
#' Silverman, B. W. (1986). Density Estimation. London: Chapman and Hall.
#'
#' Venables, W. N. and Ripley, B. D. (2002). Modern Applied Statistics with S. New York: Springer.
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

Mkex=function(m,yname,kernel='gaussian')  {
  denx=data.frame(rep(0,512),rep(0,512))
  ind=which(names(m)==yname)
  ran=range(m[,-ind])
  for (i in (1:ncol(m))[-ind]) {
    den=density(m[,i],kernel = kernel,from = ran[1]-0.1,to=ran[2]+0.1)
    denx[,i]=den$x
  }
  return(denx)
}
