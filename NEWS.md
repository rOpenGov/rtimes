rtimes 0.4.0
===============

### NEW FEATURES 

* `as_search` gains new parameter `all_results` to internally 
paginate to get all results. In addition, user can optionally
have the function attempt to flatten completely the output 
data.frame, but sometimes may fail so isn't turned on by 
default (#15)

### MINOR IMPROVEMENTS

* Now API keys have to be stored as environment variables instead
of options (#12)
* Campaign and Congress APIs moved to Propublica. Updated base URLs, etc
for the move, but many routes still not covered. (#13)
* Replace `dplyr::rbind_all` with `dplyr::bind_rows` (#14)


rtimes 0.3.0
===============

### NEW FEATURES 

* released to CRAN
