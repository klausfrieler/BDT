info_page <- function(id) {
  psychTestR::one_button_page(psychTestR::i18n(id),
                              button_text = psychTestR::i18n("CONTINUE"))
}

audio_ex_page <- function(prompt_id, url) {
  psychTestR::audio_NAFC_page(
    label = "ex",
    prompt = shiny::HTML(psychTestR::i18n(prompt_id)),
    choices = psychTestR::i18n("CONTINUE"),
    url = url,
    save_answer = FALSE
  )
}

intro <- function(practice_items, dict) {
  psychTestR::new_timeline(
    c(
      psychTestR::code_block(function(state, ...) {
        psychTestR::set_local("do_intro", TRUE, state)
      }),
      psychTestR::while_loop(
        test = function(state, ...) psychTestR::get_local("do_intro", state),
        logic = c(
          info_page("INTRO"),
          info_page("NEXT_SAMPLE"),
          audio_ex_page("SAMPLE_ON", file.path(practice_items, "training_on.mp3")),
          audio_ex_page("SAMPLE_OFF", file.path(practice_items, "training_off.mp3")),
          info_page("INSTRUCTIONS"),
          practice(practice_items),
          ask_repeat()
        )),
      info_page("INTRO_MAIN")
    ), dict = dict)
}

ask_repeat <-function() {
  psychTestR::NAFC_page(
    label = "ask_repeat",
    prompt = shiny::HTML(psychTestR::i18n("GO_BACK_SAMPLE",
                                          sub = c(feedback = ""))),
    choices = c("go_back", "continue"),
    labels = lapply(c("GO_BACK", "CONTINUE"), psychTestR::i18n),
    save_answer = FALSE,
    arrange_vertically = FALSE,
    on_complete = function(state, answer, ...) {
      psychTestR::set_local("do_intro", identical(answer, "go_back"), state)
    }
  )
}
