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

* `cg` for the [Congress API](https://propublica.github.io/congress-api-docs)
* `as` for the [Article Search API](http://developer.nytimes.com/article_search_v2.json)
* `cf` for the [Campaign Finance API](https://propublica.github.io/campaign-finance-api-docs)
* `geo` for the [Geographic API](http://developer.nytimes.com/geo_api_v2.json)

Please get your own API keys at http://developer.nytimes.com/apps/register - you'll need a different key for each API.

I set up the functions so that you can put the key in your `.Renviron` file, which will
be called on startup of R, and then you don't have to enter your API key for each run
of a function. Add entries for an R session like

```
Sys.setenv(NYTIMES_GEO_KEY = "YOURKEYHERE")
Sys.setenv(NYTIMES_AS_KEY = "YOURKEYHERE")
Sys.setenv(PROPUBLICA_API_KEY = "YOURKEYHERE")
```

Or set them across sessions by putting entries in your `.Renviron` file like

```
NYTIMES_GEO_KEY=<yourkey>
NYTIMES_AS_KEY=<yourkey>
PROPUBLICA_API_KEY=<yourkey>
```

You can also pass in your key in a function call, but be careful not to expose your keys in
code committed to public repositories. If you do pass in a function call, use e.g., `Sys.getenv("NYTIMES_GEO_KEY")`.

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

### Bill cosponsorship data for a member


```r
out <- cg_billscosponsor(memberid='S001181', type='cosponsored')
out$data
#> # A tibble: 20 x 26
#>    congress     bill_id bill_type    number
#>       <chr>       <chr>     <chr>     <chr>
#>  1      115    s756-115         s     S.756
#>  2      115   s1616-115         s    S.1616
#>  3      115   s1738-115         s    S.1738
#>  4      115    s581-115         s     S.581
#>  5      115   s1710-115         s    S.1710
#>  6      115   s1715-115         s    S.1715
#>  7      115   s1726-115         s    S.1726
#>  8      115   s1730-115         s    S.1730
#>  9      115   s1706-115         s    S.1706
#> 10      115   s1692-115         s    S.1692
#> 11      115   s1693-115         s    S.1693
#> 12      115   s1688-115         s    S.1688
#> 13      115 sres241-115      sres S.RES.241
#> 14      115   s1675-115         s    S.1675
#> 15      115   s1654-115         s    S.1654
#> 16      115 sres234-115      sres S.RES.234
#> 17      115   s1640-115         s    S.1640
#> 18      115 sres233-115      sres S.RES.233
#> 19      115   s1629-115         s    S.1629
#> 20      115 sres230-115      sres S.RES.230
#> # ... with 22 more variables: bill_uri <chr>, title <chr>,
#> #   cosponsored_date <chr>, sponsor_title <chr>, sponsor_id <chr>,
#> #   sponsor_name <chr>, sponsor_state <chr>, sponsor_party <chr>,
#> #   sponsor_uri <chr>, gpo_pdf_uri <chr>, congressdotgov_url <chr>,
#> #   govtrack_url <chr>, introduced_date <chr>, active <lgl>,
#> #   senate_passage <chr>, cosponsors <int>, committees <chr>,
#> #   primary_subject <chr>, summary <chr>, summary_short <chr>,
#> #   latest_major_action_date <chr>, latest_major_action <chr>
```

### Member appearances


```r
out <- cg_memberappear(memberid='S001181')
out$data
#> # A tibble: 20 x 5
#>          date
#>         <chr>
#>  1 2010-09-29
#>  2 2010-09-22
#>  3 2010-09-17
#>  4 2010-09-16
#>  5 2010-08-03
#>  6 2010-07-29
#>  7 2010-07-28
#>  8 2010-07-22
#>  9 2010-07-21
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
#> # ... with 4 more variables: title <chr>, url <chr>, start_time <chr>,
#> #   end_time <chr>
```

## Article search API

This function in most cases outputs a series of S3 objects, one for each item
found. Each element, an object of class `as_search`, is a summary of a list
of data. You can `unclass()` the object if you want, or index into particular
elements (see egs below).

Here, we search for _bailout_ between two dates, Oct 1 2008 and Dec 1 2008


```r
res <- as_search(q="bailout", begin_date = "20081001", end_date = '20081201')
res$copyright
#> [1] "Copyright (c) 2015 The New York Times Company.  All Rights Reserved."
res$meta
#> # A tibble: 1 x 3
#>    hits offset  time
#>   <int>  <int> <int>
#> 1  1203      0     8
res$data
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



Another e.g., Search for keyword _money_, within the _Sports_ and _Foreign_ news desks


```r
res <- as_search(q = "money", fq = 'news_desk:("Sports" "Foreign")')
res$data
#> # A tibble: 10 x 19
#>                                                                        web_url
#>  *                                                                       <chr>
#>  1 https://www.nytimes.com/2017/06/16/world/asia/1mdb-malaysia-najib-razak.htm
#>  2 https://www.nytimes.com/2017/07/28/sports/football/giants-odell-beckham-con
#>  3     https://www.nytimes.com/2017/08/04/sports/soccer/neymar-psg-soccer.html
#>  4 https://www.nytimes.com/2017/08/10/sports/soccer/soccer-capital-lure-of-lon
#>  5 https://www.nytimes.com/2017/07/19/world/europe/grenfell-tower-fire-donatio
#>  6 https://www.nytimes.com/2017/07/12/sports/basketball/the-two-men-who-make-m
#>  7 https://www.nytimes.com/2017/06/24/world/africa/angola-luanda-jose-eduardo-
#>  8 https://www.nytimes.com/2017/08/04/sports/soccer/wolverhampton-jorge-mendes
#>  9 https://www.nytimes.com/2017/06/15/sports/soccer/fifa-jorge-luis-arzuaga-pl
#> 10 https://www.nytimes.com/2017/06/26/sports/tennis/itf-pro-circuit-wozniak-st
#> # ... with 18 more variables: snippet <chr>, print_page <chr>,
#> #   source <chr>, multimedia <list>, keywords <list>, pub_date <chr>,
#> #   document_type <chr>, new_desk <chr>, section_name <chr>,
#> #   type_of_material <chr>, `_id` <chr>, word_count <int>, score <dbl>,
#> #   uri <chr>, headline.main <chr>, headline.print_headline <chr>,
#> #   headline.kicker <chr>, byline.original <chr>
```

## Campaign Finance API


Here, we search for campaign details for the 2008 cycle, with FEC ID number P80003338


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
