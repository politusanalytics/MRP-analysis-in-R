# A Dynamic Multilevel Regression and Post-Stratification (MRP) Model

Using the data extracted from online networks for election prediction is often criticized as having a solid demographic bias, referring to a well-known phenomenon that participation in online networks is strongly affected by users' age, sex, education level, race, income level, etc. To deal with this demographic bias, it is suggested to use the multilevel regression and post-stratification method (MRP), which is based on an adjustment of every possible combination of characteristics according to their actual representations in the population. The method has been developed to predict national-level data by non-representative polls or data for smaller areas from representative surveys (called small area estimation). 

The methodological framework for the analysis here is borrowed from Leemann and Wasserfallen (2020). The model is based on one binary dependent variable, four weighting variables (one of those is for geographical units), and one additional variable for a geographical characteristic. Four weighting variables are planned as follows: gender, age, var3 (which is any other variable like education, religiosity, etc.), var_geo. We will benefit those weighting variables as random effects and employ the variable for a geographical characteristic (var_context) to hold for the fixed effect in the MRP model.

The model will take two datasets (as a user/individual level and an administrational population data) and three parameters (as the number of subcategories of the variables) as inputs and extracts a list that includes prediction for each geographical unit, and a number that shows aggregate average.
