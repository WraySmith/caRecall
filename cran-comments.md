## Test environments
* local Windows 10 install, R 4.0.3
* ubuntu 20.04 (release) on GitHub Actions, R 4.0.3
* ubuntu 20.04 (devel) on GitHub Actions, R 4.0.3
* MacOS 10.15.7 on GitHub Actions, R 4.0.3
* win-builder (devel and release)
* R-hub (various)

## R CMD check results
* 0 ERRORs
* 0 WARNINGs
* 1 NOTE - this is a new release 

Special note: This package is an API wrapper. The particular API 
requires users to use their own API key. I cannot run function 
examples or unit tests on CRAN, but all examples and unit tests 
run successfully in multiple other environments, on local and 
remote systems. Full test suite also runs on Github Actions where 
I am able to import an encrypted key. API key-dependent vignettes 
are precompiled for CRAN.

## Downstream dependencies
There are currently no downstream dependencies for
this package.