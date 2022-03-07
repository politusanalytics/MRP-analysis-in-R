#A Dynamic Multilevel Regression and Post-Stratification (MRP) Model

install.packages("foreign")
install.packages("lme4")
install.packages("arm")
install.packages("extrafont")
install.packages("readxl")

library(foreign)
library(lme4)
library(arm)
library(extrafont)
library(readxl)

#Two input datasets:
user_data <- read_excel("")
pop_data <- read_excel("")

#Multi-level regression model:
model <- glmer(dep_var ~ var_context + (1|gender) + (1|age) + (1|var3) + (1|var_geo), data= user_data, family=binomial("probit"))

#Realizations of the random effects:
re.gender <- ranef(model)$gender[[1]]
re.age <- ranef(model)$age[[1]]
re.var3 <- ranef(model)$var3[[1]]
re.var_geo <- ranef(model)$var_geo[[1]]

#We consider gender has two subcategories. The numbers of subcategories for other variables are three numeric inputs of the model.
#Three input parameters:
N_age <-
N_3 <- 
N_geo <-

#Calculate total numbers of combinations.:
N_cat <- 2 * N_age * N_3
N_total <- N_cat * N_geo

#Repeat the realizations such that all combinations are given, in the same order with Table 1 (in the Summary document):
gender.re <- rep(re.gender,2*N_3)
age.re <- rep(kronecker(re.age,c(1,1)), N_3)
var3.re <- kronecker(re.var3,rep(1, N_1*2))
ind.re <- rowSums(cbind(re.gender, re.age, re.var3))
ind.re <- ind.re + fixef(model)[1]
beta1 <- fixef(model)[2]

#Produce a list for var_context, grouped at geographical level:
var_context <- user_data %>% group_by(var_geo) %>% summarise(v_c=mean(var_context)) %>% .$v_c

#Create a vector of length N_cat * N_geo:
y.lat <- rep(NA,N_total)
for (i in 1:N_geo){
  a <- ((i-1)*N_cat)+1
  b <- a + Ncat-1
  y.lat[a:b] <- ind.re + beta1 * var_context[i] + re.var_geo[i]
}

#Transform those to predicted probabilities:
p <- pnorm(y.lat)

#Calculate total average:
total_average <- sum(p*pop_data)/sum(pop_data)

#Create a list for the averages at the level of geographical units:
list_of_averages_for_units <- rep(NA,N_geo)
for (i in 1:N_geo){
  a1 <- ((i-1)*N_cat)+1
  a2 <- a1 + N_cat-1
  p2 <- pnorm(y.lat[a1:a2])
  a <- pop_data[,i]
  list_of_averages_for_units[i] <-  sum(p*a)/sum(a)
}

#The two outputs are total_average and list_of_averages_for_units!
