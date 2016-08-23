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

