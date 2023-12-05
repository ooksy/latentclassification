#' Title
#'
#' @param z
#' @param w
#' @param n_cluster
#'
#' @return set of plots
#' @export
latentclassfication <- function(z, w, n_cluster){
  n <- nrow(z)
  p <- nrow(w)


  # 1. kmeans clustering
  kmeans_result <- kmeans(w, centers = n_cluster, iter.max = 100, nstart = 1, algorithm = c("Hartigan-Wong", "Lloyd", "Forgy", "MacQueen"), trace=FALSE)
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


  # 2. K-means clustering scree plot?
  p2


  # 3. hierarchical clustering
  d <- dist(w)
  d
  hcl <- hclust(d, "ave")
  p3 <- ggdendro::ggdendrogram(hcl)


  # 4. PCA
  pr_result <- prcomp(w)
  pcadat <- as.data.frame(pr_result$x[, 1:2])
  pcadat <- cbind(pcadat, labs, kmeans_result$cluster)
  colnames(pcadat) <- c("PC1", "PC2", "Labs", "Cluster")
  p4 <- ggplot2::ggplot(pcadat) +
          ggplot2::aes(PC1, PC2, color = Cluster) +
          ggplot2::geom_text(label = pcadat[, 3], color = as.factor(pcadat[, 4])) +
          ggplot2::coord_fixed()

  # 4. grid arrange
  gridExtra::grid.arrange(p1, p2, p3, p4, nrow = 2, ncol = 2)
}



