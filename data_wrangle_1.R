library(dplyr)
library(tidyr)

refine_raw <- read.csv("refine.csv")
refine_tbl <- tbl_df(refine_raw)

refine_tbl$company <- tolower(refine_tbl$company)
refine_tbl$company <- gsub("phillips|philips|phllips|phillps|fillips|phlips", "philips", refine_tbl$company)
refine_tbl$company <- gsub("ak zo|akz0", "akzo", refine_tbl$company)
refine_tbl$company <- gsub("unilver", "unilever", refine_tbl$company)

refine_tbl2 <- separate(refine_tbl, Product.code...number, c("Product.code", "number"))

refine_tbl3 <- mutate(refine_tbl2, Product.category =
                        ifelse(grepl("p", Product.code), "Smartphone",
                               ifelse(grepl("v", Product.code), "TV",
                               ifelse(grepl("x", Product.code), "Laptop",
                               ifelse(grepl("q", Product.code), "Tablet", "NA")))))

refine_tbl4 <- unite(refine_tbl3, full_address, address, city, country, sep=", ")

refine_tbl5 <- mutate(refine_tbl4, company_philips = ifelse(company =="philips", 1, 0))
refine_tbl5 <- mutate(refine_tbl5, company_akzo = ifelse(company =="akzo", 1, 0))
refine_tbl5 <- mutate(refine_tbl5, company_van_houten = ifelse(company =="van houten", 1, 0))
refine_tbl5 <- mutate(refine_tbl5, company_unilever = ifelse(company =="unilever", 1, 0))

refine_tbl5 <- rename(refine_tbl5, product_code = Product.code)
refine_tbl5 <- rename(refine_tbl5, product_category = Product.category)


refine_tbl5 <- mutate(refine_tbl5, product_smartphone = ifelse(product_code =="p", 1, 0))
refine_tbl5 <- mutate(refine_tbl5, product_tv = ifelse(product_code =="v", 1, 0))
refine_tbl5 <- mutate(refine_tbl5, product_laptop = ifelse(product_code =="x", 1, 0))
refine_tbl5 <- mutate(refine_tbl5, product_tablet = ifelse(product_code =="q", 1, 0))

<<<<<<< HEAD
write.csv(refine_tbl5, file="refine_clean.csv")
=======
refine_clean <- refine_tbl5

>>>>>>> origin/master
