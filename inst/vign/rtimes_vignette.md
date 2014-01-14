<!--
%\VignetteEngine{knitr}
%\VignetteIndexEntry{rtimes vignette}
-->

rtimes vignette - Interface to the New York Times APIs for government data.
======

### About the package

`rtimes` is an R package to search and retrieve data from the New York Times congress API. 


#### Install rtimes


```r
install.packages("devtools")
library(devtools)
install_github("rtimes", "ropengov")
```


********************

#### Load rtimes


```r
library(rtimes)
```


*Note: Member ID S001181 is Jeanne Shaheen*

#### Get bill cosponsorship data for a particular member.


```r
out <- nyt_cg_billscosponsor(memberid = "S001181", type = "cosponsored")
ldply(out$results[[1]]$bills, function(x) data.frame(x[c("number", "cosponsors")]))
```

```
      number cosponsors
1     S.1174         23
2     S.1452         13
3     S.1349         23
4     S.1467         17
5     S.1460          9
6     S.1708          8
7     S.1886          5
8     S.1406         39
9     S.1633          8
10 S.RES.318          8
11 S.RES.314          2
12     S.666         35
13    S.1837          9
14     S.313         61
15    S.1802         10
16 S.RES.321         99
17    S.1826          9
18    S.1187         19
19     S.641         14
20    S.1766          1
```


#### Get information about a particular member's appearances on the House or Senate floor.


```r
library(plyr)
out <- nyt_cg_memberappear(memberid = "S001181")
ldply(out$results[[1]]$appearances, function(x) data.frame(x[c("date", "title")]))
```

```
         date
1  2010-09-29
2  2010-09-22
3  2010-09-17
4  2010-09-16
5  2010-08-03
6  2010-07-29
7  2010-07-28
8  2010-07-22
9  2010-07-21
10 2010-07-21
11 2010-07-20
12 2010-07-15
13 2010-07-15
14 2010-06-30
15 2010-06-29
16 2010-06-23
17 2010-06-17
18 2010-06-16
19 2010-06-10
20 2010-06-09
                                                              title
1                                            Senate Session, Part 2
2                                                    Senate Session
3  Judge Porteous Impeachment Trial, Rafael Pardo Testimony, Part 2
4      Judge Porteous Impeachment Trial, Claude Lightfoot Testimony
5                                            Senate Session, Part 2
6                                                    Senate Session
7                                                    Senate Session
8                                                    Senate Session
9                                                    Senate Session
10                                        Ambassadorial Nominations
11                                           Senate Session, Part 1
12                                                   Senate Session
13                                               Afghanistan Issues
14                                                   Senate Session
15                                           Senate Session, Part 2
16                                          U.S. Policy Toward Iran
17                                                   Senate Session
18                                           Senate Session, Part 1
19                                                   Senate Session
20                                 Offshore Oil Drilling Regulation
```

