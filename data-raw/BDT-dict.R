input <- read.csv("data-raw/BDT-dict.csv", stringsAsFactors = FALSE)
names(input)[[1]] <- "key"



BDT_dict <- psychTestR::i18n_dict$new(input)
usethis::use_data(BDT_dict, overwrite = TRUE)
