context("mice.impute.ds.mean")

source("library.R")
opals <- login("opal-demo")

# using central data

imp <- mice(nhanes, method = "ds.mean", m = 2, maxit = 1, print = FALSE)

# using split data

nhanes_top <- nhanes[1:10, ]    # --> to server 1
nhanes_bot <- nhanes[11:25, ]   # --> to server 2

## put the login here

mean1 <- ds.mean(x = "D$LAB_TSC", datasources = opals)
# sum1 <- ds.summary(x = "D$LAB_TSC", datasources = opals)
# numNA <- ds.numNA(x = "D$LAB_TSC", datasources = opals)
# colnam <- ds.colnames(x = "D")
# dims <- ds.dim(x = "D")
# lsl <- ds.ls()
# ds.meanByClass(x='D$LAB_HDL~D$GENDER')

test_that("this is just a dummy test", expect_true(TRUE))
