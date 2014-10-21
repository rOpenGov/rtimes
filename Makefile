all: move rmd2md

move:
		cp inst/vign/rtimes_vignette.md vignettes

rmd2md:
		cd vignettes;\
		mv rtimes_vignette.md rtimes_vignette.Rmd
