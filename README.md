# Latentclassification : tools for classification of item response data in the latent space.

When analyzing the result of latent space item response model, it is important to look at the components of latent space. In latent space, there are respondents and items. One of the goals to fit a latent space item respons model is to see the interactions and relationships between respondents group and item group.

By setting the dimension of unobserved space 2, we can visualize and observe the interaction between respondents and items. In this package, we provide an easy tool that can visualize latent space. First, we starts with the kmeans clustering and provide silhouette plot so we can determine the number of group. Also, this plot package provides the results of other classification methods such as hierarchical clustering and PCA.

## Installation

```{r install, tidy='formatR',eval=FALSE, echo=TRUE}
devtools::install_github("ooksy/latentclassification")
```

## Usage

```{r attach, echo=T, results='hide', message=F, warning=F, tidy='formatR'}
library(latentclassification)
```


### 1. Start with the item response data

Load the data.
You can find it in my R package and download.
If you cannot, you can just use toy example I made which is below this readme file.

```{r conversion, tidy='formatR', tidy.opts=list(width.cutoff = 70),cache=T}
# load data from package
data <-read.table("drv.txt", sep= " ")
n <- nrow(data)
p <- ncol(data)
```

### 2. Fitting the latent space item response data using lsirm12pl

To fit a latent space item response model, you should download the lsirm12pl package.

```{r interp data, tidy='formatR', tidy.opts=list(width.cutoff = 70),echo=FALSE,results='hide',cache=TRUE}
# Install lsirm12pl package
install.packages("lsirm12pl")
library(lsirm12pl)
```

We can decide dimension to be 2 or 3 to visualize latent space by setting ndim as 2 or 3.
Here we will make just 2 dimensional plot.
niter is number of iteration, nburn is discarded mcmc, nthin is the number of thining in mcmc.
jump_parameter means the amount of jump when you do mcmc. pr_paramaeters are about the prior values.

```{r interp func, tidy='formatR', tidy.opts=list(width.cutoff = 70),cache=T}
# Fitting the model
lsirm_result <- lsirm2pl_o(data, ndim = 2, niter = 1000, nburn = 200, nthin = 5, nprint = 500, jump_beta = 0.4,
                           jump_theta = 1, jump_alpha = 1, jump_gamma = 0.025, jump_z = 0.5, jump_w = 0.5, pr_mean_beta = 0,
                           pr_sd_beta = 1, pr_mean_theta = 0, pr_mean_gamma = 0.5, pr_sd_gamma = 1, pr_mean_alpha = 0.5,
                           pr_sd_alpha = 1, pr_a_theta = 0.001, pr_b_theta = 0.001, verbose = FALSE)

# Getting the result
lsirm_result$z_estimate
lsirm_result$w_estimate
```

Here we need to get the values of z and w estimate. we can get the result using the code above.
z_estimate is the estimate of the latent values of respondents. z_estimate is nx2 matrix.
w_estimate is the estimate of the latent values of items. w_estimate is px2 matrix.
Here we need to do classify item values. 
Items are carefully designed to measure specific ability. So knowing what number of items measures similar things is important. 

### 3. Drawing a plot

Using latentclassfication function, you can plot respondents and items in the latent space.
Also, the plot reflects the kmeans result of items. Plot also gives silhouette plot to help decide the number of clusters.
Function also gives plots of PCA and hierarchical clustering.

```{r bbox, tidy='formatR', tidy.opts=list(width.cutoff = 70),cache=T}
# Create a plot
latentclassfication(lsirm_result$z_estimate, lsirm_result$w_estimate, 4)
```

### 4. Doing with toy example

Above all process can be complicated.
You can make a toy example and run a function.
z and w should be matrice that have 2 columns.
Here I just intentionally made 4 groups of w.

```{r bbox, tidy='formatR', tidy.opts=list(width.cutoff = 70),cache=T}
# Create a toy example
z <- cbind(rnorm(200, 0, 1), rnorm(200, 0, 1))
w1 <- cbind(rnorm(5, mean = 1, sd = 0.1), rnorm(5, mean = 1, sd = 0.1))
w2 <- cbind(rnorm(10, mean = 1, sd = 0.1), rnorm(10, mean = -1, sd = 0.1))
w3 <- cbind(rnorm(5, mean = -1, sd = 0.1), rnorm(5, mean = 1, sd = 0.1))
w4 <- cbind(rnorm(10, mean = -1, sd = 0.1), rnorm(10, mean = -1, sd = 0.1))
w <- rbind(w1, w2, w3, w4)

# Draw a plot
latentclassification(z, w, 4)
```


## Details

For more information on latentclassfication Package, please feel free to contact the author.
