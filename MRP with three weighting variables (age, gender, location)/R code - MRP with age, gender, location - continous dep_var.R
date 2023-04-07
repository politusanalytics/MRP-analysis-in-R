#A Dynamic Multilevel Regression and Post-Stratification (MRP) Model

install.packages("foreign", repos = "http://cran.us.r-project.org")
install.packages("lme4", repos = "http://cran.us.r-project.org")
install.packages("arm", repos = "http://cran.us.r-project.org")
install.packages("extrafont", repos = "http://cran.us.r-project.org")
install.packages("readxl", repos = "http://cran.us.r-project.org")
install.packages("dplyr", repos = "http://cran.us.r-project.org")

library(foreign)
library(lme4)
library(arm)
library(extrafont)
library(readxl)
library(dplyr)

#Set working directory if necessary:
#setwd(dirname(rstudioapi::getSourceEditorContext()$path))

setwd("C:/Users/user/Desktop/Election prediction/MRP with three weighting variables (age, gender, location)")
getwd()

#Read two input datasets:
user_data <- read.csv(file = "sample_user_data.csv")

#We consider gender has two subcategories. The numbers of subcategories for other variables are calculated as follows:
N_age <- length(unique(user_data$age))
N_geo <- length(unique(user_data$var_geo))

#Multi-level regression model:
model <- glmer(dep_var ~ 1 + (1|gender) + (1|age) + (1|var_geo), data=user_data, family=gaussian(link = "identity"))

#Realizations of the random effects:
re.gender <- ranef(model)$gender[[1]]
re.age <- ranef(model)$age[[1]]
re.var_geo <- ranef(model)$var_geo[[1]]

#Calculate total numbers of combinations.:
N_cat <- 2 * N_age
N_total <- N_cat * N_geo

#Repeat the realizations such that all combinations are given, in the same order with Table 1 (in the Summary document):
gender.re <- rep(re.gender,N_age)
age.re <- rep(kronecker(re.age,c(1,1)), 1)
ind.re <- rowSums(cbind(gender.re, age.re))
ind.re <- ind.re + fixef(model)

#Create a vector of length N_cat * N_geo:
y.lat <- rep(NA,N_total)
for (i in 1:N_geo){
  a <- ((i-1)*N_cat)+1
  b <- a + N_cat-1
  y.lat[a:b] <- ind.re + re.var_geo[i]
}

#Transform those to predicted probabilities:
y.lat

#Create an output data
gender <- rep(c('male','female'), N_geo*N_age)
age <- rep(kronecker(c('18'=0,'19-29'=1,'30-39'=2,'40'=3), c(1,1)), N_geo)
var_geo <- rep(kronecker(1:N_geo, c(1,1,1,1,1,1,1,1)), 1)

output <- list(var_geo = var_geo,
               age = age,
               gender = gender,
               dep_var = y.lat)

write.csv(output, file='output.csv')
