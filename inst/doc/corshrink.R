## ----knitr, echo=FALSE, results="hide"-------------------------------------
library("knitr")
opts_chunk$set(tidy=FALSE,tidy.opts=list(width.cutoff=30),dev="png",fig.show="hide",
               fig.width=4,fig.height=7,
               message=FALSE, warning = FALSE)

## ----style, eval=TRUE, echo=FALSE, results='asis'--------------------------
BiocStyle::markdown()

## ----install_ash, eval=FALSE-----------------------------------------------
#  devtools::install_github("stephens999/ashr")

## ----install_corshrink_CRAN, eval=FALSE------------------------------------
#  install.packages("CorShrink")

## ----install_corshrink_github, eval=FALSE----------------------------------
#  library(devtools)
#  install_github("kkdey/CorShrink")

## ----load_countclust, cache=FALSE, eval=TRUE,warning=FALSE-----------------
library(CorShrink)

## ----load_data, eval=TRUE, warning = FALSE---------------------------------
data <- get(load(system.file("extdata", "sample_by_feature_data.rda",
                             package = "CorShrink")))

## ----top_data, eval=TRUE, warning = FALSE----------------------------------
data[1:5,1:5]

## ----corshrink_data, eval=TRUE, warning = FALSE, message=FALSE, fig.align = "left", fig.show="asis", dpi=144, fig.width=13, fig.height=7----
par(mfrow=c(1,2))
out <- CorShrinkData(data, sd_boot = FALSE, image_original = TRUE, 
                     image_corshrink = TRUE, optmethod = "mixEM",
                     image.control = list(x.cex = 0.3, y.cex = 0.3))

## ----corshrink_output, eval = TRUE, warning = FALSE------------------------
out$ash_cor_only[1:5,1:5]
out$ash_cor_PD[1:5, 1:5]

## ----load_cormat, eval=TRUE, warning = FALSE-------------------------------
cormat <- get(load(system.file("extdata", "corr_matrix.rda",
                             package = "CorShrink")))
nsamp <- get(load(system.file("extdata", "common_samples.rda",
                             package = "CorShrink")))

## ----corshrink_mat_VBEM, eval=TRUE, warning = FALSE, message=FALSE, fig.align = "left", fig.show="asis", dpi=144, fig.width=13, fig.height=7----
par(mfrow=c(1,2))
out <- CorShrinkMatrix(cormat, nsamp, image_corshrink  = TRUE, optmethod = "mixEM")
out <- CorShrinkMatrix(cormat, nsamp, image_corshrink = TRUE, optmethod = "mixVBEM")

## ----corshrink_vec, eval=TRUE, warning = FALSE, message = FALSE------------
cor_vec <- c(-0.56, -0.4, 0.02, 0.2, 0.9, 0.8, 0.3, 0.1, 0.4)
nsamp_vec <- c(10, 20, 30, 4, 50, 60, 20, 10, 3)
out <- CorShrinkVector(corvec = cor_vec, nsamp_vec = nsamp_vec,
                       optmethod = "mixEM")
out

## ----corshrink_data_boot, eval=TRUE, warning = FALSE, message=FALSE, fig.align = "left", fig.show="asis", dpi=144, fig.width=13, fig.height=7----
par(mfrow=c(1,2))
out <- CorShrinkData(data, sd_boot = TRUE, image_original = TRUE, 
                     image_corshrink = TRUE, optmethod = "mixEM",
                     image.control = list(x.cex = 0.3, y.cex = 0.3))

## ----corshrink_mat_boot, eval=TRUE, warning = FALSE, message=FALSE, fig.align = "left", fig.show="asis", dpi=144, fig.width=13, fig.height=7----
par(mfrow = c(1,2))
zscoreSDmat <- bootcorSE_calc(data, verbose = FALSE)
out <- CorShrinkMatrix(cormat, zscore_sd = zscoreSDmat, image_original = TRUE,
                       image_corshrink = TRUE, optmethod = "mixEM")

## ----extras_1, eval=TRUE, warning = FALSE, message=FALSE, fig.align = "left", fig.show="asis", dpi=144, fig.width=13, fig.height=7----
par(mfrow=c(1,2))
out <- CorShrinkData(data, sd_boot = FALSE, image_corshrink = TRUE, 
                     optmethod = "mixEM",
                     image.control = list(x.cex = 0.3, y.cex = 0.3,
                      main_corshrink = "CorShrink (target = 0)"))
out <- CorShrinkData(data, sd_boot = FALSE, image_corshrink = TRUE, 
                     optmethod = "mixEM",
                     ash.control = list(mode = "estimate"),
                     image.control = list(x.cex = 0.3, y.cex = 0.3,
                      main_corshrink = "CorShrink (target = estimated)"))

## ----extras_2, eval=TRUE, warning = FALSE, message=FALSE, fig.align = "left", fig.show="asis", dpi=144, fig.width=13, fig.height=10----
par(mfrow=c(2,2))
out <- CorShrinkData(data, sd_boot = FALSE, image_corshrink = TRUE, 
                     optmethod = "mixEM",
                     ash.control = list(mixcompdist = "normal"),
                     image.control = list(x.cex = 0.3, y.cex = 0.3,
                            main_corshrink = "CorShrink (normal)"))
out <- CorShrinkData(data, sd_boot = FALSE, image_corshrink = TRUE, 
                     optmethod = "mixEM",
                     ash.control = list(mixcompdist = "uniform"),
                     image.control = list(x.cex = 0.3, y.cex = 0.3,
                            main_corshrink = "CorShrink (uniform)"))
out <- CorShrinkData(data, sd_boot = FALSE, image_corshrink = TRUE, 
                     optmethod = "mixEM",
                     ash.control = list(mixcompdist = "halfuniform"),
                     image.control = list(x.cex = 0.3, y.cex = 0.3,
                        main_corshrink = "CorShrink (halfuniform)"))
out <- CorShrinkData(data, sd_boot = FALSE, image_corshrink = TRUE,  
                     optmethod = "mixEM",
                     ash.control = list(mixcompdist = "+uniform"),
                     image.control = list(x.cex = 0.3, y.cex = 0.3,
                        main_corshrink = "CorShrink (+uniform)"))

## ----session_info, eval=TRUE-----------------------------------------------
sessionInfo()

