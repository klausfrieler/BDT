#' Demo DBT
#'
#' This function launches a demo for the BDT.
#'
#' @param num_items (Integer scalar) Number of items in the test.
#' @param feedback (Function) Defines the feedback to give the participant
#' at the end of the test. Defaults to a graph-based feedback page.
#' @param admin_password (Scalar character) Password for accessing the admin panel.
#' Defaults to \code{"demo"}.
#' @param researcher_email (Scalar character)
#' If not \code{NULL}, this researcher's email address is displayed
#' at the bottom of the screen so that online participants can ask for help.
#' Defaults to \email{ucine001@gold.ac.uk},
#' the email address of this package's developer.
#' @param dict The psychTestR dictionary used for internationalisation.
#' @param ... Further arguments to be passed to \code{\link{BDT}()}.
#' @export
BDT_demo <- function(num_items = 3L,
                       feedback = psychTestRCAT::cat.feedback.graph("BDT"),
                       admin_password = "demo",
                       researcher_email = "ucine001@gold.ac.uk",
                       dict = BDT::BDT_dict,
                       ...) {
  elts <- c(
    psychTestR::new_timeline(psychTestR::one_button_page(
      psychTestR::i18n("DEMO_INTRO"),
      button_text = psychTestR::i18n("CONTINUE")
    ), dict = dict),
    BDT::BDT(num_items = num_items,
             take_training = TRUE,
             with_welcome = FALSE,
             dict = dict,
             ...),
    psychTestR::new_timeline(
      psychTestR::final_page(shiny::p(
        psychTestR::i18n("COMPLETED")),
      ), dict = dict))

  psychTestR::make_test(
    elts,
    opt = psychTestR::test_options(title = "BDT demo",
                                   admin_password = admin_password,
                                   researcher_email = researcher_email,
                                   demo = TRUE,
                                   languages = "EN"))
}
