BDT_dict_raw <- readRDS("data-raw/BDT_dict.RDS")
BDT_dict <- psychTestR::i18n_dict$new(BDT_dict_raw)
usethis::use_data(BDT_dict, overwrite = TRUE)
