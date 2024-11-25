# Descriptive Analysis of Demographic Data (2003-2023)

## Overview
This project analyzes demographic data from the **U.S. Census Bureau's International Data Base (IDB)** for the years 2003 and 2023. The study focuses on:
- **Median Age** (stratified by gender and region),
- **Infant Mortality Rates**, and
- **Total Fertility Rates**.

The project involves data preprocessing, statistical analysis, and visualization to uncover insights into global demographic patterns and their changes over the two decades.

---

## Objectives
1. **Data Exploration**: 
   - Examine frequency distributions and variability for key variables.
   - Stratify data by gender and geographic regions.
2. **Comparative Analysis**:
   - Analyze the homogeneity and heterogeneity within and between European and African subregions.
   - Compare demographic variables between 2003 and 2023 to highlight temporal trends.
3. **Correlation Analysis**:
   - Investigate relationships between variables, such as **Median Age** and **Infant Mortality Rate**.

---
## Dataset Description
- **Source**: [U.S. Census Bureau International Data Base](https://www.census.gov/programs-surveys/international-programs/about/idb.html)
- **License**: See the [terms of use](https://www.census.gov/programs-surveys/international-programs/about/idb.html#usage).

The dataset includes demographic data for **227 countries**, stratified into five regions and 21 subregions. It provides:

- **Categorical Variables**: Country, Region, Subregion.
- **Numerical Variables**: 
  - Median Age (by gender),
  - Infant Mortality Rate (by gender),
  - Total Fertility Rate.

**Preprocessing**:
- Removed 7 missing observations.
- Converted variables to numeric format.

---

## Statistical Methods
The following methods were employed:
1. **Descriptive Statistics**:
   - Five-number summary,
   - Interquartile Range (IQR),
   - Mean, Median, Quantiles.
2. **Visualization**:
   - Histograms,
   - Boxplots,
   - Scatterplots.
3. **Correlation Analysis**:
   - Pearson correlation coefficient.

---


## Outputs

After running the analysis, the following outputs will be available.

1. **Summary Statistics**:
   - `summary_tables`: Contains descriptive statistics for Median Age, Infant Mortality Rate, and Total Fertility Rate.

2. **Visualizations**:
   - **Histograms**:
     - Frequency distributions for:
       - Median Age (both sexes, males, females),
       - Infant Mortality Rate (both sexes, males, females),
       - Total Fertility Rate.
     - Saved in the `output/histograms/` directory.
   - **Boxplots**:
     - Regional comparisons for:
       - Median Age across continents and subregions.
       - Infant Mortality Rates across continents and subregions.
       - Total Fertility Rate distributions.
     - Saved in the `output/boxplots/` directory.
   - **Scatterplots**:
     - Correlation between Median Age and Infant Mortality Rate.
     - Saved as `scatterplot_correlation.png`.

3. **Temporal Analysis**:
   - Boxplots comparing 2003 and 2023 data for key demographic variables.
   - Highlight shifts in Median Age and Infant Mortality Rates over time.

---

## Key Insights

The analysis yielded the following key observations:

### 1. Frequency Distributions
- **Median Age**:
  - Global median for both sexes (2023): **32 years** (range: 15.1 to 56.2).
  - Europe exhibited the highest median age (43.7 years), while Africa had the lowest (20.5 years).
- **Infant Mortality Rates**:
  - Global median for both sexes (2023): **11.9 deaths per 1,000 births**.
  - Lowest rates in Europe (median: 3.6); highest in Africa (median: 38.3).

### 2. Regional Variability
- **Europe**:
  - Homogeneity observed in Northern and Western Europe for Median Age.
  - Southern Europe showed the highest median age (44.6 years).
- **Africa**:
  - Greater variability in Median Age and Infant Mortality Rates across subregions.
  - Northern Africa exhibited the highest variability (IQR: 8.25 years for females).

### 3. Correlations
- Strong negative correlation between:
  - **Median Age** and **Infant Mortality Rate** (correlation coefficient ≈ **-0.79**).
  - Indicates that as populations age, infant mortality rates decline.

### 4. Temporal Trends (2003 vs. 2023)
- **Median Age**:
  - Increased globally from **25.5 years (2003)** to **32.0 years (2023)**, reflecting an aging population.
- **Infant Mortality Rate**:
  - Declined significantly from **19.6 deaths (2003)** to **11.9 deaths (2023)**, indicating improved health outcomes.
 

## References

1. U.S. Census Bureau. [International Data Base (IDB)](https://www.census.gov/programs-surveys/international-programs/about/idb.html).
2. Hadley Wickham et al. *dplyr: A Grammar of Data Manipulation* (Version 1.1.2). [CRAN R Package](https://CRAN.R-project.org/package=dplyr), 2023.
3. Hadley Wickham. *ggplot2: Elegant Graphics for Data Analysis*. Springer-Verlag New York, 2016. [ggplot2 Documentation](https://ggplot2.tidyverse.org/).
4. Taiyun Wei and Viliam Simko. *corrplot: Visualization of a Correlation Matrix* (Version 0.92). [GitHub Repository](https://github.com/taiyun/corrplot), 2021.
5. Barrett Schloerke et al. *GGally: Extension to ggplot2* (Version 2.1.2). [CRAN R Package](https://CRAN.R-project.org/package=GGally), 2021.
6. Hadley Wickham. *Reshaping Data with the reshape Package*. *Journal of Statistical Software*, 21(12), 2007. [Journal Article](https://www.jstatsoft.org/v21/i12/).

 
## License
This project is licensed under the [MIT License](LICENSE)



