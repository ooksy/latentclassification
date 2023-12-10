z1 <- cbind(rnorm(10, 0, 1),rnorm(10, 0, 1))
w1 <- 1

z2 <- 1
w2 <- cbind(rnorm(10, 0, 1),rnorm(10, 0, 1))

z <- cbind(rnorm(200, 0, 1), rnorm(200, 0, 1))
w1 <- cbind(rnorm(5, mean = 1, sd = 0.1), rnorm(5, mean = 1, sd = 0.1))
w2 <- cbind(rnorm(10, mean = 1, sd = 0.1), rnorm(10, mean = -1, sd = 0.1))
w3 <- cbind(rnorm(5, mean = -1, sd = 0.1), rnorm(5, mean = 1, sd = 0.1))
w4 <- cbind(rnorm(10, mean = -1, sd = 0.1), rnorm(10, mean = -1, sd = 0.1))
w <- rbind(w1, w2, w3, w4)

test_that("tests on error message", {
  expect_message(latentclassification(z1, w1, 4), "dimension of both z and w should be 2")
})

test_that("tests on error message", {
  expect_message(latentclassification(z2, w2, 4), "dimension of both z and w should be 2")
})

test_that("tests on error message", {
  expect_message(latentclassification(z, w, 0), "n_cluster should be at least 2")
})

test_that("tests on error message", {
  expect_message(latentclassification(z, w, 1), "n_cluster should be at least 2")
})

test_that("tests on error message", {
  expect_message(latentclassification(z, w, -1), "n_cluster should be at least 2")
})
