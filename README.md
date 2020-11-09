
<!-- README.md is generated from README.Rmd. Please edit that file -->

# sumr

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
<!-- badges: end -->

The goal of sumr is to provide a workaround for the noisy and permissive
`dplyr::summarise()`. It’s seriously awesome and powerful\! But you can
get burned if you did not expect this behaviour.

``` r
library(dplyr)
starwars %>%
  group_by(species) %>%
  summarise(mass = mean(mass)) %>% 
  count(species)
#> `summarise()` ungrouping output (override with `.groups` argument)
#> # A tibble: 38 x 2
#>    species       n
#>    <chr>     <int>
#>  1 Aleena        1
#>  2 Besalisk      1
#>  3 Cerean        1
#>  4 Chagrian      1
#>  5 Clawdite      1
#>  6 Droid         1
#>  7 Dug           1
#>  8 Ewok          1
#>  9 Geonosian     1
#> 10 Gungan        1
#> # ... with 28 more rows

starwars %>%
  group_by(species) %>% 
  summarise(films = unique(unlist(films))) %>% 
  count(species)
#> `summarise()` regrouping output by 'species' (override with `.groups` argument)
#> # A tibble: 38 x 2
#> # Groups:   species [38]
#>    species       n
#>    <chr>     <int>
#>  1 Aleena        1
#>  2 Besalisk      1
#>  3 Cerean        3
#>  4 Chagrian      2
#>  5 Clawdite      1
#>  6 Droid         7
#>  7 Dug           1
#>  8 Ewok          1
#>  9 Geonosian     2
#> 10 Gungan        2
#> # ... with 28 more rows
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

`sumr()` checks for length-one results, but you can use `retbl()` to use
the awesome new features of `summarise()`. Because `retbl()` typically
computes a new data frame for each group, groups are kept:

``` r
starwars %>%
  group_by(species) %>% 
  retbl(films = unique(unlist(films)))
#> # A tibble: 84 x 2
#> # Groups:   species [38]
#>    species  films                  
#>    <chr>    <chr>                  
#>  1 Aleena   The Phantom Menace     
#>  2 Besalisk Attack of the Clones   
#>  3 Cerean   Attack of the Clones   
#>  4 Cerean   The Phantom Menace     
#>  5 Cerean   Revenge of the Sith    
#>  6 Chagrian Attack of the Clones   
#>  7 Chagrian The Phantom Menace     
#>  8 Clawdite Attack of the Clones   
#>  9 Droid    The Empire Strikes Back
#> 10 Droid    Attack of the Clones   
#> # ... with 74 more rows
```

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("paleolimbot/sumr")
```
