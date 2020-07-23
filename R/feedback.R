#' BDT feedback (no score)
#'
#' Here the participant is given no feedback at the end of the test.
#' @param dict The psychTestR dictionary used for internationalisation.
#' @export
#' @examples
#' \dontrun{
#' BDT_demo(feedback = BDT.feedback.no_score())}
BDT.feedback.no_score <- function(dict = BDT::BDT_dict) {
  psychTestR::new_timeline(
    psychTestR::one_button_page(
      shiny::h4(psychTestR::i18n("COMPLETED"))
    ),
    dict = dict
  )
}

#' BDT feedback (simple score)
#'
#' Here the participant's score is reported at the end of the test.
#' @param dict The psychTestR dictionary used for internationalisation.
#' @export
#' @examples
#' \dontrun{
#' standalone_BDT(feedback = BDT.feedback.simple_score())}
BDT.feedback.simple_score <- function(dict = BDT::BDT_dict) {
  psychTestR::new_timeline(
    psychTestR::reactive_page(function(answer, ...) {
      psychTestR::one_button_page(shiny::div(
        shiny::h4(psychTestR::i18n("COMPLETED")),
        shiny::p("Your score was:",
                 shiny::strong(round(answer$ability, digits = 2)))
      ))
    }
    ), dict = dict)
}
