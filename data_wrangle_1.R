refine_raw <- read.csv("refine.csv")
refine_tbl <- tbl_df(refine_raw)

refine_tbl$company <- tolower(refine_tbl$company)
