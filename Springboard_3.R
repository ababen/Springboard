install.packages("tidyr")
install.packages("dplyr")
install.packages("devtools")
library("tidyr")
library("dplyr")
library(devtools)
refine_original <- read.csv("/users/ababen/Springboard/refine_original.csv")
View(refine_original)
refine1 <- refine_original
refine2 <- unite(refine1,full_address,c("address","city"), sep = ",",remove = TRUE)
refine2 <- unite(refine1,full_address,c("address":"country"), sep = ",",remove = TRUE)

# Please run these two steps together to see the problem.

refine3 <- gsub("ak zo","akzo",refine1,ignore.case=T)
refine3 # I don not understand why gsub placed the 

# This is the example I am working off of:

#Case insensitive replace:
#  > gsub("tut","ot",x,ignore.case=T))
#[1] "R otorial"

# I am going to attemp the same with replace()

if (refine1 != null) {
  refine1 <- refine_original
}
replace(refine1, c("ak zo","akzo"), "akzo")

# Cheated here and used Excel to get the below list. Wonder if there is any easy way of doing this with R.
# c("ak zo", "akz0", "AKZO", "Akzo", "akzo")
# c("philips", "Phillips", "phillps", "phlips", "phllips", "fillips")
# c("Unilever", "unilver")
# c("Van Houten", "Van Hausen")
