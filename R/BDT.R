#' BDT
#'
#' This function defines a BDT module for incorporation into a
#' psychTestR timeline.
#' Use this function if you want to include the BDT in a
#' battery of other tests, or if you want to add custom psychTestR
#' pages to your test timeline.
#' For demoing the BDT, consider using \code{\link{BDT_demo}()}.
#' For a standalone implementation of the BDT,
#' consider using \code{\link{BDT_standalone}()}.
#' @param num_items (Integer scalar) Number of items in the test.
#' @param take_training (Logical scalar) Whether to include the training phase.
#' @param label (Character scalar) Label to give the BDT results in the output file.
#'
#' @param feedback Defines the feedback to give the participant
#' at the end of the test. By default no feedback is given.
#' This can be a timeline segment (as created by \code{\link[psychTestR]{new_timeline}}),
#' a test element (as created by e.g. \code{\link[psychTestR]{page}}),
#' or a list of test elements.
#' The following built-in choices are available
#' see function-level documentation for details):
#' - \code{\link{BDT.feedback.no_score}}
#' - \code{\link{BDT.feedback.simple_score}}
#' - \code{\link[psychTestRCAT]{cat.feedback.graph}}
#' - \code{\link[psychTestRCAT]{cat.feedback.irt}}
#' - \code{\link[psychTestRCAT]{cat.feedback.iq}}
#'
#' @param item_bank_audio (Character scalar) File path to the directory
#' hosting the item bank audio (typically a publicly accessible web directory).
#' @param practice_items (Character scalar) File path to the directory
#' hosting the practice items audio (typically a publicly accessible web directory).
#' @param next_item.criterion (Character scalar)
#' Criterion for selecting successive items in the adaptive test.
#' See the \code{criterion} argument in \code{\link[catR]{nextItem}} for possible values.
#' \code{"bOpt"} corresponds to the setting used in the original BDT paper.
#' @param next_item.estimator (Character scalar)
#' Ability estimation method used for selecting successive items in the adaptive test.
#' See the \code{method} argument in \code{\link[catR]{thetaEst}} for possible values.
#' \code{"BM"}, Bayes modal,
#' corresponds to the setting used in the original BDT paper.
#' \code{"WL"}, weighted likelihood,
#' corresponds to the default setting used in versions <= 0.3.0 of this package.
#' @param next_item.prior_dist (Character scalar)
#' The type of prior distribution to use when calculating ability estimates
#' for item selection.
#' Ignored if \code{next_item.estimator} is not a Bayesian method.
#' Defaults to \code{"norm"} for a normal distribution.
#' See the \code{priorDist} argument in \code{\link[catR]{thetaEst}} for possible values.
#' @param next_item.prior_par (Numeric vector, length 2)
#' Parameters for the prior distribution;
#' see the \code{priorPar} argument in \code{\link[catR]{thetaEst}} for details.
#' Ignored if \code{next_item.estimator} is not a Bayesian method.
#' The dfeault is \code{c(0, 1)}.
#' @param final_ability.estimator
#' Estimation method used for the final ability estimate.
#' See the \code{method} argument in \code{\link[catR]{thetaEst}} for possible values.
#' The default is \code{"WL"}, weighted likelihood,
#' which corresponds to the setting used in the original BDT paper.
#' If a Bayesian method is chosen, its prior distribution will be defined
#' by the \code{next_item.prior_dist} and \code{next_item.prior_par} arguments.
#' @param constrain_answers (Logical scalar)
#' If \code{TRUE}, then item selection will be constrained so that the
#' correct answers are distributed as evenly as possible over the course of the test.
#' We recommend leaving this option disabled.
#' @param dict The psychTestR dictionary used for internationalisation.
#' @note Versions <= 0.3.0 of this package experimented with weighted likelihood
#' ability estimation for item selection. Pilot testing found this approach
#' to be problematic, tending to overpenalise the participant for early mistakes.
#' Current versions of the package therefore revert to Bayes modal
#' ability estimation for item selection, consistent with the original BDT paper.
#'
#' @md
#'
#' @export
BDT <- function(
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
) {
  #browser()
  stopifnot(is.scalar.integerlike(num_items),
            is.scalar.logical(take_training),
            is.scalar.logical(with_welcome),
            is.scalar.character(label),
            is.scalar.character(item_bank_audio),
            is.scalar.character(practice_items),
            is.scalar.character(next_item.criterion),
            is.scalar.character(next_item.estimator),
            is.scalar.character(next_item.prior_dist),
            is.numeric(next_item.prior_par),
            length(next_item.prior_par) == 2L,
            is.scalar.character(final_ability.estimator))
  item_bank_audio <- gsub("/$", "", item_bank_audio)
  practice_items <- gsub("/$", "", practice_items)
  arg <- as.list(environment())
  psychTestR::join(
    if(with_welcome) psychTestR::new_timeline(psychTestR::one_button_page(
      shiny::h3(psychTestR::i18n("WELCOME")),
      button_text = psychTestR::i18n("CONTINUE")
    ), dict = dict),
    if (take_training) intro(practice_items = practice_items, dict = dict),
    main_test(arg, dict = dict),
    feedback
  )
}

