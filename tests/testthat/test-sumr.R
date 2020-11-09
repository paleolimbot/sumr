
test_that("sumr* functions work", {
  dropped <- dplyr::starwars %>%
    dplyr::group_by(species) %>%
    sumr(mass = mean(mass))

  expect_identical(
    dplyr::group_keys(dropped),
    tibble::tibble(.rows = 1)
  )

  peeled <- dplyr::starwars %>%
    dplyr::group_by(gender, species) %>%
    sumr_peel(mass = mean(mass, na.rm = TRUE))

  expect_identical(
    dplyr::group_keys(peeled),
    tibble::tibble(gender = c("feminine", "masculine", NA))
  )

  peeled_not_grouped <- dplyr::starwars %>%
    sumr_peel(mass = mean(mass, na.rm = TRUE))

  expect_identical(
    dplyr::group_keys(peeled_not_grouped),
    tibble::tibble(.rows = 1)
  )

  expect_identical(
    dplyr::group_keys(peeled),
    tibble::tibble(gender = c("feminine", "masculine", NA))
  )

  kept <- dplyr::starwars %>%
    dplyr::group_by(gender) %>%
    sumr_keep(mass = mean(mass))

  expect_identical(
    dplyr::group_keys(kept),
    tibble::tibble(gender = c("feminine", "masculine", NA))
  )

  rows <- dplyr::starwars %>%
    sumr_rowwise(mass = mean(mass))

  expect_is(rows, "rowwise_df")
})

test_that("sumr checks for length-one results", {
  expect_silent(dplyr::starwars %>% sumr(mass = 1L))
  expect_error(dplyr::starwars %>% sumr(mass = 1:2), "is not TRUE")

  expect_silent(dplyr::starwars %>% sumr_peel(mass = 1L))
  expect_error(dplyr::starwars %>% sumr_peel(mass = 1:2), "is not TRUE")

  expect_silent(dplyr::starwars %>% sumr_keep(mass = 1L))
  expect_error(dplyr::starwars %>% sumr_keep(mass = 1:2), "is not TRUE")

  expect_silent(dplyr::starwars %>% sumr_rowwise(mass = 1L))
  expect_error(dplyr::starwars %>% sumr_rowwise(mass = 1:2), "is not TRUE")
})
