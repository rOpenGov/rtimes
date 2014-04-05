all:
		make move
		make pandoc
		make rmd2md
		make cleanup

vignettes: 
		cd inst/vign;\
		Rscript -e 'library(knitr); knit("rtimes_vignette.Rmd")'

move:
		cp inst/vign/rtimes_vignette.md vignettes

pandoc:
		cd vignettes;\
		pandoc -H margins.sty rtimes_vignette.md -o rtimes_vignette.pdf --highlight-style=tango;\
		pandoc -H margins.sty rtimes_vignette.md -o rtimes_vignette.html --highlight-style=tango

rmd2md:
		cd vignettes;\
		cp rtimes_vignette.md rtimes_vignette.Rmd

cleanup:
		cd vignettes;\
		rm -rf figure