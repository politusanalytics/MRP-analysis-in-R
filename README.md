# A Dynamic Multilevel Regression and Post-Stratification (MRP) Model

The methodological framework for the analysis here is borrowed from Leemann and Wasserfallen (2020). The model is based on one binary dependent variable, four weighting variables (one of those is for geographical units), and one additional variable for a geographical characteristic. Four weighting variables are planned as follows: gender, age, var3 (which is any other variable like education, religiosity, etc.), var_geo. We will benefit those weighting variables as random effects and employ the variable for a geographical characteristic (var_context) to hold for the fixed effect in the MRP model.

The model will take two datasets (as a user/individual level and an administrational population data) and three parameters (as the number of subcategories of the variables) as inputs and extracts a list that includes prediction for each geographical unit, and a number that shows aggregate average.
