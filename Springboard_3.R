# Setup environment

#install.packages("tidyr")
#install.packages("dplyr")
#install.packages("devtools")
#install.packages("stringr")

library(devtools)
library("tidyr")
library("dplyr")



# Load dataset
ds_original <- read.csv("refine_original.csv")
tbl_df(ds_original)

#Combine address fields
ds_cleaned <- unite(ds_original,full_address,c(address:country), sep = ", ",remove = TRUE)

# Please run these two steps together to see the problem.
# ds_temp <- gsub("ak zo","akzo",ds_fulladdress,ignore.case=T)
# View(ds_temp) # I don not understand why gsub placed the 

library(stringr)

#cleaning akzo
ds_cleaned$company <- tolower(ds_cleaned$company)
ds_cleaned$company <- str_replace(ds_cleaned$company,"k\\sz","kz")
ds_cleaned$company <- str_replace(ds_cleaned$company,"z[0-9]","zo")
ds_cleaned$company <- str_replace(ds_cleaned$company,"z[0-9]","zo")
ds_cleaned$company <- str_replace(ds_cleaned$company,"z[0-9]","zo")

# I am going to attemp the same with replace()
ds_cleaned$company <- tolower(ds_cleaned$company)
ds_cleaned$company <- replace(ds_cleaned$company, c("ak zo", "akz0", "AKZO", "Akzo", "akzo"), "akzo")
ds_cleaned$company <- replace(ds_cleaned$company, c("philips", "Phillips", "phillps", "phlips", "phllips", "fillips"), "phillips")
ds_cleaned$company <- replace(ds_cleaned$company, c("Unilever", "unilver"), "uniliver")
ds_cleaned$company <- replace(ds_cleaned$company, c("Van Houten", "Van Hausen"), "van houten")
View(ds_cleaned)


ds_cleaned <- separate(ds_cleaned, "Product.code...number", c("product_code", "product_number"),"-")

# Add a column for product categories
ds_cleaned$product_categories <- c("")

# Rearrange columns in correct order
ds_cleaned <- ds_cleaned[c("company", "product_code", "product_number", "product_categories", "full_address", "name")]

# Add values for new column: p = Smartphone, v = TV, x = Laptop, q = Tablet
ds_cleaned$product_categories <-  ifelse(ds_cleaned$product_code == "p", "Smartphone", 
                                          ifelse(ds_cleaned$product_code == "v", "TV", 
                                              ifelse(ds_cleaned$product_code == "x", "Laptop", 
                                                  ifelse(ds_cleaned$product_code == "q", "Tablet",NA))))
View(ds_cleaned)

# Add four binary (1 or 0) columns for company: company_philips, company_akzo, company_van_houten and company_unilever
# Add four binary (1 or 0) columns for product category: product_smartphone, product_tv, product_laptop and product_tablet

# export ds_clean.csv
write.csv(ds_cleaned, 'refined_clean.csv')

# dplyr::rename(tb, y = year)
# dplyr::arrange(mtcars, mpg)
# separate(storms, date, c("y", "m", "d"))
