% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/BDT.R
\name{BDT}
\alias{BDT}
\title{BDT}
\usage{
BDT(
  num_items = 25L,
  with_welcome = TRUE,
  take_training = TRUE,
  feedback = NULL,
  label = "BDT",
  item_bank_audio = "https://media.gold-msi.org/test_materials/BDT/",
  practice_items = "https://media.gold-msi.org/test_materials/BDT/",
  next_item.criterion = "bOpt",
  next_item.estimator = "BM",
  next_item.prior_dist = "norm",
  next_item.prior_par = c(0, 1),
  final_ability.estimator = "WL",
  constrain_answers = TRUE,
  dict = BDT::BDT_dict
)
}
\arguments{
\item{num_items}{(Integer scalar) Number of items in the test.}

\item{take_training}{(Logical scalar) Whether to include the training phase.}

\item{feedback}{Defines the feedback to give the participant
at the end of the test. By default no feedback is given.
This can be a timeline segment (as created by \code{\link[psychTestR]{new_timeline}}),
a test element (as created by e.g. \code{\link[psychTestR]{page}}),
or a list of test elements.
The following built-in choices are available
see function-level documentation for details):
\itemize{
\item \code{\link{BDT.feedback.no_score}}
\item \code{\link{BDT.feedback.simple_score}}
\item \code{\link[psychTestRCAT]{cat.feedback.graph}}
\item \code{\link[psychTestRCAT]{cat.feedback.irt}}
\item \code{\link[psychTestRCAT]{cat.feedback.iq}}
}}

\item{label}{(Character scalar) Label to give the BDT results in the output file.}

\item{item_bank_audio}{(Character scalar) File path to the directory
hosting the item bank audio (typically a publicly accessible web directory).}

\item{practice_items}{(Character scalar) File path to the directory
hosting the practice items audio (typically a publicly accessible web directory).}

\item{next_item.criterion}{(Character scalar)
Criterion for selecting successive items in the adaptive test.
See the \code{criterion} argument in \code{\link[catR]{nextItem}} for possible values.
\code{"bOpt"} corresponds to the setting used in the original BDT paper.}

\item{next_item.estimator}{(Character scalar)
Ability estimation method used for selecting successive items in the adaptive test.
See the \code{method} argument in \code{\link[catR]{thetaEst}} for possible values.
\code{"BM"}, Bayes modal,
corresponds to the setting used in the original BDT paper.
\code{"WL"}, weighted likelihood,
corresponds to the default setting used in versions <= 0.3.0 of this package.}

\item{next_item.prior_dist}{(Character scalar)
The type of prior distribution to use when calculating ability estimates
for item selection.
Ignored if \code{next_item.estimator} is not a Bayesian method.
Defaults to \code{"norm"} for a normal distribution.
See the \code{priorDist} argument in \code{\link[catR]{thetaEst}} for possible values.}

\item{next_item.prior_par}{(Numeric vector, length 2)
Parameters for the prior distribution;
see the \code{priorPar} argument in \code{\link[catR]{thetaEst}} for details.
Ignored if \code{next_item.estimator} is not a Bayesian method.
The dfeault is \code{c(0, 1)}.}

\item{final_ability.estimator}{Estimation method used for the final ability estimate.
See the \code{method} argument in \code{\link[catR]{thetaEst}} for possible values.
The default is \code{"WL"}, weighted likelihood,
which corresponds to the setting used in the original BDT paper.
If a Bayesian method is chosen, its prior distribution will be defined
by the \code{next_item.prior_dist} and \code{next_item.prior_par} arguments.}

\item{constrain_answers}{(Logical scalar)
If \code{TRUE}, then item selection will be constrained so that the
correct answers are distributed as evenly as possible over the course of the test.
We recommend leaving this option disabled.}

\item{dict}{The psychTestR dictionary used for internationalisation.}
}
\description{
This function defines a BDT module for incorporation into a
psychTestR timeline.
Use this function if you want to include the BDT in a
battery of other tests, or if you want to add custom psychTestR
pages to your test timeline.
For demoing the BDT, consider using \code{\link{BDT_demo}()}.
For a standalone implementation of the BDT,
consider using \code{\link{BDT_standalone}()}.
}
\note{
Versions <= 0.3.0 of this package experimented with weighted likelihood
ability estimation for item selection. Pilot testing found this approach
to be problematic, tending to overpenalise the participant for early mistakes.
Current versions of the package therefore revert to Bayes modal
ability estimation for item selection, consistent with the original BDT paper.
}
