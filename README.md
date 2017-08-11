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
* `as` for the [Article Search API](http://developer.nytimes.com/article_search_v2.json)
* `cf` for the [Campaign Finance API](https://propublica.github.io/campaign-finance-api-docs)
* `geo` for the [Geographic API](http://developer.nytimes.com/geo_api_v2.json)

Please get your own API keys at <http://developer.nytimes.com/> for `as` and `geo` 
functions, and for `cg` and `cf` functions by emailing Propublica at [apihelp@propublica.org](mailto:apihelp@propublica.org). 

You'll need a different key for each API of the Nytimes APIs, but only one key for the Propublica
APIs

Data from the New York Times API is provided by The New York Times.

<a border="0" href="http://developer.nytimes.com" ><img src="http://graphics8.nytimes.com/packages/images/developer/logos/poweredby_nytimes_200b.png" alt="NYT API" /></a>

And data from Propublica API is provided by Propublica

<a border="0" href="https://www.propublica.org/datastore/apis" ><img src="tools/propublica.jpg" alt="Propublica API" width="100" /></a>

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
#>      category yes no present not_voting majority_position
#> 1  democratic 194  0       0          9               Yes
#> 2  republican 219  1       0          6               Yes
#> 3 independent   1  0       0          0              <NA>
#> 4       total 414  1       0         15              <NA>
```

## Article Search API


```r
x <- as_search(q = "bailout", begin_date = "20081001", end_date = '20081201')
x$data
#> # A tibble: 10 x 19
#>                                                                        web_url
#>  *                                                                       <chr>
#>  1 https://dealbook.nytimes.com/2008/10/17/nader-displays-new-fervor-on-the-ba
#>  2              https://dealbook.nytimes.com/2008/10/07/its-the-economy-redux/
#>  3                https://www.nytimes.com/2008/12/01/opinion/l01citigroup.html
#>  4             https://www.nytimes.com/2008/12/01/business/economy/01auto.html
#>  5                    https://www.nytimes.com/2008/12/01/business/01tanta.html
#>  6                      https://www.nytimes.com/2008/12/01/business/01uaw.html
#>  7         https://www.nytimes.com/2008/12/01/business/economy/01stimulus.html
#>  8                      https://www.nytimes.com/2008/11/30/opinion/30sun1.html
#>  9                    https://www.nytimes.com/2008/11/30/opinion/30boskin.html
#> 10                   https://www.nytimes.com/2008/11/30/business/30dealer.html
#> # ... with 18 more variables: snippet <chr>, abstract <chr>, source <chr>,
#> #   multimedia <list>, keywords <list>, pub_date <chr>,
#> #   document_type <chr>, section_name <chr>, type_of_material <chr>,
#> #   `_id` <chr>, word_count <int>, score <dbl>, print_page <chr>,
#> #   new_desk <chr>, headline.main <chr>, headline.kicker <chr>,
#> #   headline.print_headline <chr>, byline.original <chr>
```

## Campaign Finance API


```r
cf_candidate_details(campaign_cycle = 2008, fec_id = 'P80003338')
#> $status
#> [1] "OK"
#> 
#> $copyright
#> [1] "Copyright (c) 2017 ProPublica Inc. All Rights Reserved."
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
geo_search(country_code = "US")
#> $copyright
#> [1] "Copyright (c) 2015 The New York Times Company.  All Rights Reserved."
#> 
#> $meta
#>   status num_results
#> 1     OK         100
#> 
#> $data
#> # A tibble: 100 x 27
#>    concept_id              concept_name geocode_id geoname_id
#>  *      <chr>                     <chr>      <int>      <int>
#>  1      22456             Abilene (Tex)       4500    4669635
#>  2      22460             Abingdon (Va)       7752    4743815
#>  3      22480 Acadia National Park (Me)       4504    4956449
#>  4      22508 Adirondack Mountains (NY)       1488    5106772
#>  5      22548                   Alabama        364    4829764
#>  6      22556                    Alaska        292    5879092
#>  7      22564               Albany (NY)        464    5106834
#>  8      22572          Albuquerque (NM)       1596    5454711
#>  9      22576  Alcatraz (San Francisco)       7772    5322901
#> 10      22580           Alexandria (Va)       4008    4744091
#> # ... with 90 more rows, and 23 more variables: name <chr>,
#> #   latitude <dbl>, longitude <dbl>, elevation <int>, population <int>,
#> #   country_code <chr>, country_name <chr>, admin_code1 <chr>,
#> #   admin_code2 <chr>, admin_code3 <lgl>, admin_code4 <lgl>,
#> #   admin_name1 <chr>, admin_name2 <chr>, admin_name3 <lgl>,
#> #   admin_name4 <lgl>, feature_class <chr>, feature_code <chr>,
#> #   feature_code_name <chr>, time_zone_id <chr>, dst_offset <dbl>,
#> #   gmt_offset <dbl>, geocodes_created <chr>, geocodes_updated <chr>
```

## Meta

* Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.
* Maintainer: Scott Chamberlain
* License: MIT
* Report any problems in the [Issues Tracker](https://github.com/ropengov/rtimes/issues), or just fork and submit changes, etc.
