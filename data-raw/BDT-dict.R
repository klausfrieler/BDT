BDT_dict_raw <- readRDS("data-raw/BDT_dict.RDS")
BDT_dict_raw[BDT_dict_raw$key == "SAMPLE_QUESTION", "DE"] <- "**Beispiel {{no_example}}/2**\\\\War der Beep-Ton **auf** oder **neben** dem Beat?"
BDT_dict <- psychTestR::i18n_dict$new(BDT_dict_raw)
usethis::use_data(BDT_dict, overwrite = TRUE)
