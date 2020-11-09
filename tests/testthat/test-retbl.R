
test_that("retbl* functions work", {
  kept <- dplyr::starwars %>%
    dplyr::group_by(gender) %>%
    retbl(mass = mean(mass))

  expect_identical(
    dplyr::group_keys(kept),
    tibble::tibble(gender = c("feminine", "masculine", NA))
  )

  dropped <- dplyr::starwars %>%
    dplyr::group_by(species) %>%
    retbl_drop(mass = mean(mass))

  expect_identical(
    dplyr::group_keys(dropped),
    tibble::tibble(.rows = 1)
  )

  peeled <- dplyr::starwars %>%
    dplyr::group_by(gender, species) %>%
    retbl_peel(mass = mean(mass, na.rm = TRUE))

  expect_identical(
    dplyr::group_keys(peeled),
    tibble::tibble(gender = c("feminine", "masculine", NA))
  )

  peeled_not_grouped <- dplyr::starwars %>%
    retbl_peel(mass = mean(mass, na.rm = TRUE))

  expect_identical(
    dplyr::group_keys(peeled_not_grouped),
    tibble::tibble(.rows = 1)
  )

  expect_identical(
    dplyr::group_keys(peeled),
    tibble::tibble(gender = c("feminine", "masculine", NA))
  )

  rows <- dplyr::starwars %>%
    retbl_rowwise(mass = mean(mass))

  expect_is(rows, "rowwise_df")
})

test_that("retbl allows any length result", {
  expect_silent(dplyr::starwars %>% retbl(mass = 1:2))
  expect_silent(dplyr::starwars %>% retbl_drop(mass = 1:2))
  expect_silent(dplyr::starwars %>% retbl_peel(mass = 1:2))
  expect_silent(dplyr::starwars %>% retbl_rowwise(mass = 1:2))
})
