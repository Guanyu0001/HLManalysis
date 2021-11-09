a <- as.factor(c(rep(1, 10), rep(2, 10)))
b <- as.numeric(c(rep(1, 10), rep(-1, 10)))
test_data1 <- data.frame(a, b)

testthat::test_that("Summary Table Testing", {
  testthat::expect_equal(sum(as.numeric(unlist(level2summarize(test_data1, a, b)[, 2]))), nrow(na.omit(test_data1))) # check the sample size
  testthat::expect_s3_class(level2summarize(test_data1, a, b), "data.frame") # check the type of output
  testthat::expect_length(level2summarize(test_data1, a, b), 8 * !is.null(test_data1)) # check the length of output
})



a <- as.factor(c(rep(1, 10), rep(2, 10)))
b <- as.numeric(c(rep(1, 10), rep(-1, 10)))
b[1] <- NA
test_data2 <- data.frame(a, b)
testthat::test_that("Summary Table Testing2", {
  testthat::expect_true(all(grepl("\\d+", level2summarize(test_data2, a, b)[, -1]))) # check the output should be numeric besides the first column
})

a <- numeric(0)
b <- numeric(0)
test_data3 <- data.frame(a, b)
testthat::test_that("Summary Table Testing3", {
  testthat::expect_error(level2summarize(test_data3, a, b)) # check the error
})


rm(test_data1, test_data2, test_data3)
