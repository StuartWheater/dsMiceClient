context("mice.impute.ds.mean")

source("library.R")
opals <- login()

# using central data

imp1 <- mice(nhanes, method = "ds.mean", m = 2, maxit = 1, print = FALSE)

# using federated data

nhanes_NA <- 0 * nhanes
imp2 <- mice(nhanes_NA, method = "ds.mean", m = 2, maxit = 1,
             print = TRUE, remove.constant = FALSE,
             datasources = opals)

test_that("combined and federated mean imputes are equivalent", {
  expect_identical(imp1$imp, imp2$imp)
})
