rtimes
======



[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![cran checks](https://cranchecks.info/badges/worst/rtimes)](https://cranchecks.info/pkgs/rtimes)
[![Build Status](https://api.travis-ci.org/rOpenGov/rtimes.png)](https://travis-ci.org/rOpenGov/rtimes)
[![codecov.io](https://codecov.io/github/rOpenGov/rtimes/coverage.svg?branch=master)](https://codecov.io/github/rOpenGov/rtimes?branch=master)
[![rstudio mirror downloads](http://cranlogs.r-pkg.org/badges/rtimes?color=2ED968)](https://github.com/metacran/cranlogs.app)
[![cran version](http://www.r-pkg.org/badges/version/rtimes)](https://cran.r-project.org/package=rtimes)

`rtimes` is a collection of functions to search and acquire data from various New York Times APIs,
some of which now live at Propublica.

Functions in `rtimes` that wrap these APIs are prefixed by two letter acronyms fo reach API + the function name itself, e.g.: `cg` + `fxn`

* `cg` for the [Congress API](https://projects.propublica.org/api-docs/congress-api/)
* `as` for the [Article Search API](https://developer.nytimes.com/docs/articlesearch-product/1/overview)
* `cf` for the [Campaign Finance API](https://propublica.github.io/campaign-finance-api-docs)
* `geo` for the [Geographic API](https://developer.nytimes.com/docs/geo-product/1/routes/query.json/get)

Please get your own API keys at <http://developer.nytimes.com/> for `as` and `geo`
functions, and for `cg` and `cf` functions by emailing Propublica at [apihelp@propublica.org](mailto:apihelp@propublica.org).

With recent changes at NYTimes APIs, you can use the same key for all APIs

Same for Propublica, get one key to use for all their APIs.


**IMPORTANT**: NYT updated their developer portal recently - API keys with colons are no longer supported.
If you are still using the older NYT API keys with colons, you'll need to crop your current key at the first
colon. For example: `aaaaa:12:34567890` becomes `aaaaa`

---

Data from the New York Times API is provided by The New York Times.

<a border="0" href="http://developer.nytimes.com" ><img src="http://graphics8.nytimes.com/packages/images/developer/logos/poweredby_nytimes_200b.png" alt="NYT API" /></a>

And data from Propublica API is provided by Propublica

<a border="0" href="https://www.propublica.org/datastore/apis" ><img src="tools/propublica.jpg" alt="Propublica API" width="100" /></a>

I set up the functions so that you can put the key in your `.Renviron` file (or any
file on your system that holds env vars), which will be called on startup of R, and then you
don't have to enter your API key for each run of a function. Use the following env var names

* `NYTIMES_API_KEY` - for `as` and `geo` methods
* `PROPUBLICA_API_KEY` - for `cg` and `cf` methods


#### Note about full-text content

This packge only gives you access to article metadata (url, headline, byline, summary, etc.), and does not return full article content.

You can get access to full article content from 1987-2007 from UPenn for non-commercial use at <https://catalog.ldc.upenn.edu/ldc2008t19>

For commercial use, full article content can be purchased from the NYT Syndication site at <https://www.nytsyn.com/>

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
#> # A tibble: 10 x 27
#>    web_url snippet lead_paragraph print_page source multimedia keywords
#>    <chr>   <chr>   <chr>          <chr>      <chr>  <list>     <list>  
#>  1 https:… Govern… Governments s… 2          The N… <data.fra… <data.f…
#>  2 https:… The bi… The biggest t… 33         The N… <data.fra… <data.f…
#>  3 https:… How ca… How can you b… 14         The N… <data.fra… <data.f…
#>  4 https:… ProPub… "ProPublica h… <NA>       The N… <data.fra… <data.f…
#>  5 https:… The go… The governmen… <NA>       The N… <data.fra… <data.f…
#>  6 https:… If ban… If banks can … <NA>       The N… <data.fra… <data.f…
#>  7 https:… In the… In the rush t… <NA>       The N… <data.fra… <data.f…
#>  8 https:… To the… To the Editor… 28         The N… <data.fra… <data.f…
#>  9 https:… "Finan… "Finance | Th… <NA>       The N… <data.fra… <data.f…
#> 10 https:… Two lo… Two longtime … 4          The N… <data.fra… <data.f…
#> # … with 20 more variables: pub_date <chr>, document_type <chr>,
#> #   news_desk <chr>, section_name <chr>, type_of_material <chr>,
#> #   `_id` <chr>, word_count <int>, score <dbl>, uri <chr>,
#> #   subsectoinName <chr>, headline.main <chr>, headline.kicker <chr>,
#> #   headline.content_kicker <chr>, headline.print_headline <chr>,
#> #   headline.name <lgl>, headline.seo <chr>, headline.sub <chr>,
#> #   byline.original <chr>, byline.person <list>, byline.organization <chr>
```

## Campaign Finance API


```r
cf_candidate_details(campaign_cycle = 2008, fec_id = 'P80003338')
#> $status
#> [1] "OK"
#> 
#> $copyright
#> [1] "Copyright (c) 2019 ProPublica Inc. All Rights Reserved."
#> 
#> $data
#> # A tibble: 1 x 24
#>   id    name  party fec_uri committee mailing_address mailing_city
#>   <chr> <chr> <chr> <chr>   <chr>     <chr>           <chr>       
#> 1 P800… OBAM… DEM   http:/… /committ… 5450 SOUTH EAS… CHICAGO     
#> # … with 17 more variables: mailing_state <chr>, mailing_zip <chr>,
#> #   status <chr>, total_receipts <chr>, total_from_individuals <chr>,
#> #   total_from_pacs <chr>, total_contributions <chr>,
#> #   candidate_loans <chr>, total_disbursements <chr>, begin_cash <chr>,
#> #   end_cash <chr>, total_refunds <chr>, debts_owed <chr>,
#> #   date_coverage_from <chr>, date_coverage_to <chr>,
#> #   independent_expenditures <chr>, coordinated_expenditures <chr>
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
#>    concept_id concept_name geocode_id geoname_id name  latitude longitude
#>    <chr>      <chr>             <int>      <int> <chr>    <dbl>     <dbl>
#>  1 22456      Abilene (Te…       4500    4669635 Abil…     32.4     -99.7
#>  2 22460      Abingdon (V…       7752    4743815 Abin…     36.7     -82.0
#>  3 22480      Acadia Nati…       4504    4956449 Acad…     44.4     -68.3
#>  4 22508      Adirondack …       1488    5106772 Adir…     44.0     -74.5
#>  5 22548      Alabama             364    4829764 Alab…     32.8     -86.8
#>  6 22556      Alaska              292    5879092 Alas…     64.0    -150. 
#>  7 22564      Albany (NY)         464    5106834 Alba…     42.7     -73.8
#>  8 22572      Albuquerque…       1596    5454711 Albu…     35.1    -107. 
#>  9 22576      Alcatraz (S…       7772    5322901 Alca…     37.8    -122. 
#> 10 22580      Alexandria …       4008    4744091 Alex…     38.8     -77.0
#> # … with 90 more rows, and 20 more variables: elevation <int>,
#> #   population <int>, country_code <chr>, country_name <chr>,
#> #   admin_code1 <chr>, admin_code2 <chr>, admin_code3 <lgl>,
#> #   admin_code4 <lgl>, admin_name1 <chr>, admin_name2 <chr>,
#> #   admin_name3 <lgl>, admin_name4 <lgl>, feature_class <chr>,
#> #   feature_code <chr>, feature_code_name <chr>, time_zone_id <chr>,
#> #   dst_offset <dbl>, gmt_offset <dbl>, geocodes_created <chr>,
#> #   geocodes_updated <chr>
```

## Meta

* Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.
* Maintainer: Scott Chamberlain
* License: MIT
* Report any problems in the [Issues Tracker](https://github.com/ropengov/rtimes/issues), or just fork and submit changes, etc.
