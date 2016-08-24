# Setup environment

install.packages("tidyr")
install.packages("dplyr")
install.packages("devtools")
library("tidyr")
library("dplyr")
library(devtools)

# Load dataset
refine_original <- read.csv("/users/ababen/Springboard/refine_original.csv")

# Backup dataset
refine1 <- refine_original
tbl_df(refine1)


refine_fulladdress <- unite(refine1,full_address,c(address:country), sep = ", ",remove = TRUE)

# Please run these two steps together to see the problem.

refine_temp <- gsub("ak zo","akzo",refine_fulladdress,ignore.case=T)
View(refine_temp) # I don not understand why gsub placed the 

# This is the example I am working off of:
#Case insensitive replace:
#  > gsub("tut","ot",x,ignore.case=T))
#[1] "R otorial"

# I am going to attemp the same with replace()

refine_cleaned <- replace(refine_fulladdress, c("ak zo", "akz0", "AKZO", "Akzo", "akzo"), "akzo")
refine_cleaned <- replace(refine_fulladdress, c("philips", "Phillips", "phillps", "phlips", "phllips", "fillips"), "phillips")
refine_cleaned <- replace(refine_fulladdress, c("Unilever", "unilver"), "uniliver")
refine_cleaned <- replace(refine_fulladdress, c("Van Houten", "Van Hausen"), "van houten")
View(refine_cleaned)

# Cheated here and used Excel to get the below list. Wonder if there is any easy way of doing this with R.
# c("ak zo", "akz0", "AKZO", "Akzo", "akzo")
# c("philips", "Phillips", "phillps", "phlips", "phllips", "fillips")
# c("Unilever", "unilver")
# c("Van Houten", "Van Hausen")

refine_split <- separate(refine_fulladdress, "Product.code...number", c("product_code", "product_number"),"-")
View(refine_split)
View(refine_cleaned)

# p = Smartphone
# v = TV
# x = Laptop
# q = Tablet

#add a column for product categories
df$product_categories <- c("")
# rearrange columns in correct order
df <- df[c("company", "product_code", "product_number", "product_categories", "address", "city", "country", "name")]
#add values for new column: p = Smartphone, v = TV, x = Laptop, q = Tablet
df$product_categories <- ifelse(df$product_code == "p", "Smartphone", 
                                ifelse(df$product_code == "v", "TV", 
                                       ifelse(df$product_code == "x", "Laptop", 
                                              ifelse(df$product_code == "q", "Tablet", 
                                                     NA))))

# Add four binary (1 or 0) columns for company: company_philips, company_akzo, company_van_houten and company_unilever
# Add four binary (1 or 0) columns for product category: product_smartphone, product_tv, product_laptop and product_tablet

# export refine_clean.csv
write.csv(refine_cleaned, 'refine_clean.csv')

# dplyr::rename(tb, y = year)
# dplyr::arrange(mtcars, mpg)
# separate(storms, date, c("y", "m", "d"))