rtimes
======



[![Build Status](https://api.travis-ci.org/rOpenGov/rtimes.png)](https://travis-ci.org/rOpenGov/rtimes)
[![codecov.io](https://codecov.io/github/rOpenGov/rtimes/coverage.svg?branch=master)](https://codecov.io/github/rOpenGov/rtimes?branch=master)
[![rstudio mirror downloads](http://cranlogs.r-pkg.org/badges/rtimes?color=2ED968)](https://github.com/metacran/cranlogs.app)
[![cran version](http://www.r-pkg.org/badges/version/rtimes)](https://cran.r-project.org/package=rtimes)

`rtimes` is a collection of functions to search and acquire data from various New York Times APIs,
some of which now live at Propublica.

Functions in `rtimes` that wrap these APIs are prefixed by two letter acronyms fo reach API + the function name itself, e.g.: `cg` + `fxn`

* `cg` for the [Congress API](https://propublica.github.io/congress-api-docs)
* `as` for the [Article Search API](http://developer.nytimes.com/docs/read/article_search_api_v2)
* `cf` for the [Campaign Finance API](https://propublica.github.io/campaign-finance-api-docs)
* `geo` for the [Geographic API](http://developer.nytimes.com/docs/geographic_api)

Please get your own API keys at <http://developer.nytimes.com/apps/register> for `as` and `geo` 
functions, and for `cg` and `cf` functions by emailing Propublica at [apihelp@propublica.org](mailto:apihelp@propublica.org). 

You'll need a different key for each API of the Nytimes APIs, but only one key for the Propublica
APIs

Data from the New York Times API is provided by The New York Times.

<a border="0" href="http://developer.nytimes.com" ><img src="http://graphics8.nytimes.com/packages/images/developer/logos/poweredby_nytimes_200b.png" alt="NYT API" /></a>

And data from Propublica API is provided by Propublica

xxxx

I set up the functions so that you can put the key in your `.Renviron` file (or any
file on your system that holds env vars), which will be called on startup of R, and then you 
don't have to enter your API key for each run of a function. Use the following env var names 

* `NYTIMES_GEO_KEY` - for `geo` methods
* `NYTIMES_AS_KEY` - for `as` methods
* `PROPUBLICA_API_KEY` - for `cg` and `cf` methods

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
#> # A tibble: 4 x 6
#>      category   yes    no present not_voting majority_position
#>         <chr> <chr> <chr>   <chr>      <chr>             <chr>
#> 1  democratic   194     0       0          9               Yes
#> 2  republican   219     1       0          6               Yes
#> 3 independent     1     0       0          0              <NA>
#> 4       total   414     1       0         15              <NA>
```

## Article Search API


```r
x <- as_search(q = "bailout", begin_date = "20081001", end_date = '20081201')
x$data[1:3]
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
#> <NYTimes article>Bailout to Nowhere
#>   Type: Op-Ed
#>   Published: 2008-11-14T00:00:00Z
#>   Word count: 820
#>   URL: http://www.nytimes.com/2008/11/14/opinion/14brooks.html
#>   Snippet: The biggest threat to a healthy economy is the politically powerful capitalists who use their influence to create a stagnant corporate welfare state.
```

## Campaign Finance API


```r
cf_candidate_details(campaign_cycle = 2008, fec_id = 'P80003338')
#> $status
#> [1] "OK"
#> 
#> $copyright
#> [1] "Copyright (c) 2016 ProPublica Inc. All Rights Reserved."
#> 
#> $data
#> # A tibble: 1 x 24
#>          id          name party
#>       <chr>         <chr> <chr>
#> 1 P80003338 OBAMA, BARACK   DEM
#> # ... with 21 more variables: fec_uri <chr>, committee <chr>,
#> #   mailing_address <chr>, mailing_city <chr>, mailing_state <chr>,
#> #   mailing_zip <chr>, status <chr>, total_receipts <chr>,
#> #   total_from_individuals <chr>, total_from_pacs <chr>,
#> #   total_contributions <chr>, candidate_loans <chr>,
#> #   total_disbursements <chr>, begin_cash <chr>, end_cash <chr>,
#> #   total_refunds <chr>, debts_owed <chr>, date_coverage_from <chr>,
#> #   date_coverage_to <chr>, independent_expenditures <chr>,
#> #   coordinated_expenditures <chr>
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
#> # A tibble: 100 x 27
#>    concept_id          concept_name geocode_id geoname_id          name
#>         <chr>                 <chr>      <int>      <int>         <chr>
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
#> # ... with 90 more rows, and 22 more variables: latitude <dbl>,
#> #   longitude <dbl>, elevation <int>, population <int>,
#> #   country_code <chr>, country_name <chr>, admin_code1 <chr>,
#> #   admin_code2 <chr>, admin_code3 <chr>, admin_code4 <chr>,
#> #   admin_name1 <chr>, admin_name2 <chr>, admin_name3 <chr>,
#> #   admin_name4 <chr>, feature_class <chr>, feature_code <chr>,
#> #   feature_code_name <chr>, time_zone_id <chr>, dst_offset <dbl>,
#> #   gmt_offset <dbl>, geocodes_created <chr>, geocodes_updated <chr>
```

## Meta

+ Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.
+ Maintainer: Scott Chamberlain
+ License: MIT
+ Report any problems in the [Issues Tracker](https://github.com/ropengov/rtimes/issues), or just fork and submit changes, etc.
