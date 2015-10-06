all: move rmd2md

move:
    cp inst/vign/rtimes_vignette.md vignettes;\
    cp inst/vign/nyt_civil_rights.md vignettes;\
    cp -r inst/vign/figure/* vignettes/figure/

rmd2md:
    cd vignettes;\
    mv rtimes_vignette.md rtimes_vignette.Rmd;\
    mv nyt_civil_rights.md nyt_civil_rights.Rmd
