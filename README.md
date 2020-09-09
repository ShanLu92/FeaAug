
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Feature Augmentation (FeaAug)

<!-- badges: start -->

<!-- badges: end -->

This package aims to improve the accuracy of classification models by
transfroming the original features into new features that are of better
quality. We will updata the package when more methods become available.

In version 0.1.0, this can be accomplished by the function “LMDRT”. The
function “LMDRT” implements the logarithm marginal density ratios
transformation to reach the goal, which greatly improves the detection
capability of an SVM-based detection model in NSL-KDD dataset. Other
classifiers can also be employed to replace SVM.

## Installation

You can instll the package from Github:

``` r
#library(devtools)
#install_github('shanlu92/FeaAug')
```

Or you can download the package from Github and run the
following:

``` r
#install.packages('path/FeaAug_0.1.0.tar.gz', repos = NULL, type = 'source')
```

## Example

This is a simple example which shows you how to apply the function
“LMDRT”.

``` r
library(e1071)
library(parallel)
library(FeaAug)
intest = subnum(rawdata, k = 10)[[1]] #rawdata is the NSL-KDD dataset.
test = rawdata[intest,]
training = rawdata[-intest,]
data = LMDRT(training, test, 'class', c('normal', 'attack'), T)
traindata = data$traindata
testdata = data$testdata
head(traindata)[,1:6]  # the first six rows and six columns of the transformed train dataset
#>           [,1]       [,2]      [,3]       [,4]      [,5]      [,6]
#> [1,] -1.003643 -0.3537013 -1.141152 -1.9910940 -10.85321 -7.471486
#> [2,] -1.003643 -0.3537013  1.233568  4.2952873 -10.85315 -7.471486
#> [3,] -1.003643 -0.3537013  2.792462  4.2952873 -10.85315 -7.471486
#> [4,] -1.003643 -0.3537013  2.792462  0.8469268 -10.85315 -7.471486
#> [5,] -1.003643 -0.3537013  2.792462  4.2952873 -10.85315 -7.471486
#> [6,] -1.003643 -0.3537013 -1.141152 -1.9910940 -10.85319 -7.471486
head(testdata)[,1:6] # the first six rows and six columns of the transformed test dataset
#>           [,1]       [,2]      [,3]       [,4]      [,5]      [,6]
#> [1,] -1.003643  1.4403776  2.476823 -1.9910940 -10.85327 -7.471486
#> [2,] -1.004741 -0.3537013 -3.338059 -1.9910940 -10.85324 -7.471466
#> [3,] -1.003643 -1.8540444 -2.835647 -1.9910940 -10.85315 -7.471484
#> [4,] -1.003643 -0.3537013 -2.829299 -1.9910940 -10.85318 -7.471369
#> [5,] -1.003643 -0.3537013  2.792462  0.8469268 -10.85315 -7.471486
#> [6,] -1.003643 -0.3537013 -3.338059 -1.9910940 -10.85331 -7.471466
```

The transformed data are of better quality than the original data. Next,
the transformed data can then be put into any classifier such as SVM.
More details can be found in *example.R*.

## Main Reference

Wang H , Gu J , Wang S . An effective intrusion detection framework
based on SVM with feature augmentation\[J\]. Knowledge-Based Systems,
2017, 136(Nov.15):130-139.

## Authors list

For this version of package (FeaAug\_0.1.0), the authors are:

Jie Gu, Yue Zheng Ouyang, and Shan Lu (<shan.lu@cufe.edu.cn>).
