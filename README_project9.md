# Comprehensive Healthcare Data Analysis Using SAS

## Project Overview
This project involves analyzing a large healthcare dataset using SAS. The tasks include data import, cleaning, descriptive statistics, visualizations, correlation analysis, regression modeling, and exporting the processed data.

## Data
- healthcare_dataset.csv: The original dataset used for the analysis.

## Output
- file.xlsx: The processed and cleaned dataset exported to an Excel file.

## Scripts
- healthcare_analysis.sas: The SAS script containing the entire analysis workflow.

## Steps Involved
1. **Data Import and Cleaning**
   - Imported the dataset using 'proc import'.
   - Cleaned and transformed the data.

2. **Descriptive Statistics**
   - Conducted descriptive statistics for numerical and categorical variables using 'proc means' and 'proc freq'.

3. **Data Visualization**
   - Created various visualizations such as histograms, bar plots, box plots, and scatter plots using 'proc sgplot'.

4. **Correlation and Regression Analysis**
   - Performed correlation analysis using 'proc corr'.
   - Built regression models to predict billing amounts using 'proc glm'.

5. **Feature Engineering**
   - Created new features and handled missing values.

6. **Data Export**
   - Exported the cleaned dataset to an Excel file using 'proc export'.

## How to Use
1. Clone the repository.
2. Run the 'healthcare_analysis.sas' script in SAS.
3. The cleaned dataset will be available in the 'output' folder as 'file.xlsx'.