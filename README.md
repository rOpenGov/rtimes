rtimes
======

[![Build Status](https://api.travis-ci.org/rOpenGov/rtimes.png)](https://travis-ci.org/rOpenGov/rtimes)

+ Maintainer: Scott Chamberlain
+ License: MIT
+ Report any problems in the [Issues Tracker](https://github.com/ropengov/rtimes/issues), or just fork and submit changes, etc.

## Description

`rtimes` is a collection of functions to search and acquire data from the New York Times Congress API at http://developer.nytimes.com/docs/congress_api.

Functions that wrap these sets of APIs are prefixed by two letter acronyms fo reach API endpoint + the function name itself as for example `cg` + `fxn`

* `cg` for the Congress API
* `as` for the Article Search API
* `cf` for the Campaign Finance API
* `geo` for the Geographic API

Please get your own API keys at http://developer.nytimes.com/apps/register - you'll need a different key for each API.

Data from the New York Times API is provided by The New York Times.

<a border="0" href="http://developer.nytimes.com" ><img src="http://graphics8.nytimes.com/packages/images/developer/logos/poweredby_nytimes_200b.png" alt="NYT API" /></a>

I set up the functions so that you can put the key in your .Rprofile file, which will be called on startup of R, and then you don't have to enter your API key for each run of a function. For example, put these entries in your .Rprofile file:

```
options(nytimes_cg_key = "YOURKEYHERE")
options(nytimes_as_key = "YOURKEYHERE")
options(nytimes_cf_key = "YOURKEYHERE")
options(nytimes_geo_key = "YOURKEYHERE")
```

## Quick start

### Installation

```coffee
install_github("ropengov/rtimes")
library(rtimes)
```

### Congress API

```coffee
out <- cg_rollcallvote(congress_no = 112, chamber = 'house', session_no = 1, rollcall_no = 00235)
out$results$votes$vote$positions[1:3]
```

```coffee
[[1]]
[[1]]$member_id
[1] "A000022"

[[1]]$vote_position
[1] "Yes"

[[1]]$dw_nominate
[1] ""


[[2]]
[[2]]$member_id
[1] "A000366"

[[2]]$vote_position
[1] "No"

[[2]]$dw_nominate
[1] ""


[[3]]
[[3]]$member_id
[1] "A000055"

[[3]]$vote_position
[1] "No"

[[3]]$dw_nominate
[1] ""
```

### Article Search API

```coffee
out <- as_search(q="bailout", begin_date = "20081001", end_date = '20081201')
out$response$docs[[1]]$lead_paragraph
```

```coffee
[1] "The economic bailout package contains an assortment of benefits for consumers. It more than doubles the amount of insurance backing bank deposits and protects millions of taxpayers from paying the more onerous alternative minimum tax. It includes perks for green-minded consumers and puts mental health coverage on an even footing with physical health benefits."
```

### Campaign Finance API

```coffee
cf_candidate_details(campaign_cycle = 2008, fec_id = 'P80003338')
```

```coffee
$status
[1] "OK"

$copyright
[1] "Copyright (c) 2014 The New York Times Company. All Rights Reserved."

$base_uri
[1] "http://api.nytimes.com/svc/elections/us/v3/finances/2008/"

$cycle
[1] 2008

$results
$results[[1]]
$results[[1]]$id
[1] "P80003338"

$results[[1]]$name
[1] "OBAMA, BARACK"

$results[[1]]$party
[1] "DEM"

$results[[1]]$district
NULL

$results[[1]]$fec_uri
[1] "http://docquery.fec.gov/cgi-bin/fecimg/?P80003338"

$results[[1]]$committee
[1] "/committees/C00431445.json"

$results[[1]]$state
NULL

$results[[1]]$mailing_address
[1] "5450 SOUTH EAST VIEW PARK"

$results[[1]]$mailing_city
[1] "CHICAGO"

$results[[1]]$mailing_state
[1] "IL"

$results[[1]]$mailing_zip
[1] "60615"

$results[[1]]$status
[1] "O"

$results[[1]]$total_receipts
[1] 778642962

$results[[1]]$total_from_individuals
[1] 664872382

$results[[1]]$total_from_pacs
[1] 12925

$results[[1]]$total_contributions
[1] 664886457

$results[[1]]$candidate_loans
[1] 0

$results[[1]]$total_disbursements
[1] 760370195

$results[[1]]$begin_cash
[1] 0

$results[[1]]$end_cash
[1] 18272367

$results[[1]]$total_refunds
[1] 5755955

$results[[1]]$debts_owed
[1] 434954.4

$results[[1]]$date_coverage_from
[1] "2007-01-01"

$results[[1]]$date_coverage_to
[1] "2008-12-31"

$results[[1]]$independent_expenditures
[1] 92122585

$results[[1]]$coordinated_expenditures
[1] 6606695

$results[[1]]$other_cycles
list()
```

### Geographic API

```coffee
out <- geo_search(elevation = '2000_3000', feature_class='P')
out$results[[1]]
```

```coffee
$concept_id
[1] 3594

$geocode_id
[1] 318

$concept_name
[1] "Aspen (Colo)"

$is_times_tag
[1] 1

$concept_type_id
[1] 2

$concept_status
[1] "Active"

$concept_type
[1] "nytd_geo"

$uri_prefix
[1] "0"

$geocode
$geocode$geocode_id
[1] 318

$geocode$geoname_id
[1] 5412230

$geocode$name
[1] "Aspen"

$geocode$latitude
[1] 39.1911

$geocode$longitude
[1] -106.8175

$geocode$elevation
[1] 2405

$geocode$population
[1] 5760

$geocode$country_code
[1] "US"

$geocode$country_name
[1] "United States"

$geocode$admin_code1
[1] "CO"

$geocode$admin_code2
[1] "097"

$geocode$admin_code3
NULL

$geocode$admin_code4
NULL

$geocode$admin_name1
[1] "Colorado"

$geocode$admin_name2
[1] "Pitkin County"

$geocode$admin_name3
NULL

$geocode$admin_name4
NULL

$geocode$feature_class
[1] "P"

$geocode$feature_class_name
[1] "city, village,..."

$geocode$feature_code
[1] "PPL"

$geocode$feature_code_name
[1] "populated place"

$geocode$time_zone_id
[1] "America/Denver"

$geocode$dst_offset
[1] -6

$geocode$gmt_offset
[1] -7

$geocode$attributionName
[1] "GeoNames"

$geocode$attributionUrl
[1] "http://geonames.org"
```