context("mice.impute.ds.norm")

set.seed(1)
imp <- mice(nhanes, method = "ds.norm", print = FALSE, m = 2, maxit = 2)

