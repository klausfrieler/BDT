#' Standalone BDT
#'
#' This function launches a standalone testing session for the BDT.
#' This can be used for data collection, either in the laboratory or online.
#' @param title (Scalar character) Title to display during testing.
#' @param admin_password (Scalar character) Password for accessing the admin panel.
#' @param researcher_email (Scalar character)
#' If not \code{NULL}, this researcher's email address is displayed
#' at the bottom of the screen so that online participants can ask for help.
#' @param languages (Character vector)
#' Determines the languages available to participants.
#' Possible languages include English (\code{"en"})
#' and German (\code{"de"}).
#' The first language is selected by default
#' @param dict The psychTestR dictionary used for internationalisation.
#' @param feedback (Null or a page)
#' if NULL ther last page will show the "You completed the test" message along with "Your results have been save", else
#' it will only show the latter but the feedback specified here.
#' Currently, BDT.feedback.no_score() and BDT.feedback.simple_score() are supported (s. feedback.R).
#' You can also design your own feedback function.
#' @param ... Further arguments to be passed to \code{\link{BDT}()}.
#' @export
BDT_standalone <- function(title = "Beat Drop Alignment Test",
                           admin_password = "replace-with-secure-password",
                           researcher_email = NULL,
                           languages = BDT_languages(),
                           dict = BDT::BDT_dict,
                           feedback = NULL,
                           ...) {
  #browser()
  elts <- c(
    BDT(with_welcome = TRUE, dict = dict, feedback = feedback, ...),
    psychTestR::elt_save_results_to_disk(complete = TRUE),
    psychTestR::new_timeline(
      psychTestR::final_page(
        shiny::div(
          if(is.null(feedback)) shiny::h4(psychTestR::i18n("COMPLETED")),
          shiny::p(psychTestR::i18n("RESULTS_SAVED")))),
      dict = dict)
  )

  psychTestR::make_test(
    elts,
    opt = psychTestR::test_options(title = title,
                                   admin_password = admin_password,
                                   researcher_email = researcher_email,
                                   demo = FALSE,
                                   languages = tolower(languages))
  )
}
