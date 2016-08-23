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