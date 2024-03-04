practice <- function(practice_items) {
  unlist(lapply(
    list(list(id = "practice_on",
              answer = "1",
              no = 1L),
         list(id = "practice_off",
              answer = "2",
              no = 2L)
    ),
    function(x) {
      list(
        psychTestR::audio_NAFC_page(
          label = "practice_question",
          prompt = shiny::HTML(psychTestR::i18n("SAMPLE_QUESTION",
                                                sub = list(no_example = x$no))),
          url = file.path(practice_items, paste0(x$id, ".mp3")),
          choices = as.character(c(1, 2)),
          #show_controls = TRUE,
          autoplay = "moin",
          labels = lapply(c("ON", "OFF"), psychTestR::i18n),
          save_answer = FALSE
        ),
        psychTestR::reactive_page(function(answer, ...) {
          psychTestR::one_button_page(
            if (answer == x$answer)
              psychTestR::i18n("CORRECT") else
                psychTestR::i18n("INCORRECT"),
            button_text = psychTestR::i18n("CONTINUE")
          )}))}))
}
