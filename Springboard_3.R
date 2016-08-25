# Setup environment

#install.packages("tidyr")
#install.packages("dplyr")
#install.packages("devtools")
#install.packages("stringr")
library(devtools)
library("tidyr")
library("dplyr")



# Load dataset
refine_original <- read.csv("refine_original.csv")

# Backup dataset
tbl_df(refine_original)


refine_fulladdress <- unite(refine1,full_address,c(address:country), sep = ", ",remove = TRUE)

# Please run these two steps together to see the problem.

# refine_temp <- gsub("ak zo","akzo",refine_fulladdress,ignore.case=T)
# View(refine_temp) # I don not understand why gsub placed the 

library(stringr)
#cleaning akzo

# refine_fulladdress$company <- str_replace(refine_fulladdress$company,"k\\sz","kz")
# refine_fulladdress$company <- str_replace(refine_fulladdress$company,"z[0-9]","zo")

# This is the example I am working off of:
#Case insensitive replace:
#  > gsub("tut","ot",x,ignore.case=T))
#[1] "R otorial"

# I am going to attemp the same with replace()

refine_cleaned$company <- tolower(refine_cleaned$company)
refine_cleaned$company <- replace(refine_fulladdress$company, c("ak zo", "akz0", "AKZO", "Akzo", "akzo"), "akzo")
refine_cleaned$company <- replace(refine_fulladdress$company, c("philips", "Phillips", "phillps", "phlips", "phllips", "fillips"), "phillips")
refine_cleaned$company <- replace(refine_fulladdress$company, c("Unilever", "unilver"), "uniliver")
refine_cleaned$company <- replace(refine_fulladdress$company, c("Van Houten", "Van Hausen"), "van houten")

# Cheated here and used Excel to get the below list. Wonder if there is any easy way of doing this with R.
# c("ak zo", "akz0", "AKZO", "Akzo", "akzo")
# c("philips", "Phillips", "phillps", "phlips", "phllips", "fillips")
# c("Unilever", "unilver")
# c("Van Houten", "Van Hausen")

refine_cleaned <- separate(refine_cleaned, "Product.code...number", c("product_code", "product_number"),"-")

# p = Smartphone
# v = TV
# x = Laptop
# q = Tablet

#add a column for product categories
refine_cleaned$company$product_categories <- c("")
# rearrange columns in correct order

refine_cleaned$company <- refine_cleaned$company[c("company", "product_code", "product_number", "product_categories", "full_address", "name")]

#add values for new column: p = Smartphone, v = TV, x = Laptop, q = Tablet
refine_cleaned$product_categories <- ifelse(refine_cleaned$product_code == "p", "Smartphone", 
                                ifelse(refine_cleaned$product_code == "v", "TV", 
                                       ifelse(refine_cleaned$product_code == "x", "Laptop", 
                                              ifelse(refine_cleaned$product_code == "q", "Tablet", 
                                                     NA))))
View(refine_cleaned)

# Add four binary (1 or 0) columns for company: company_philips, company_akzo, company_van_houten and company_unilever
# Add four binary (1 or 0) columns for product category: product_smartphone, product_tv, product_laptop and product_tablet

# export refine_clean.csv
write.csv(refine_cleaned, 'refine_clean.csv')

# dplyr::rename(tb, y = year)
# dplyr::arrange(mtcars, mpg)
# separate(storms, date, c("y", "m", "d"))
