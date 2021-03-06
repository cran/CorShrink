% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bootcorSE_calc.R
\name{bootcorSE_calc}
\alias{bootcorSE_calc}
\title{Calculate bootstrap SE for the Fisher z-scores of correlations}
\usage{
bootcorSE_calc(data, nboot = 50, cor_method, thresh_up = 0.999,
  thresh_down = 0.001, verbose = TRUE)
}
\arguments{
\item{data}{The samples by features data matrix.}

\item{nboot}{The number of bootstrap samples.}

\item{cor_method}{The method of correlation used. May be "pearson", "spearman" or "kendall"
depending on the type of correlation to be used by the user.}

\item{thresh_up}{The upward threshold for correlations}

\item{thresh_down}{The downward threshold for correlations.}

\item{verbose}{To print the status of Bootstrap runs}
}
\value{
Returns standard errors for fisher z-scores for the correlations.
}
\description{
computes the bootstrap SE of the Fisher z-scores to be used in \code{CorShrink-ML}
or \code{CorShrink-VEM}.
}
\examples{

data("sample_by_feature_data")
zscoreSDmat <- bootcorSE_calc(sample_by_feature_data, verbose = FALSE)

}
\keyword{adaptive}
\keyword{correlation}
\keyword{shrinkage,}
