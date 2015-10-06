<!--
%\VignetteEngine{knitr::knitr}
%\VignetteIndexEntry{rtimes vignette}
%\VignetteEncoding{UTF-8}
-->



rtimes vignette - R client for New York Times APIs
======

## About the package

`rtimes` is an R package to search and retrieve data from the New York Times congress API. 

Functions in `rtimes` that wrap these APIs are prefixed by two letter acronyms fo reach API + the function name itself, e.g.: `cg` + `fxn`

* `cg` for the [Congress API](http://developer.nytimes.com/docs/congress_api)
* `as` for the [Article Search API](http://developer.nytimes.com/docs/read/article_search_api_v2)
* `cf` for the [Campaign Finance API](http://developer.nytimes.com/docs/campaign_finance_api/)
* `geo` for the [Geographic API](http://developer.nytimes.com/docs/geographic_api)

Please get your own API keys at http://developer.nytimes.com/apps/register - you'll need a different key for each API.

We set up the functions so that you can put the key in your `.Rprofile` file, which will be called on startup of R, and then you don't have to enter your API key for each run of a function. For example, put these entries in your `.Rprofile` file:

```
options(nytimes_cg_key = "YOURKEYHERE")
options(nytimes_as_key = "YOURKEYHERE")
options(nytimes_cf_key = "YOURKEYHERE")
options(nytimes_geo_key = "YOURKEYHERE")
```

## Install rtimes

From CRAN


```r
install.packages("rtimes")
```

Development version from GitHub


```r
install.packages("devtools")
devtools::install_github("ropengov/rtimes")
```

## Load rtimes


```r
library('rtimes')
```

_Note: Member ID S001181 is Jeanne Shaheen_

## Congress API 

There are currently 11 functions to work with the congress API

* `cg_billscosponsor`
* `cg_memberappear`
* `cg_memberbioroles`
* `cg_memberbystatedistrict`
* `cg_membersleaving`
* `cg_memberslist`
* `cg_membersponsorcompare`
* `cg_membervotecompare`
* `cg_membervotepositions`
* `cg_newmembers`
* `cg_rollcallvote`

### Bill cosponsorship data for a member


```r
out <- cg_billscosponsor(memberid='S001181', type='cosponsored')
out$data
#> Source: local data frame [20 x 11]
#> 
#>    congress    number
#>       (chr)     (chr)
#> 1       114    S.2126
#> 2       114    S.2110
#> 3       114    S.2101
#> 4       114     S.812
#> 5       114    S.2089
#> 6       114    S.2075
#> 7       114 S.RES.269
#> 8       114 S.RES.267
#> 9       114    S.1169
#> 10      114    S.1911
#> 11      114 S.RES.262
#> 12      114     S.423
#> 13      114     S.524
#> 14      114 S.RES.257
#> 15      114 S.RES.259
#> 16      114    S.2035
#> 17      114    S.1831
#> 18      114    S.1559
#> 19      114    S.1503
#> 20      114 S.RES.242
#> Variables not shown: bill_uri (chr), title (chr), cosponsored_date (chr),
#>   sponsor_id (chr), introduced_date (chr), cosponsors (chr), committees
#>   (chr), latest_major_action_date (chr), latest_major_action (chr)
```

### Member appearances


```r
out <- cg_memberappear(memberid='S001181')
out$data
#> Source: local data frame [20 x 5]
#> 
#>          date
#>         (chr)
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
#> Variables not shown: title (chr), url (chr), start_time (chr), end_time
#>   (chr)
```

## Article search API

This function in most cases outputs a series of S3 objects, one for each item 
found. Each element, an object of class `as_search`, is a summary of a list
of data. You can `unclass()` the object if you want, or index into particular
elements (see egs below).

Here, we search for _bailout_ between two dates, Oct 1 2008 and Dec 1 2008


```r
res <- as_search(q="bailout", begin_date = "20081001", end_date = '20081201')
res$copyright # copyright
#> [1] "Copyright (c) 2015 The New York Times Company.  All Rights Reserved."
res$meta # number of hits
#>   hits time offset
#> 1 1210   26      0
res$data[[1]]
#> <NYTimes article>Toxic Bailout
#>   Type: News
#>   Published: 2008-10-05T00:00:00Z
#>   Word count: 913
#>   URL: http://www.nytimes.com/2008/10/05/magazine/05wwln-safire-t.html
#>   Snippet: How can you be naked wearing shorts?
res$data[[1]]$snippet
#> [1] "How can you be naked wearing shorts?"
```

Another e.g., Search for keyword _money_, within the _Sports_ and _Foreign_ news desks


```r
res <- as_search(q = "money", fq = 'news_desk:("Sports" "Foreign")')
res$data[1:3]
#> [[1]]
#> <NYTimes article>Switzerland Investigates Fund Executives in Malaysian Scandal
#>   Type: News
#>   Published: 2015-09-03T00:00:00Z
#>   Word count: 485
#>   URL: http://www.nytimes.com/2015/09/03/world/asia/switzerland-investigates-fund-executives-in-malaysian-corruption-case.html
#>   Snippet: The Attorney General’s Office said it had begun an inquiry into two executives of an investment fund at the center of a scandal in which Malaysia’s prime minister is suspected of misconduct.
#> 
#> [[2]]
#> <NYTimes article>Ukraine: U.S. Judge Tosses Tymoshenko Lawsuit
#>   Type: Brief
#>   Published: 2015-09-19T00:00:00Z
#>   Word count: 161
#>   URL: http://www.nytimes.com/2015/09/19/world/europe/ukraine-us-judge-tosses-tymoshenko-lawsuit.html
#>   Snippet: A federal judge in Manhattan on Friday dismissed a civil lawsuit filed by Yulia V. Tymoshenko, the former Ukrainian prime minister and presidential candidate.
#> 
#> [[3]]
#> <NYTimes article>Romanian Prime Minister to Face Corruption Trial
#>   Type: News
#>   Published: 2015-09-18T00:00:00Z
#>   Word count: 297
#>   URL: http://www.nytimes.com/2015/09/18/world/europe/romanian-prime-minister-to-face-corruption-trial.html
#>   Snippet: Prime Minister Victor Ponta is accused of forgery, money laundering and being an accessory to tax evasion, and will face charges in Romania’s top court.
```

## Campaign Finance API

There are currently two functions to work with the campaign finance API

* `cf_candidate_details`
* `cf_candidate_leaders`

Here, we search for campaign details for the 2008 cycle, with FEC ID number P80003338


```r
cf_candidate_details(campaign_cycle = 2008, fec_id = 'P80003338')
#> $status
#> [1] "OK"
#> 
#> $copyright
#> [1] "Copyright (c) 2015 The New York Times Company. All Rights Reserved."
#> 
#> $meta
#>          id          name party
#> 1 P80003338 OBAMA, BARACK   DEM
#>                                             fec_uri
#> 1 http://docquery.fec.gov/cgi-bin/fecimg/?P80003338
#>                    committee           mailing_address mailing_city
#> 1 /committees/C00431445.json 5450 SOUTH EAST VIEW PARK      CHICAGO
#>   mailing_state mailing_zip status total_receipts total_from_individuals
#> 1            IL       60615      O    778642962.3            664872382.3
#>   total_from_pacs total_contributions candidate_loans total_disbursements
#> 1           12925         664886457.3               0         760370195.4
#>   begin_cash    end_cash total_refunds debts_owed date_coverage_from
#> 1          0 18272367.39     5755955.2   434954.4         2007-01-01
#>   date_coverage_to independent_expenditures coordinated_expenditures
#> 1       2008-12-31              110078819.6                        0
#> 
#> $data
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

The geographic API allows you to do geo based searches of place names. It's built on
the Geonames database.

Here, we search for results for locations in the US


```r
geo_search(country_code = 'US')
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
#> 4       28084          Pennsylvania        172    6254927  Pennsylvania
#> 5       26916         Massachusetts        180    6254926 Massachusetts
#> 6       27740                  Ohio        188    5165418          Ohio
#> 7       30096              Virginia        208    6254928      Virginia
#> 8       28808 San Francisco (Calif)        212    5391959 San Francisco
#> 9       25908                  Iowa        228    4862182          Iowa
#> 10      22828               Arizona        232    5551752       Arizona
#> ..        ...                   ...        ...        ...           ...
#> Variables not shown: latitude (dbl), longitude (dbl), elevation (int),
#>   population (int), country_code (chr), country_name (chr), admin_code1
#>   (chr), admin_code2 (chr), admin_code3 (lgl), admin_code4 (lgl),
#>   admin_name1 (chr), admin_name2 (chr), admin_name3 (lgl), admin_name4
#>   (lgl), feature_class (chr), feature_code (chr), feature_code_name (chr),
#>   time_zone_id (chr), dst_offset (dbl), gmt_offset (dbl), geocodes_created
#>   (chr), geocodes_updated (chr)
```
