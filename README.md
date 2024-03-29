# A Dynamic Multilevel Regression and Post-Stratification (MRP) Model in R

The methodological framework for the analysis here is borrowed from Leemann and Wasserfallen (2020). The model is based on one binary dependent variable, four weighting variables (one of those is for geographical units), and one additional variable for a geographical characteristic. Four weighting variables are planned as follows: gender, age, var3 (which is any other variable like education, religiosity, etc.), var_geo. We will benefit those weighting variables as random effects and employ the variable for a geographical characteristic (var_context) to hold for the fixed effect in the MRP model.
```
model <- glmer(dep_var ~ var_context + (1|gender) + (1|age) + (1|var3) + (1|var_geo), data= user_data, 
        family=binomial("probit"))
```

The model will take two datasets (one user/individual level and one administrational population data) as inputs and extracts a list that includes prediction for each geographical unit, and a number that shows aggregate average.

As a secondary model, we also share another MRP analysis without the context level factor, and with three weighting variables (age, gender, location), instead of four. It extracts a single list as an output, called "p", which presents predicted results for combinations of predictor variables' subcategories. The structure of output is shown in an excel file in the folder, named "output structure."

Its formula:
```
model <- glmer(dep_var ~  (1|gender) + (1|age) + (1|var_geo), data= user_data, family=binomial("probit"))
```


The MRP requires following packages in R:
```
install.packages(c("foreign", "lme4", "arm", "extrafont", "readxl", "dplyr"))
```

and takes following datasets as inputs:
```
user_data <- read_excel("...")
pop_data <- read_excel("...")
```

You may find further  technical details in the "Summary" document that mainly describes the structure of datasets, and a brief theoretical explantion in the "Why does one need MRP?" document. We also share sample datasets and an R script to run the MRP analysis for those. We run the sample code in R version 4.1.2. Sample datasets and R-code for the smaller MRP analysis (with the three variables) is shared in another folder, named "MRP with three weighting variables."
