require(dsBaseClient)
require(mice)

# using central data

imp <- mice(nhanes, method = "ds.mean", m = 2, maxit = 1, print = FALSE)

# using split data

nhanes_top <- nhanes[1:10, ]    # --> to server 1
nhanes_bot <- nhanes[11:25, ]   # --> to server 2

## put the login here

# means_of_age <- ds.mean(x = "age", datasources = c("server1 and server 2"))
# means_of_chl <- ds.mean(x = "chl", na.rm = TRUE, datasources = c("server1 and server 2"))

test_that("this is just a dummy test", expect_true(TRUE))
