rtimes
======



[![Build Status](https://api.travis-ci.org/rOpenGov/rtimes.png)](https://travis-ci.org/rOpenGov/rtimes)
[![codecov.io](https://codecov.io/github/ropengov/rtimes/coverage.svg?branch=master)](https://codecov.io/github/ropengov/rtimes?branch=master)

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
library(rtimes)
```

### Congress API


```r
out <- cg_rollcallvote(congress_no = 112, chamber = 'house', session_no = 1, rollcall_no = 00235)
out$results$votes$vote$positions[1:3]
#> [[1]]
#> [[1]]$member_id
#> [1] "A000022"
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
#> [1] "A000366"
#> 
#> [[2]]$vote_position
#> [1] "No"
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
#> [1] "No"
#> 
#> [[3]]$dw_nominate
#> [1] ""
```

### Article Search API


```r
out <- as_search(q="bailout", begin_date = "20081001", end_date = '20081201')
out$data[1:3]
#> [[1]]
#> <NYTimes article>Autoworkers Worry More Givebacks Are in Store
#>   Type: Blog
#>   Published: 2008-12-01T07:44:16Z
#>   Word count: 1109
#>   URL: http://dealbook.nytimes.com/2008/12/01/autoworkers-worry-more-givebacks-are-in-store/
#>   Snippet: Two years ago, Ron Gettelfinger, president of the United Automobile Workers union, offered a grim prognosis for the auto industry to union members at the group's convention in Las Vegas. "This isn't a cyclical downturn," Mr. Gettelfinger told the...
#> 
#> [[2]]
#> <NYTimes article>Should Taxpayers Back Tesla Motors?
#>   Type: Blog
#>   Published: 2008-12-01T07:39:17Z
#>   Word count: 1035
#>   URL: http://dealbook.nytimes.com/2008/12/01/should-taxpayers-pay-to-back-tesla-motors/
#>   Snippet: The Tesla Roadster is an electric car that goes fast, looks sensational and excites envy. But the seductive appearance, Randall Stross writes in The New York Times, obscures some inconvenient truths: its all-electric technology remains woefully...
#> 
#> [[3]]
#> <NYTimes article>Each Player in Big Three to Bring Its Own Plan
#>   Type: Blog
#>   Published: 2008-12-01T07:29:04Z
#>   Word count: 897
#>   URL: http://dealbook.nytimes.com/2008/12/01/each-player-in-big-three-to-bring-its-own-plan/
#>   Snippet: The Detroit automakers have been lumped together for decades as the Big Three, and for good reason; their goals have usually been aligned. But this week, as the automakers take a second run at Congress, hoping to persuade lawmakers to give them $25...
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
#> [1] "Copyright (c) 2013 The New York Times Company.  All Rights Reserved."
#> 
#> $meta
#>   status num_results source_database
#> 1     OK          14           slave
#> 
#> $data
#> Source: local data frame [14 x 33]
#> 
#>    concept_id geocode_id             concept_name is_times_tag
#> 1        3594        318             Aspen (Colo)            1
#> 2        5220        320            Santa Fe (NM)            1
#> 3        4980        380         Park City (Utah)            1
#> 4        5499        386              Vail (Colo)            1
#> 5        3764        556      Breckenridge (Colo)            1
#> 6        5412        599         Telluride (Colo)            1
#> 7        4672        763    Mammoth Lakes (Calif)            1
#> 8        5406        776                Taos (NM)            1
#> 9        5364        872 Steamboat Springs (Colo)            1
#> 10       4170       1109         Flagstaff (Ariz)            1
#> 11       3530       1143              Alta (Utah)            1
#> 12       5184       1441            Salida (Colo)            1
#> 13       5283       1449         Silverton (Colo)            1
#> 14      48143       2203          Snowmass (Colo)            1
#> Variables not shown: concept_type_id (int), concept_status (chr),
#>   concept_type (chr), uri_prefix (chr), geoname_id (chr), name (chr),
#>   latitude (chr), longitude (chr), elevation (chr), population (chr),
#>   country_code (chr), country_name (chr), admin_code1 (chr), admin_code2
#>   (chr), admin_code3 (chr), admin_code4 (chr), admin_name1 (chr),
#>   admin_name2 (chr), admin_name3 (chr), admin_name4 (chr), feature_class
#>   (chr), feature_class_name (chr), feature_code (chr), feature_code_name
#>   (chr), time_zone_id (chr), dst_offset (chr), gmt_offset (chr),
#>   attributionName (chr), attributionUrl (chr)
```
