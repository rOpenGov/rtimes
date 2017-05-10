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
#> # A tibble: 20 x 25
#>    congress       bill_id bill_type       number
#>       <chr>         <chr>     <chr>        <chr>
#>  1      115     s1068-115         s       S.1068
#>  2      115     s1045-115         s       S.1045
#>  3      115   sres154-115      sres    S.RES.154
#>  4      115   sres155-115      sres    S.RES.155
#>  5      115     s1035-115         s       S.1035
#>  6      115     s1025-115         s       S.1025
#>  7      115   sres153-115      sres    S.RES.153
#>  8      115     s1006-115         s       S.1006
#>  9      115      s372-115         s        S.372
#> 10      115      s708-115         s        S.708
#> 11      115      s985-115         s        S.985
#> 12      115      s980-115         s        S.980
#> 13      115      s955-115         s        S.955
#> 14      115      s954-115         s        S.954
#> 15      115      s944-115         s        S.944
#> 16      115 sconres13-115   sconres S.CON.RES.13
#> 17      115      s497-115         s        S.497
#> 18      115      s936-115         s        S.936
#> 19      115      s766-115         s        S.766
#> 20      115      s912-115         s        S.912
#> # ... with 21 more variables: bill_uri <chr>, title <chr>,
#> #   cosponsored_date <chr>, sponsor_id <chr>, sponsor_uri <chr>,
#> #   gpo_pdf_uri <chr>, congressdotgov_url <chr>, govtrack_url <chr>,
#> #   introduced_date <chr>, active <chr>, house_passage <chr>,
#> #   senate_passage <chr>, enacted <chr>, vetoed <chr>, cosponsors <chr>,
#> #   committees <chr>, primary_subject <chr>, summary <chr>,
#> #   summary_short <chr>, latest_major_action_date <chr>,
#> #   latest_major_action <chr>
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
#>    hits  time offset
#>   <int> <int>  <int>
#> 1  1209     6      0
res$data
#> # A tibble: 38 x 41
#>                                                               web_url
#>                                                                 <chr>
#>  1   https://www.nytimes.com/2008/10/05/magazine/05wwln-safire-t.html
#>  2   https://www.nytimes.com/2008/10/05/magazine/05wwln-safire-t.html
#>  3   https://www.nytimes.com/2008/10/05/magazine/05wwln-safire-t.html
#>  4   https://www.nytimes.com/2008/10/05/magazine/05wwln-safire-t.html
#>  5   https://krugman.blogs.nytimes.com/2008/10/01/bailout-narratives/
#>  6       https://economix.blogs.nytimes.com/2008/10/28/bailout-tally/
#>  7 https://www.nytimes.com/2008/11/19/business/economy/19bailout.html
#>  8 https://www.nytimes.com/2008/11/19/business/economy/19bailout.html
#>  9 https://www.nytimes.com/2008/11/19/business/economy/19bailout.html
#> 10 https://www.nytimes.com/2008/11/19/business/economy/19bailout.html
#> # ... with 28 more rows, and 40 more variables: snippet <chr>,
#> #   lead_paragraph <chr>, abstract <chr>, print_page <chr>, source <chr>,
#> #   pub_date <chr>, document_type <chr>, news_desk <chr>,
#> #   section_name <chr>, subsection_name <chr>, type_of_material <chr>,
#> #   `_id` <chr>, word_count <chr>, slideshow_credits <lgl>,
#> #   headline.main <chr>, headline.content_kicker <chr>,
#> #   headline.kicker <chr>, headline.print_headline <chr>,
#> #   byline.original <chr>, multimedia_width <chr>, multimedia_url <chr>,
#> #   multimedia_height <chr>, multimedia_subtype <chr>,
#> #   multimedia_type <chr>, multimedia_legacy.xlargewidth <chr>,
#> #   multimedia_legacy.xlarge <chr>, multimedia_legacy.xlargeheight <chr>,
#> #   multimedia_legacy.thumbnailheight <chr>,
#> #   multimedia_legacy.thumbnail <chr>,
#> #   multimedia_legacy.thumbnailwidth <chr>, keywords_rank <chr>,
#> #   keywords_is_major <chr>, keywords_name <chr>, keywords_value <chr>,
#> #   byline.person_organization <chr>, byline.person_role <chr>,
#> #   byline.person_firstname <chr>, byline.person_rank <chr>,
#> #   byline.person_lastname <chr>, byline.person_middlename <chr>
```

Another e.g., Search for keyword _money_, within the _Sports_ and _Foreign_ news desks


```r
res <- as_search(q = "money", fq = 'news_desk:("Sports" "Foreign")')
res$data
#> # A tibble: 92 x 44
#>                                                                        web_url
#>                                                                          <chr>
#>  1 https://www.nytimes.com/2017/04/04/world/americas/argentina-cristina-fernan
#>  2 https://www.nytimes.com/2017/04/04/world/americas/argentina-cristina-fernan
#>  3 https://www.nytimes.com/2017/04/04/world/americas/argentina-cristina-fernan
#>  4 https://www.nytimes.com/2017/04/04/world/americas/argentina-cristina-fernan
#>  5 https://www.nytimes.com/2017/04/04/world/americas/argentina-cristina-fernan
#>  6 https://www.nytimes.com/2017/04/04/world/americas/argentina-cristina-fernan
#>  7 https://www.nytimes.com/2017/04/04/world/americas/argentina-cristina-fernan
#>  8 https://www.nytimes.com/2017/04/04/world/americas/argentina-cristina-fernan
#>  9 https://www.nytimes.com/2017/04/04/world/americas/argentina-cristina-fernan
#> 10 https://www.nytimes.com/2017/04/04/world/americas/argentina-cristina-fernan
#> # ... with 82 more rows, and 43 more variables: snippet <chr>,
#> #   lead_paragraph <chr>, abstract <chr>, print_page <chr>, source <chr>,
#> #   pub_date <chr>, document_type <chr>, news_desk <chr>,
#> #   section_name <chr>, subsection_name <chr>, type_of_material <chr>,
#> #   `_id` <chr>, word_count <int>, slideshow_credits <lgl>,
#> #   headline.main <chr>, headline.print_headline <chr>,
#> #   headline.kicker <chr>, byline.original <chr>, multimedia_width <chr>,
#> #   multimedia_url <chr>, multimedia_rank <chr>, multimedia_height <chr>,
#> #   multimedia_subtype <chr>, multimedia_type <chr>,
#> #   multimedia_legacy.thumbnailheight <chr>,
#> #   multimedia_legacy.thumbnail <chr>,
#> #   multimedia_legacy.thumbnailwidth <chr>,
#> #   multimedia_legacy.xlargewidth <chr>, multimedia_legacy.xlarge <chr>,
#> #   multimedia_legacy.xlargeheight <chr>, multimedia_legacy.wide <chr>,
#> #   multimedia_legacy.widewidth <chr>, multimedia_legacy.wideheight <chr>,
#> #   keywords_isMajor <chr>, keywords_rank <int>, keywords_name <chr>,
#> #   keywords_value <chr>, byline.person_organization <chr>,
#> #   byline.person_role <chr>, byline.person_rank <int>,
#> #   byline.person_firstname <chr>, byline.person_lastname <chr>,
#> #   byline.person_middlename <chr>
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
