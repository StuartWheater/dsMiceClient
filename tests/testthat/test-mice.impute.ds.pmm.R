
set.seed(1)
imp <- mice(nhanes, method = "ds.pmm", print = FALSE, m = 2, maxit = 2)

