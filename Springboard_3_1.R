# Setup environment
library(devtools)
library("tidyr")
library("dplyr")
library(stringr)
# Load dataset
ds_original <- read.csv("refine_original.csv")
tbl_df(ds_original)

#Combine address fields
ds_cleaned <- unite(ds_original,full_address,c(address:country), sep = ", ",remove = TRUE)

# Standardizing company names
# ds_cleaned$company <- str_replace(ds_cleaned$company,"k\\sz","kz")
# ds_cleaned$company <- str_replace(ds_cleaned$company,"z[0-9]","zo")

ds_cleaned <- ds_cleaned %>% 
replace(ds_cleaned$company == c("ak zo", "akz0"), "akzo") %>%
replace(ds_cleaned$company == c("phillips", "phillps", "phlips", "phllips"), "philips") %>%
replace(ds_cleaned$company == c("uniliver"), "unilever") %>%
replace(ds_cleaned$company == c("Van Hausen"), "van houten")
ds_cleaned$company <- tolower(ds_cleaned$company)

# Seperate Product Code & Number
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

# Add four binary (1 or 0) columns for company: company_philips, company_akzo, company_van_houten and company_unilever
# Add four binary (1 or 0) columns for product category: product_smartphone, product_tv, product_laptop and product_tablet
ds_cleaned <- mutate(ds_cleaned,
                 company_philips = as.integer(company == 'philips'), 
                 company_akzo = as.integer(company == 'akzo'),
                 company_van_houten = as.integer(company == 'van houten'),
                 company_unilever = as.integer(company == 'unilever'),
                 product_smartphone = as.integer(product_code == 'p'), 
                 product_tv = as.integer(product_code == 'v'),
                 product_laptop = as.integer(product_code == 'x'),
                 product_tablet =  as.integer(product_code == 'q')
)

# Confirm result
View(ds_cleaned)

# export ds_clean.csv
write.csv(ds_cleaned, 'refined_clean.csv')