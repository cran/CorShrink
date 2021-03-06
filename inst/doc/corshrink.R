## ----knitr, echo=FALSE, results="hide"-----------------------------------
library("knitr")
opts_chunk$set(tidy=FALSE,tidy.opts=list(width.cutoff=30),dev="png",fig.show="hide",
               fig.width=4,fig.height=7,
               message=FALSE, warning = FALSE)

## ----install_ash, eval=FALSE---------------------------------------------
#  install.packages("ashr")

## ----install_corshrink_CRAN, eval=FALSE----------------------------------
#  install.packages("CorShrink")

## ----install_corshrink_github, eval=FALSE--------------------------------
#  library(devtools)
#  install_github("kkdey/CorShrink")

## ----load_countclust, cache=FALSE, eval=TRUE,warning=FALSE---------------
library(CorShrink)

## ----load_data, eval=TRUE, warning = FALSE-------------------------------
data("sample_by_feature_data")

## ----top_data, eval=TRUE, warning = FALSE--------------------------------
sample_by_feature_data[1:5,1:5]

## ----corshrink_data, eval=TRUE, warning = FALSE, message=FALSE, fig.align = "left", fig.show="asis", dpi=50, fig.width=13, fig.height=10----
out <- CorShrinkData(sample_by_feature_data, sd_boot = FALSE, image = "both",
                     image.control = list(tl.cex = 0.8))

## ----corshrink_output, eval = TRUE, warning = FALSE----------------------
out$cor_before_PD[1:5,1:5]
out$cor[1:5, 1:5]

## ----corshrinkmat, eval=TRUE, warning = FALSE, warning = FALSE, message=FALSE, fig.align = "left", fig.show="asis", dpi=50, fig.width=13, fig.height=10----
data("pairwise_corr_matrix")
data("common_samples")
out <- CorShrinkMatrix(pairwise_corr_matrix, common_samples, image = "both",
                       image.control = list(tl.cex = 0.8))

## ----corshrink_vec, eval=TRUE, warning = FALSE, message = FALSE----------
cor_vec <- c(-0.56, -0.4, 0.02, 0.2, 0.9, 0.8, 0.3, 0.1, 0.4)
nsamp_vec <- c(10, 20, 30, 4, 50, 60, 20, 10, 3)
out <- CorShrinkVector(corvec = cor_vec, nsamp_vec = nsamp_vec)
out

## ----corshrink_data_boot, eval=TRUE, warning = FALSE, message=FALSE, fig.align = "left", fig.show="asis", dpi=50, fig.width=13, fig.height=10----
out <- CorShrinkData(sample_by_feature_data, sd_boot = TRUE, image = "both",
                     image.control = list(tl.cex = 0.8))

## ----corshrink_mat_boot, eval=TRUE, warning = FALSE, message=FALSE, fig.align = "left", fig.show="asis", dpi=50, fig.width=13, fig.height=10----
zscoreSDmat <- bootcorSE_calc(sample_by_feature_data, verbose = FALSE)
out <- CorShrinkMatrix(pairwise_corr_matrix, zscore_sd = zscoreSDmat, image = "both",
                       image.control = list(tl.cex = 0.8))

## ----warning = FALSE, message=FALSE, fig.align = "left", fig.show="asis", dpi=50, fig.width=18, fig.height=15----
library(Matrix)
n <- 500
P <- 100
block <- 10
mat <- 0.3*diag(1,block) + 0.7*rep(1,block) %*% t(rep(1, block))
Sigma <-   Matrix::bdiag(mat, mat, mat, mat, mat, mat, mat, mat, mat, mat)
corSigma <- cov2cor(Sigma)
pcorSigma <- corpcor::cor2pcor(corSigma)  ##  true partial correlation matrix

## ------------------------------------------------------------------------
##################  Generate data   ################

data <- MASS::mvrnorm(n,rep(0,P),Sigma)

## ----warning = FALSE, message=FALSE, fig.align = "left", fig.show="asis", dpi=50, fig.width=18, fig.height=15----
out1 <- pCorShrinkData(data, reg_type = "lm")

## ----warning = FALSE, message=FALSE, fig.align = "left", fig.show="asis", dpi=50, fig.width=10,  fig.height=8----
library(corrplot)
col2 <- c("blue", "white", "red")
par(mfrow=c(1,2))
corrplot::corrplot(pcorSigma, diag = FALSE,
         col = colorRampPalette(col2)(200),
         tl.pos = "td", tl.cex = 0.2, tl.col = "black",
         rect.col = "white",na.label.col = "white", mar=c(2,2,2,2),
         method = "color", type = "upper", title = "original")
corrplot::corrplot(out1, diag = FALSE,
         col = colorRampPalette(col2)(200),
         tl.pos = "td", tl.cex = 0.2, tl.col = "black",
         rect.col = "white",na.label.col = "white", mar=c(2,2,2,2),
         method = "color", type = "upper", title = "pCorShrink")

## ----extras_1, eval=TRUE, warning = FALSE, message=FALSE, fig.align = "left", fig.show="asis", dpi=50, fig.width=13, fig.height=10----

par(mfrow=c(1,2))
out1 <- CorShrinkData(sample_by_feature_data, sd_boot = FALSE, image = "corshrink",             image.control = list(title = "CorShrink (target = 0)", tl.cex = 0.8))
out2 <- CorShrinkData(sample_by_feature_data, sd_boot = FALSE, image = "corshrink",                      ash.control = list(mode = "estimate"),
    image.control = list(title = "CorShrink (target = estimated)", tl.cex = 0.8))


## ----extras_2, eval=TRUE, warning = FALSE, message=FALSE, fig.align = "left", fig.show="asis", dpi=50, fig.width=13, fig.height=10----
par(mfrow=c(2,2))
out1 <- CorShrinkData(sample_by_feature_data,sd_boot = FALSE, image ="corshrink", 
                     ash.control = list(mixcompdist = "normal"),
                     image.control = list(tl.cex = 0.6))
out2 <- CorShrinkData(sample_by_feature_data,sd_boot = FALSE, image ="corshrink", 
                     ash.control = list(mixcompdist = "uniform"),
                     image.control = list(tl.cex = 0.6))
out3 <- CorShrinkData(sample_by_feature_data,sd_boot = FALSE, image ="corshrink", 
                     ash.control = list(mixcompdist = "halfuniform"),
                     image.control = list(tl.cex = 0.6))
out4 <- CorShrinkData(sample_by_feature_data,sd_boot = FALSE, image ="corshrink",  
                     ash.control = list(mixcompdist = "+uniform"),
                     image.control = list(tl.cex = 0.6))


## ----session_info, eval=TRUE---------------------------------------------
sessionInfo()

