
<!-- README.md is generated from README.Rmd. Please edit that file -->

# caRecall

<!-- badges: start -->

[![R-CMD-check](https://github.com/WraySmith/caRecall/workflows/R-CMD-check/badge.svg)](https://github.com/WraySmith/caRecall/actions)
[![Codecov test
coverage](https://codecov.io/gh/WraySmith/caRecall/branch/main/graph/badge.svg)](https://codecov.io/gh/WraySmith/caRecall?branch=main)
<!-- badges: end -->

The `caRecall` package is an API wrapper for the Government of Canada
[Vehicle Recalls Database
(VRD)](https://tc.api.canada.ca/en/detail?api=VRDB) used by the Defect
Investigations and Recalls Division for vehicles, tires, and child car
seats. The API wrapper provides access to recall summary information
searchable by make, model, and year range, as well as detailed recall
information searchable by recall number.

The package focuses on querying data from the VRD API to return the
following:

-   Recall summary information
-   Recall counts
-   Detailed recall information

## Installation

The development version of the `caRecall` package can be installed from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("WraySmith/caRecall")
```

## Usage

More documentation on `caRecall` can found at:
<https://wraysmith.github.io/caRecall/>

Note that an API key is required to run the functions in `caRecall` and
query the Vehicle Recalls Database. The key can be acquired at
<https://tc.api.canada.ca/en/detail?api=VRDB>.

A simple example of using the `recall_by_years()` function in the
package to return all recalls manufactured in 2000 could be done as
follows:

``` r
recall_summary_2000 <- recall_by_years(start_year = 2000, end_year = 2000, limit = 3000)
recall_summary_2000
#> # A tibble: 2,422 x 6
#>    `Recall number` `Manufacturer N~ `Model name` `Make name`  Year `Recall date`
#>    <chr>           <chr>            <chr>        <chr>       <int> <date>       
#>  1 1993076         MERCEDES-BENZ    300          MERCEDES-B~  2000 1993-05-31   
#>  2 1999056         FIAT CHRYSLER A~ NEON         CHRYSLER     2000 1999-04-14   
#>  3 1999108         FIAT CHRYSLER A~ NEON         CHRYSLER     2000 1999-06-07   
#>  4 1999111         FLEETWOOD        TIOGA        FLEETWOOD    2000 1999-06-08   
#>  5 1999137         POLARIS          SNOWMOBILE   POLARIS      2000 1999-07-26   
#>  6 1999138         MAZDA            MPV          MAZDA        2000 1999-07-27   
#>  7 1999147         MAZDA            MPV          MAZDA        2000 1999-07-30   
#>  8 1999151         GENERAL MOTORS   S10          CHEVROLET    2000 1999-08-16   
#>  9 1999151         GENERAL MOTORS   SONOMA       GMC          2000 1999-08-16   
#> 10 1999155         GENERAL MOTORS   SUNFIRE      PONTIAC      2000 1999-08-19   
#> # ... with 2,412 more rows
```

The data could then be used to summarize manufacturers with the highest
recall counts in the year:

<img src="man/figures/README-fig1-1.png" width="100%" style="display: block; margin: auto;" />

Additionally, detailed recall information can be queried from the API
using the `recall_details()` function:

``` r
recall_windstar <- recall_details(1997118)
t(recall_windstar) #transpose for readability here
#>                            [,1]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
#> RECALL_NUMBER_NUM          "1997118"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
#> MANUFACTURER_RECALL_NO_TXT "97S69"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
#> CATEGORY_ETXT              "Light Truck & Van"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
#> CATEGORY_FTXT              "Camionnette et fourgonnette"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
#> MODEL_NAME_NM              "WINDSTAR"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
#> MAKE_NAME_NM               "FORD"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
#> UNIT_AFFECTED_NBR          "27"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
#> SYSTEM_TYPE_ETXT           "Seats And Restraints"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
#> SYSTEM_TYPE_FTXT           "Sièges et dispositifs de retenue"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
#> NOTIFICATION_TYPE_ETXT     "Safety Mfr"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
#> NOTIFICATION_TYPE_FTXT     "Sécurité - fabricant"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
#> COMMENT_ETXT               "NOTE: VEHICLES EQUIPPED WITH SECOND ROW BENCH SEATS AND INTEGRATED CHILD SEAT (ICS). ALL VEHICLES IN THIS RECALL HAVE BEEN CORRECTED.\r\nTHE HEADREST LOCKOUT MECHANISM MAY NOT ENGAGE AND LOCK THE HEADRESTS IN THE \"DOWN\" POSITION, AS INTENDED WHEN THE ICS IS DEPLOYED.  CONSEQUENTLY, A VEHICLE OCCUPANT COULD MOVE THE HEADREST TO THE \"UP\" POSITION, AND AS A RESULT A CHILD IN THE ICS WOULD RECEIVE LESS THAN THE INTENDED PROTECTION IN THE CHILD HEAD AREA.\r\nCORRECTION: SECOND ROW BENCH SEATS HAVE BEEN REPLACED WITH SEATS BUILT WITH REVISED HEADREST LOCKOUT MECHANISMS."                                                                                                                      
#> COMMENT_FTXT               "NOTA : Vise les véhicules équipés d’une seconde banquette et du siège intégré pour enfant. Tous les véhicules visés par le présent rappel ont été corrigés.Il se peut que le mécanisme de verrouillage de l’appui-tête ne s’engage pas et ne bloque pas l’appui-tête dans sa position la plus basse, comme il se doit, lorsque le siège pour enfant est ouvert. En conséquence, un occupant du véhicule peut déplacer l’appui-tête vers le haut, et un enfant qui prendrait place sur le siège intégré ne recevrait pas toute la protection prévue pour la zone d’impact de la tête.Correction : La seconde banquette a été remplacée par des sièges équipés d’un nouveau mécanisme de verrouillage de l’appui-tête."
#> DATE_YEAR_CD               "1998"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
#> RECALL_DATE_DTE            "1997-06-16"
```

## Getting Help or Reporting an Issue

To report bugs/issues/feature requests, please file an
[issue](https://github.com/WraySmith/caRecall/issues).

These are very welcome!

## How to Contribute

If you would like to contribute to the package, please see our
[CONTRIBUTING](https://github.com/WraySmith/caRecall/blob/main/CONTRIBUTING.md)
guidelines.

Please note that this project is released with a [Contributor Code of
Conduct](https://github.com/WraySmith/caRecall/blob/main/CODE_OF_CONDUCT.md).
By participating in this project you agree to abide by its terms.
