rtimes
======



[![Build Status](https://api.travis-ci.org/rOpenGov/rtimes.png)](https://travis-ci.org/rOpenGov/rtimes)
[![codecov.io](https://codecov.io/github/rOpenGov/rtimes/coverage.svg?branch=master)](https://codecov.io/github/rOpenGov/rtimes?branch=master)
[![rstudio mirror downloads](http://cranlogs.r-pkg.org/badges/rtimes?color=2ED968)](https://github.com/metacran/cranlogs.app)
[![cran version](http://www.r-pkg.org/badges/version/rtimes)](http://cran.rstudio.com/web/packages/rtimes)

+ Maintainer: Scott Chamberlain
+ License: MIT
+ Report any problems in the [Issues Tracker](https://github.com/ropengov/rtimes/issues), or just fork and submit changes, etc.

## Description

`rtimes` is a collection of functions to search and acquire data from various New York Times APIs.

Functions in `rtimes` that wrap these APIs are prefixed by two letter acronyms fo reach API + the function name itself, e.g.: `cg` + `fxn`

* `cg` for the [Congress API](http://developer.nytimes.com/docs/congress_api)
* `as` for the [Article Search API](http://developer.nytimes.com/docs/read/article_search_api_v2)
* `cf` for the [Campaign Finance API](http://developer.nytimes.com/docs/campaign_finance_api/)
* `geo` for the [Geographic API](http://developer.nytimes.com/docs/geographic_api)

Please get your own API keys at http://developer.nytimes.com/apps/register - you'll need a different key for each API.

Data from the New York Times API is provided by The New York Times.

<a border="0" href="http://developer.nytimes.com" ><img src="http://graphics8.nytimes.com/packages/images/developer/logos/poweredby_nytimes_200b.png" alt="NYT API" /></a>

I set up the functions so that you can put the key in your `.Rprofile` file, which will be called on startup of R, and then you don't have to enter your API key for each run of a function. For example, put these entries in your `.Rprofile` file:

```
options(nytimes_cg_key = "YOURKEYHERE")
options(nytimes_as_key = "YOURKEYHERE")
options(nytimes_cf_key = "YOURKEYHERE")
options(nytimes_geo_key = "YOURKEYHERE")
```

## Quick start

### Installation


```r
install.packages("devtools")
devtools::install_github("ropengov/rtimes")
```


```r
library("rtimes")
```

### Congress API


```r
out <- cg_rollcallvote(congress_no = 105, chamber = 'house', session_no = 2, rollcall_no = 38)
#> Error in cg_rollcallvote(congress_no = 105, chamber = "house", session_no = 2, : server error: (504) Gateway Timeout
out$results$votes$vote$positions[1:3]
#> [[1]]
#> [[1]]$member_id
#> [1] "A000014"
#> 
#> [[1]]$vote_position
#> [1] "Yes"
#> 
#> [[1]]$dw_nominate
#> [1] ""
#> 
#> 
#> [[2]]
#> [[2]]$member_id
#> [1] "A000022"
#> 
#> [[2]]$vote_position
#> [1] "Yes"
#> 
#> [[2]]$dw_nominate
#> [1] ""
#> 
#> 
#> [[3]]
#> [[3]]$member_id
#> [1] "A000055"
#> 
#> [[3]]$vote_position
#> [1] "Yes"
#> 
#> [[3]]$dw_nominate
#> [1] ""
```

### Article Search API


```r
out <- as_search(q="bailout", begin_date = "20081001", end_date = '20081201')
out$data[1:3]
#> [[1]]
#> <NYTimes article>Toxic Bailout
#>   Type: News
#>   Published: 2008-10-05T00:00:00Z
#>   Word count: 913
#>   URL: http://www.nytimes.com/2008/10/05/magazine/05wwln-safire-t.html
#>   Snippet: How can you be naked wearing shorts?
#> 
#> [[2]]
#> <NYTimes article>Bailout (and Buildup)
#>   Type: Op-Ed
#>   Published: 2008-10-22T00:00:00Z
#>   Word count: 810
#>   URL: http://www.nytimes.com/2008/10/22/opinion/22friedman.html
#>   Snippet: We can’t afford a financial bailout that also isn’t a green buildup — a buildup of a new clean energy industry that strengthens America.
#> 
#> [[3]]
#> <NYTimes article>Bailout narratives
#>   Type: Blog
#>   Published: 2008-10-01T10:08:26Z
#>   Word count: 440
#>   URL: http://krugman.blogs.nytimes.com/2008/10/01/bailout-narratives/
#>   Snippet: There seem to be two prevailing narratives about the bailout plan(s). Both have elements of truth, but are fundamentally wrong. One narrative is that of the Wise Men and the Destructive Yahoos. According to this narrative, men who Understand What...
```

### Campaign Finance API


```r
res <- cf_candidate_details(campaign_cycle = 2008, fec_id = 'P80003338')
res$results[[1]][1:4]
#> $id
#> [1] "P80003338"
#> 
#> $name
#> [1] "OBAMA, BARACK"
#> 
#> $party
#> [1] "DEM"
#> 
#> $district
#> NULL
```

### Geographic API


```r
geo_search(elevation = '2000_3000', feature_class='P')
#> $copyright
#> [1] "Copyright (c) 2015 The New York Times Company.  All Rights Reserved."
#> 
#> $meta
#>   status num_results
#> 1     OK          20
#> 
#> $data
#> Source: local data frame [20 x 27]
#> 
#>    concept_id          concept_name geocode_id geoname_id          name
#> 1       26660   Los Angeles (Calif)        132    5368361   Los Angeles
#> 2       27500      New Orleans (La)        148    4335045   New Orleans
#> 3       24084         Chicago (Ill)        160    4887398       Chicago
#> 4       27988        Paris (France)        196    2988507         Paris
#> 5       28808 San Francisco (Calif)        212    5391959 San Francisco
#> 6       23464         Boston (Mass)        240    4930956        Boston
#> 7       25760             Hong Kong        288    1819729     Hong Kong
#> 8       26636      London (England)        308    2643743        London
#> 9       23196       Beijing (China)        312    1816670       Beijing
#> 10      24576        Detroit (Mich)        328    4990729       Detroit
#> 11      26488       Las Vegas (Nev)        352    5506956     Las Vegas
#> 12      27008           Miami (Fla)        356    4164138         Miami
#> 13      25788         Houston (Tex)        396    4699066       Houston
#> 14      28132     Philadelphia (Pa)        436    4560349  Philadelphia
#> 15      22564           Albany (NY)        464    5106834        Albany
#> 16      22912          Atlanta (Ga)        472    4180439       Atlanta
#> 17      23284      Berlin (Germany)        476    2950159        Berlin
#> 18      29720         Tokyo (Japan)        484    1850147         Tokyo
#> 19      29016        Seattle (Wash)        496    5809844       Seattle
#> 20      27764              Oklahoma        500    4544349 Oklahoma City
#> Variables not shown: latitude (dbl), longitude (dbl), elevation (int),
#>   population (int), country_code (chr), country_name (chr), admin_code1
#>   (chr), admin_code2 (chr), admin_code3 (chr), admin_code4 (chr),
#>   admin_name1 (chr), admin_name2 (chr), admin_name3 (chr), admin_name4
#>   (chr), feature_class (chr), feature_code (chr), feature_code_name (chr),
#>   time_zone_id (chr), dst_offset (dbl), gmt_offset (dbl), geocodes_created
#>   (chr), geocodes_updated (chr)
```
