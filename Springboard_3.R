install.packages("tidyr")
install.packages("dplyr")
install.packages("devtools")
library("tidyr", lib.loc="~/R/win-library/3.3")
library("dplyr", lib.loc="~/R/win-library/3.3")
library(devtools)
refine_original <- read.csv("C:/Users/ababen/Downloads/refine_original.csv")
View(refine_original)
refine2 <- refine_original
refine2 <- unite(refine1,full_address,c("address","city"), sep = ",",remove = TRUE)
refine2 <- unite(refine1,full_address,c("address":"country"), sep = ",",remove = TRUE)

