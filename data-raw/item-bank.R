BDT_item_bank <- read.csv("data-raw/BDT_item_bank.csv", stringsAsFactors = FALSE, sep = ";")
BDT_item_bank$id <- 1:nrow(BDT_item_bank)
BDT_item_bank$answer <- BDT_item_bank$on_off + 1
BDT_item_bank <- BDT_item_bank[, c("id", "item_id", "difficulty", "discrimination", "guessing", "inattention", "answer")]

usethis::use_data(BDT_item_bank, overwrite = TRUE)
