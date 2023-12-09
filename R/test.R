rm(list = ls())

library(devtools)
devtools::install_github('ooksy/latentclassification')

library(latentclassfication)

#install.packages("lsirm12pl")
library(lsirm12pl)
setwd("C://Users//SEC//Documents//latentclassfication")
data <-read.table("drv.txt", sep= " ")
n <- nrow(data)
p <- ncol(data)
lsirm_result <- lsirm2pl_o(data, ndim = 2, niter = 15000, nburn = 2500, nthin = 5, nprint = 500, jump_beta = 0.4,
                           jump_theta = 1, jump_alpha = 1, jump_gamma = 0.025, jump_z = 0.5, jump_w = 0.5, pr_mean_beta = 0,
                           pr_sd_beta = 1, pr_mean_theta = 0, pr_mean_gamma = 0.5, pr_sd_gamma = 1, pr_mean_alpha = 0.5,
                           pr_sd_alpha = 1, pr_a_theta = 0.001, pr_b_theta = 0.001, verbose = FALSE)

plot(lsirm_result$z_estimate, xlim=c(-4,4),ylim=c(-4,4), xlab = "", ylab = "")
text(lsirm_result$w_estimate[,1],lsirm_result$w_estimate[,2], label=1:24, col = "red")

latentclassfication(lsirm_result$z_estimate, lsirm_result$w_estimate, 4)

data(TDRI)
data <- TDRI
n <- nrow(data)
p <- ncol(data)
lsirm_result <- lsirm2pl_o(data, ndim = 2, niter = 5000, nburn = 200, nthin = 5, nprint = 500, jump_beta = 0.4,
                           jump_theta = 1, jump_alpha = 1, jump_gamma = 0.025, jump_z = 0.5, jump_w = 0.5, pr_mean_beta = 0,
                           pr_sd_beta = 1, pr_mean_theta = 0, pr_mean_gamma = 0.5, pr_sd_gamma = 1, pr_mean_alpha = 0.5,
                           pr_sd_alpha = 1, pr_a_theta = 0.001, pr_b_theta = 0.001, verbose = FALSE)

plot(lsirm_result$z_estimate, xlim=c(-4,4),ylim=c(-4,4), xlab = "", ylab = "")
text(lsirm_result$w_estimate[,1],lsirm_result$w_estimate[,2], label=1:24, col = "red")

latentclassfication(lsirm_result$z_estimate, lsirm_result$w_estimate, 4)
