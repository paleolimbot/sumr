
<!-- README.md is generated from README.Rmd. Please edit that file -->

# sumr

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
<!-- badges: end -->

The goal of sumr is to provide a workaround for the currently very noisy
`dplyr::summarise()`:

``` r
library(dplyr)
summarised <- starwars %>%
  group_by(species) %>%
  summarise(mass = mean(mass))
#> `summarise()` ungrouping output (override with `.groups` argument)
```

You can silence this message using `options(dplyr.summarise.inform =
FALSE)`. If you’d rather not write this at the top of every script, you
can use this package to make the grouping of your result explicit with
roughly the same number of characters:

``` r
library(sumr)

# drops grouping
starwars %>%
  group_by(species) %>%
  sumr(mass = mean(mass))
#> # A tibble: 38 x 2
#>    species    mass
#>    <chr>     <dbl>
#>  1 Aleena       15
#>  2 Besalisk    102
#>  3 Cerean       82
#>  4 Chagrian     NA
#>  5 Clawdite     55
#>  6 Droid        NA
#>  7 Dug          40
#>  8 Ewok         20
#>  9 Geonosian    80
#> 10 Gungan       NA
#> # ... with 28 more rows

# peels back one layer of grouping per call
starwars %>%
  group_by(gender, species) %>%
  sumr_peel(mass = mean(mass, na.rm = TRUE)) %>%
  sumr_peel(mass = mean(mass, na.rm = TRUE))
#> # A tibble: 3 x 2
#>   gender     mass
#>   <chr>     <dbl>
#> 1 feminine   54.4
#> 2 masculine 124. 
#> 3 <NA>       48

# keeps current grouping
starwars %>%
  group_by(species) %>%
  sumr_keep(mass = mean(mass))
#> # A tibble: 38 x 2
#> # Groups:   species [38]
#>    species    mass
#>    <chr>     <dbl>
#>  1 Aleena       15
#>  2 Besalisk    102
#>  3 Cerean       82
#>  4 Chagrian     NA
#>  5 Clawdite     55
#>  6 Droid        NA
#>  7 Dug          40
#>  8 Ewok         20
#>  9 Geonosian    80
#> 10 Gungan       NA
#> # ... with 28 more rows
```

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("paleolimbot/sumr")
```
