library(dplyr)
library(tidyr)

refine_raw <- read.csv("refine.csv")
refine_tbl <- tbl_df(refine_raw)

refine_tbl$company <- tolower(refine_tbl$company)
refine_tbl$company <- gsub("phlips|phillps|phlips|phllips", "philips", refine_tbl$company)
refine_tbl$company <- gsub("ak zo|akz0", "akzo", refine_tbl$company)
refine_tbl$company <- gsub("unilver", "unilever", refine_tbl$company)

refine_tbl2 <- separate(refine_tbl, Product.code...number, c("Product.code", "number"))

refine_tbl3 <- mutate(refine_tbl2, Product.category =
                        ifelse(grepl("p", Product.code), "Smartphone",
                               ifelse(grepl("v", Product.code), "TV",
                               ifelse(grepl("x", Product.code), "Laptop",
                               ifelse(grepl("q", Product.code), "Tablet", "NA")))))

refine_tbl4 <- unite(refine_tbl3, address, city, country, sep=",")
