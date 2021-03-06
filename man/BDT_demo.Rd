% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/demo.R
\name{BDT_demo}
\alias{BDT_demo}
\title{Demo DBT}
\usage{
BDT_demo(
  num_items = 3L,
  feedback = psychTestRCAT::cat.feedback.graph("BDT"),
  admin_password = "demo",
  researcher_email = "ucine001@gold.ac.uk",
  dict = BDT::BDT_dict,
  ...
)
}
\arguments{
\item{num_items}{(Integer scalar) Number of items in the test.}

\item{feedback}{(Function) Defines the feedback to give the participant
at the end of the test. Defaults to a graph-based feedback page.}

\item{admin_password}{(Scalar character) Password for accessing the admin panel.
Defaults to \code{"demo"}.}

\item{researcher_email}{(Scalar character)
If not \code{NULL}, this researcher's email address is displayed
at the bottom of the screen so that online participants can ask for help.
Defaults to \email{ucine001@gold.ac.uk},
the email address of this package's developer.}

\item{dict}{The psychTestR dictionary used for internationalisation.}

\item{...}{Further arguments to be passed to \code{\link{BDT}()}.}
}
\description{
This function launches a demo for the BDT.
}
