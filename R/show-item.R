show_item <- function(item_bank_audio) {
  function(item, ...) {
    tempo_variations <- c(119, 122, 125, 128, 131)
    stopifnot(is(item, "item"), nrow(item) == 1L)
    item_number <- psychTestRCAT::get_item_number(item)
    num_items_in_test <- psychTestRCAT::get_num_items_in_test(item)
    prompt <- get_prompt(item_number, num_items_in_test)
    choices <- c("1", "2")
    labels <- lapply(c("ON", "OFF"), psychTestR::i18n)
    #browser()
    file_name <- sprintf("%s_%d.mp4", item$item_id, sample(tempo_variations, 1))
    message(sprintf("Showing file %s (%d of %d), track: %s, answer: %s", file_name, item_number, num_items_in_test, item$track, item$answer))
    psychTestR::audio_NAFC_page(
      label = paste0("q", item_number),
      prompt = prompt,
      choices = choices,
      labels = labels,
      url = file.path(item_bank_audio, file_name),
      wait = TRUE,
      on_complete = NULL,
      save_answer = FALSE
    )
  }
}

get_prompt <- function(item_number, num_items_in_test) {
  shiny::div(
    shiny::p(
      shiny::HTML(psychTestR::i18n("PROMPT_ITEM", sub = list(
        num_question = item_number,
        test_length = num_items_in_test
      )))),
    shiny::p(shiny::HTML(psychTestR::i18n("INSTRUCTIONS2"))))
}
