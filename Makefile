all: move rmd2md

.PHONY: move rmd2md

move:
	cp inst/vign/rtimes_vignette.md vignettes;\
	cp inst/vign/nyt_civil_rights.md vignettes

rmd2md:
	cd vignettes;\
	mv rtimes_vignette.md rtimes_vignette.Rmd;\
	mv nyt_civil_rights.md nyt_civil_rights.Rmd
