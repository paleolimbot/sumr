
#' Re-tibble by group
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
#' # default keeps grouping after sumr
#' starwars %>%
#'   group_by(species) %>%
#'   retbl(film = unique(unlist(films)))
#'
retbl <- function(.data, ...) {
  dplyr::summarise(.data, ..., .groups = "keep")
}

#' @rdname retbl
#' @export
retbl_drop <- function(.data, ...) {
  dplyr::summarise(.data, ..., .groups = "drop")
}

#' @rdname retbl
#' @export
retbl_peel <- function(.data, ...) {
  dplyr::summarise(.data, ..., .groups = "drop_last")
}

#' @rdname retbl
#' @export
retbl_rowwise <- function(.data, ...) {
  dplyr::summarise(.data, ..., .groups = "rowwise")
}
