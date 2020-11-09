
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
  sum <- dplyr::summarise(.data, ..., .groups = "keep")
  assert_groups_are_rows(sum)
  dplyr::ungroup(sum)
}

#' @rdname sumr
#' @export
sumr_keep <- function(.data, ...) {
  sum <- dplyr::summarise(.data, ..., .groups = "keep")
  assert_groups_are_rows(sum)
  dplyr::group_by(sum, !!! dplyr::groups(.data))
}

#' @rdname sumr
#' @export
sumr_peel <- function(.data, ...) {
  sum <- dplyr::summarise(.data, ..., .groups = "keep")
  assert_groups_are_rows(sum)
  groups <- dplyr::groups(.data)
  dplyr::group_by(sum, !!! utils::head(groups, length(groups) - 1))
}

#' @rdname sumr
#' @export
sumr_rowwise <- function(.data, ...) {
  sum <- dplyr::summarise(.data, ..., .groups = "keep")
  assert_groups_are_rows(sum)
  dplyr::rowwise(sum)
}

assert_groups_are_rows <- function(x) {
  stopifnot(all(dplyr::group_size(x) == 1L))
}
