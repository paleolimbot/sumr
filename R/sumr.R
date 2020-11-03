
#' Summarise with explicit group structure
#'
#' Use the superpowered [dplyr::summarise()] with explicit
#' grouping.
#'
#' @inheritParams dplyr::summarise
#'
#' @export
#'
#' @examples
#' library(dplyr, warn.conflicts = FALSE)
#'
#' # default drops grouping after sumr
#' starwars %>%
#'   group_by(species) %>%
#'   sumr(mass = mean(mass))
#'
#' # can peel back grouping structure
#' # with each sumr_peel()
#' starwars %>%
#'   group_by(gender, species) %>%
#'   sumr_peel(mass = mean(mass, na.rm = TRUE)) %>%
#'   sumr_peel(mass = mean(mass, na.rm = TRUE))
#'
#' # can also keep grouping structure
#' starwars %>%
#'   group_by(species) %>%
#'   sumr_keep(mass = mean(mass))
#'
sumr <- function(.data, ...) {
  dplyr::summarise(.data, ..., .groups = "drop")
}

#' @rdname sumr
#' @export
sumr_keep <- function(.data, ...) {
  dplyr::summarise(.data, ..., .groups = "keep")
}

#' @rdname sumr
#' @export
sumr_peel <- function(.data, ...) {
  dplyr::summarise(.data, ..., .groups = "drop_last")
}

#' @rdname sumr
#' @export
sumr_rowwise <- function(.data, ...) {
  dplyr::summarise(.data, ..., .groups = "rowwise")
}
