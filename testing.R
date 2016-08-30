# Setup environment
library(devtools)
library("tidyr")
library("dplyr")
library(stringr)

# Load dataset
ds <- read.csv("refine_original.csv")
tbl_df(ds)


ds$company <- tolower(ds$company)
# ds$company <- str_replace(ds$company,"k\\sz","kz")
# ds$company <- str_replace(ds$company,"z[0-9]","zo")

# sub("(a+)", "z\\1z", c("abc", "def", "cba a", "aa"), perl=TRUE)

gsub("ak.", "akzo", ds, perl=TRUE)
gsub("ph.", "phillips", ds, perl=TRUE)
gsub("un.", "unilever", ds, perl=TRUE)

View(ds)