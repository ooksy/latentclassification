library(devtools)
devtools::install_github('ooksy/latentclassification')
library(latentclassfication)

#install.packages("lsirm12pl")
library(lsirm12pl)
load(drv)
data <-read.table("drv.txt", sep= " ")
n <- nrow(data)
p <- ncol(data)
lsirm_result <- lsirm2pl_o(data, ndim = 2, niter = 100, nburn = 20, nthin = 5, nprint = 500, jump_beta = 0.4,
                           jump_theta = 1, jump_alpha = 1, jump_gamma = 0.025, jump_z = 0.5, jump_w = 0.5, pr_mean_beta = 0,
                           pr_sd_beta = 1, pr_mean_theta = 0, pr_mean_gamma = 0.5, pr_sd_gamma = 1, pr_mean_alpha = 0.5,
                           pr_sd_alpha = 1, pr_a_theta = 0.001, pr_b_theta = 0.001, verbose = FALSE)


latentclassfication(lsirm_result$z_estimate, lsirm_result$w_estimate, 4)

