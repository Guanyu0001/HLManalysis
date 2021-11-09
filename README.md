
<!-- README.md is generated from README.Rmd. Please edit that file -->

# HLManalysis

<!-- badges: start -->
<!-- badges: end -->

This function is a wrapper for the \[dplyr::summarize()\] function from
the dplyr package. The function is fortified to handle the missing
values (NA), and it can provide a summary table with many descriptive
statistics for a variable grouped by a specify categorical variable. In
this case, this function can be used in multilevel models, and provide
the statistics for the level 2 units (e.g. the groups).

## Installation

HLManalysis is not yet no CRAN. But, you can download it from this
repository using the follwoing R command:

``` r
devtools:: install_github("Guanyu0001/HLManalysis")
```

## Example

First example is about `mtcars`, which was extracted from the 1974
*Motor Trend* US magazine. The “am” is the transmission (0 = automatic,
1 = manual), “mpg” is the Miles/(US) gallon. Here we can get the
descriptive statistics Miles/(US) gallon between automatic and manual
transmission.

``` r
library(HLManalysis)
level2summarize(mtcars, am, mpg)
#> # A tibble: 2 x 8
#>      am     n missing  mean median    sd   min   max
#>   <dbl> <int>   <int> <dbl>  <dbl> <dbl> <dbl> <dbl>
#> 1     0    19       0  17.1   17.3  3.83  10.4  24.4
#> 2     1    13       0  24.4   22.8  6.17  15    33.9
```

Second example is to show the requirement of each argument. For the
parameter a (e.g., grouping variable), both numeric and factor variables
work. To make the function more robust and user-friendly, this function
does not ask user to choose a categorical variable. For the parameter b
(e.g., the dependent variable or outcome), a numeric variable is
required; Otherwise, all the descriptive statistics does not make sense.

``` r
library(HLManalysis)
# parameter a can be numeric or factor
a <- as.factor(c(rep(1, 10), rep(2, 10)))
b <- as.numeric(c(rep(1, 10), rep(-1, 10))) # a as numeric
data1 <- data.frame(a, b)
level2summarize(data1, a, b)
#> # A tibble: 2 x 8
#>   a         n missing  mean median    sd   min   max
#>   <fct> <int>   <int> <dbl>  <dbl> <dbl> <dbl> <dbl>
#> 1 1        10       0     1      1     0     1     1
#> 2 2        10       0    -1     -1     0    -1    -1

a <- as.numeric(c(rep(1, 10), rep(2, 10)))
b <- as.numeric(c(rep(1, 10), rep(-1, 10))) # a as factor
data1 <- data.frame(a, b)
level2summarize(data1, a, b)
#> # A tibble: 2 x 8
#>       a     n missing  mean median    sd   min   max
#>   <dbl> <int>   <int> <dbl>  <dbl> <dbl> <dbl> <dbl>
#> 1     1    10       0     1      1     0     1     1
#> 2     2    10       0    -1     -1     0    -1    -1

# parameter b should be numeric
a <- as.factor(c(rep(1, 10), rep(2, 10)))
b <- as.factor(c(rep(1, 10), rep(-1, 10))) # b as factor
data1 <- data.frame(a, b)
level2summarize(data1, a, b)
#> Error in level2summarize(data1, a, b): 
#>  A numeric variable should be used for calculation. 
#>  Your input is a factor variable.

a <- as.factor(c(rep(1, 10), rep(2, 10)))
b <- as.numeric(c(rep(1, 10), rep(-1, 10))) # b as numeric
data1 <- data.frame(a, b)
level2summarize(data1, a, b)
#> # A tibble: 2 x 8
#>   a         n missing  mean median    sd   min   max
#>   <fct> <int>   <int> <dbl>  <dbl> <dbl> <dbl> <dbl>
#> 1 1        10       0     1      1     0     1     1
#> 2 2        10       0    -1     -1     0    -1    -1
```
