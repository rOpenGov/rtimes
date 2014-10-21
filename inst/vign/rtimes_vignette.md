<!--
%\VignetteEngine{knitr::knitr}
%\VignetteIndexEntry{rtimes vignette}
-->



rtimes vignette - R client for New York Times APIs
======

## About the package

`rtimes` is an R package to search and retrieve data from the New York Times congress API. 


### Install rtimes


```r
install.packages("devtools")
devtools::install_github("ropengov/rtimes")
```

### Load rtimes


```r
library(rtimes)
```

_Note: Member ID S001181 is Jeanne Shaheen_

### Get bill cosponsorship data for a particular member.


```r
library("plyr")
out <- cg_billscosponsor(memberid='S001181', type='cosponsored')
ldply(out$results[[1]]$bills, function(x) data.frame(x[c('number','cosponsors')]))
#>       number cosponsors
#> 1  S.RES.562         19
#> 2     S.2868          4
#> 3     S.1323         10
#> 4     S.2912          2
#> 5  S.RES.574         27
#> 6  S.RES.572         11
#> 7     S.2890          8
#> 8     S.2782         27
#> 9  S.RES.540          3
#> 10    S.2838          7
#> 11    S.1463         20
#> 12    S.2844          9
#> 13 S.RES.541         20
#> 14 S.RES.548         46
#> 15    S.2174          7
#> 16    S.2694          8
#> 17    S.2789         14
#> 18 S.RES.539         99
#> 19 S.RES.536         27
#> 20    S.2778          4
```

### Get information about a particular member's appearances on the House or Senate floor.


```r
library(plyr)
out <- cg_memberappear(memberid='S001181')
ldply(out$results[[1]]$appearances, function(x) data.frame(x[c('date','title')]))
#>          date
#> 1  2010-09-29
#> 2  2010-09-22
#> 3  2010-09-17
#> 4  2010-09-16
#> 5  2010-08-03
#> 6  2010-07-29
#> 7  2010-07-28
#> 8  2010-07-22
#> 9  2010-07-21
#> 10 2010-07-21
#> 11 2010-07-20
#> 12 2010-07-15
#> 13 2010-07-15
#> 14 2010-06-30
#> 15 2010-06-29
#> 16 2010-06-23
#> 17 2010-06-17
#> 18 2010-06-16
#> 19 2010-06-10
#> 20 2010-06-09
#>                                                               title
#> 1                                            Senate Session, Part 2
#> 2                                                    Senate Session
#> 3  Judge Porteous Impeachment Trial, Rafael Pardo Testimony, Part 2
#> 4      Judge Porteous Impeachment Trial, Claude Lightfoot Testimony
#> 5                                            Senate Session, Part 2
#> 6                                                    Senate Session
#> 7                                                    Senate Session
#> 8                                                    Senate Session
#> 9                                                    Senate Session
#> 10                                        Ambassadorial Nominations
#> 11                                           Senate Session, Part 1
#> 12                                                   Senate Session
#> 13                                               Afghanistan Issues
#> 14                                                   Senate Session
#> 15                                           Senate Session, Part 2
#> 16                                          U.S. Policy Toward Iran
#> 17                                                   Senate Session
#> 18                                           Senate Session, Part 1
#> 19                                                   Senate Session
#> 20                                 Offshore Oil Drilling Regulation
```
