# set up vcr
library("vcr")
invisible(vcr::vcr_configure(
  dir = "../fixtures",
  filter_sensitive_data = list(
    "<<nytimes_api_key>>" = Sys.getenv("NYTIMES_API_KEY"),
    "<<propublica_api_key>>" = Sys.getenv("PROPUBLICA_API_KEY")
  )
))
