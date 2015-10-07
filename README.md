rtimes
======



[![Build Status](https://api.travis-ci.org/rOpenGov/rtimes.png)](https://travis-ci.org/rOpenGov/rtimes)
[![codecov.io](https://codecov.io/github/rOpenGov/rtimes/coverage.svg?branch=master)](https://codecov.io/github/rOpenGov/rtimes?branch=master)
[![rstudio mirror downloads](http://cranlogs.r-pkg.org/badges/rtimes?color=2ED968)](https://github.com/metacran/cranlogs.app)

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

## Installation

From CRAN


```r
install.packages("rtimes")
```

Development version from GitHub


```r
install.packages("devtools")
devtools::install_github("ropengov/rtimes")
```


```r
library("rtimes")
```

## Congress API


```r
out <- cg_rollcallvote(congress_no = 105, chamber = 'house', session_no = 2, rollcall_no = 38)
out$votes
#> Source: local data frame [4 x 6]
#> 
#>     yes    no present not_voting majority_position       label
#>   (chr) (chr)   (chr)      (chr)             (chr)       (chr)
#> 1   194     0       0          9               Yes  democratic
#> 2   219     1       0          6               Yes  republican
#> 3     1     0       0          0                NA independent
#> 4   414     1       0         15                NA       total
```

## Article Search API


```r
out <- as_search(q = "bailout", begin_date = "20081001", end_date = '20081201')
out$data[1:2]
#> [[1]]
#> <NYTimes article>Toxic Bailout
#>   Type: News
#>   Published: 2008-10-05T00:00:00Z
#>   Word count: 913
#>   URL: http://www.nytimes.com/2008/10/05/magazine/05wwln-safire-t.html
#>   Snippet: How can you be naked wearing shorts?
#> 
#> [[2]]
#> <NYTimes article>Bailout narratives
#>   Type: Blog
#>   Published: 2008-10-01T10:08:26Z
#>   Word count: 440
#>   URL: http://krugman.blogs.nytimes.com/2008/10/01/bailout-narratives/
#>   Snippet: There seem to be two prevailing narratives about the bailout plan(s). Both have elements of truth, but are fundamentally wrong. One narrative is that of the Wise Men and the Destructive Yahoos. According to this narrative, men who Understand What...
```

## Campaign Finance API


```r
res <- cf_candidate_details(campaign_cycle = 2008, fec_id = 'P80003338')
res$data
#> Source: local data frame [2 x 19]
#> 
#>   cycle.id cycle.fecid                       cycle.name cycle.party
#>      (chr)       (chr)                            (chr)       (chr)
#> 1     2896   P80003338 /BIDEN, JOSEPH R., OBAMA, BARACK         DEM
#> 2    50162   P80003338 /BIDEN, JOSEPH R., OBAMA, BARACK         DEM
#> Variables not shown: cycle.status (chr), cycle.address_one (chr),
#>   cycle.address_two (chr), cycle.city (chr), cycle.state (chr), cycle.zip
#>   (chr), cycle.fec_committee_id (chr), cycle.cycle (chr), cycle.district
#>   (chr), cycle.office_state (chr), cycle.cand_status (chr), cycle.branch
#>   (chr), relative_uri (chr), cycle.created_at (chr), cycle.updated_at
#>   (chr)
```

## Geographic API


```r
geo_search(elevation = '2000_3000', feature_class = 'P')
#> $copyright
#> [1] "Copyright (c) 2015 The New York Times Company.  All Rights Reserved."
#> 
#> $meta
#>   status num_results
#> 1     OK         100
#> 
#> $data
#> Source: local data frame [100 x 27]
#> 
#>    concept_id          concept_name geocode_id geoname_id          name
#>         (chr)                 (chr)      (int)      (int)         (chr)
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
#> ..        ...                   ...        ...        ...           ...
#> Variables not shown: latitude (dbl), longitude (dbl), elevation (int),
#>   population (int), country_code (chr), country_name (chr), admin_code1
#>   (chr), admin_code2 (chr), admin_code3 (chr), admin_code4 (chr),
#>   admin_name1 (chr), admin_name2 (chr), admin_name3 (chr), admin_name4
#>   (chr), feature_class (chr), feature_code (chr), feature_code_name (chr),
#>   time_zone_id (chr), dst_offset (dbl), gmt_offset (dbl), geocodes_created
#>   (chr), geocodes_updated (chr)
```

## Meta

+ Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.
+ Maintainer: Scott Chamberlain
+ License: MIT
+ Report any problems in the [Issues Tracker](https://github.com/ropengov/rtimes/issues), or just fork and submit changes, etc.
