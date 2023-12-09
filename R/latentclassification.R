#' Latentclassification
#'
#' Help doing classification in the latent space and drawing a plot.
#'
#' @param z z estimate from lsirm12pl function. It's nx2 matrix
#' @param w w estimate from lsirm12pl function. It's px2 matrix
#' @param n_cluster number of cluster. It's constant
#'
#' @examples
#' latentclassification(z, w, 4)
#'
#'
#' @return set of plots
#' @export
latentclassification <- function(z, w, n_cluster){
  n <- nrow(z)
  p <- nrow(w)


  # 1. kmeans clustering
  kmeans_result <- stats::kmeans(w, centers = n_cluster, iter.max = 100, nstart = 1, algorithm = c("Hartigan-Wong", "Lloyd", "Forgy", "MacQueen"), trace=FALSE)
  labs <- 1:p
  kmeans_result$cluster
  colorlab <- kmeans_result$cluster + 1

  zdat <- as.data.frame(z)
  wdat <- cbind(w, labs, kmeans_result$cluster, colorlab)
  wdat <- as.data.frame(wdat)

  p1 <-ggplot2::ggplot() +
    ggplot2::ggtitle("Latent Space Plot") +
    ggplot2::xlab("Z[, 1], W[, 1]") + ggplot2::ylab("Z[, 2], W[, 2]") +
    ggplot2::geom_point(data = zdat, ggplot2::aes(zdat[, 1], zdat[, 2])) +
    ggplot2::geom_text(data = wdat, ggplot2::aes(wdat[, 1], wdat[, 2], color = as.factor(wdat[, 5])), label = wdat[, 3]) +
    ggplot2::theme(legend.title = ggplot2::element_blank()) +
    ggplot2::theme(legend.position = 'none') +
    ggforce::geom_mark_circle(data = wdat, ggplot2::aes(wdat[, 1], wdat[, 2], color = as.factor(wdat[, 5])))


  # 2. Silhouette plot for kmeans result
  df <- as.data.frame(scale(w))

  sil_width <- purrr::map_dbl(2:10,  function(k){
    model <- cluster::pam(x = df, k = k)
    model$silinfo$avg.width
  })
  # Generate a data frame containing both k and sil_width
  sil_df <- data.frame(
    k = 2:10,
    sil_width = sil_width
  )
  # Plot the relationship between k and sil_width
  p2 <- ggplot2::ggplot(sil_df, ggplot2::aes(x = sil_df$k, y = sil_width)) +
          ggplot2::ggtitle("Silhouette Plot") +
          ggplot2::geom_line() + ggplot2::geom_point() +
          ggplot2::scale_x_continuous(breaks = 2:10)


  # 3. PCA
  pr_result <- stats::prcomp(w)
  pcadat <- as.data.frame(pr_result$x[, 1:2])
  pcadat <- cbind(pcadat, labs, kmeans_result$cluster)
  colnames(pcadat) <- c("PC1", "PC2", "Labs", "Cluster")
  p3 <- ggplot2::ggplot(pcadat) +
    ggplot2::ggtitle("PCA Plot") +
    ggplot2::aes(pcadat$PC1, pcadat$PC2, color = pcadat$Cluster) +
    ggplot2::geom_text(label = pcadat[, 3], color = as.factor(pcadat[, 4])) +
    ggplot2::coord_fixed()


  # 4. hierarchical clustering
  d <- stats::dist(w)
  d
  hcl <- stats::hclust(d, "ave")
  p4 <- ggdendro::ggdendrogram(hcl) + ggplot2::ggtitle("Dendrogram")


  # 5. grid arrange
  gridExtra::grid.arrange(p1, p2, p3, p4, nrow = 2, ncol = 2)
}




