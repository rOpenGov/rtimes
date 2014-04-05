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
* `dis` for the Districs API
* `geo` for the Geographic API

Please get your own API keys if you plant to use these functions for Sunlight Labs (http://services.sunlightlabs.com/) and New York Times (http://developer.nytimes.com/apps/register).

Data from the New York Times API is provided by The New York Times.

<a border="0" href="http://developer.nytimes.com" ><img src="http://graphics8.nytimes.com/packages/images/developer/logos/poweredby_nytimes_200b.png" alt="NYT API" /></a>

I set up the functions so that you can put the key in your .Rprofile file, which will be called on startup of R, and then you don't have to enter your API key for each run of a function. For example, put this in your .Rprofile file:

```
# key for API access to the Sunlight Labs API methods
options(NYTCongressKey = "YOURKEYHERE")
```

## Quick start

### Installation

```coffee
install_github("ropengov/rtimes")
library(rtimes)
```

### Congress API

```coffee

```

```coffee

```

### Article Search API

```coffee

```

```coffee

```

### Campaign Finance API

```coffee

```

```coffee

```

### Districs API

```coffee

```

```coffee

```

### Geographic API

```coffee

```

```coffee

```