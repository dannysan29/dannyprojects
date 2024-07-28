proc import datafile="/home/u63958174/sasuser.v94/healthcare_dataset.csv" 
            out=healthcare_data
            dbms=csv 
            replace;
   getnames=yes;
run;

/* Fixing the Name column to proper case */
data healthcare_data_cleaned;
	set healthcare_data;
	Name = propcase(Name);
run;

proc print data=healthcare_data_cleaned (obs=10);
run;

/* Descriptive Statistics for numerical columns */
proc means data=healthcare_data_cleaned;
   var Age 'Billing Amount'n 'Room Number'n;
run;

/* Frequency distribution for categorical columns */
proc freq data=healthcare_data_cleaned;
	tables Gender 'Medical Condition'n 'Insurance Provider'n;
run;


/* Age distribution */
proc sgplot data=healthcare_data_cleaned;
	histogram Age;
	density Age / type=kernel;
	title "Age Distribution";
run;

/* Gender distribution */
proc sgplot data=healthcare_data_cleaned;
	vbar Gender;
	title "Gender Distribution";
run;

/* Medical condition distribution */
proc sgplot data=healthcare_data_cleaned;
	vbar 'Medical Condition'n / categoryorder=respdesc;
	title "Medical Condition Distribution";
run;

/* Billing amount distribution */
proc sgplot data=healthcare_data_cleaned;
	histogram 'Billing Amount'n;
	density 'Billing Amount'n / type=kernel;
	title "Billing Amount Distribution";
run;

/* Insurance provider distribution */
proc gchart data=healthcare_data_cleaned;
   pie 'Insurance Provider'n / sumvar='Billing Amount'n;
   title "Insurance Provider Distribution";
run;

/* Age distribution by Gender */
proc sgplot data=healthcare_data_cleaned;
	histogram Age / group=Gender transparency=0.5;
	density Age / group=Gender type=kernel;
	title "Age Distribution by Gender";
run;

/* Box plot of Billing Amount by Medical Condition */
proc sgplot data=healthcare_data_cleaned;
	vbox 'Billing Amount'n / category='Medical Condition'n;
	title "Box Plot of Billing Amount by Medical Condition";
run;

/* Bar plot of Medical Condition by Gender */
proc sgplot data=healthcare_data_cleaned;
	vbar 'Medical Condition'n / group=Gender groupdisplay=cluster;
	title "Medical Condition by Gender";
run;

/* Correlation analysis between numerical variables */
proc corr data=healthcare_data_cleaned;
	var Age 'Billing Amount'n 'Room Number'n;
run;

/* Frequency distribution for Medical Condition by Gender */
proc freq data=healthcare_data_cleaned;
	tables 'Medical Condition'n*Gender / norow nocol nopercent;
run;

/* Creating age groups and segmenting data */
data healthcare_data_segmented;
	set healthcare_data_cleaned;
	if Age < 20 then Age_Group = 'Under 20';
	else if 20 <= Age < 40 then Age_Group = '20-39';
   else if 40 <= Age < 60 then Age_Group = '40-59';
   else Age_Group = '60+';
run;

proc freq data=healthcare_data_segmented;
	tables Age_Group*'Medical Condition'n / norow nocol nopercent;
run;

/* Simple linear regression model to predict Billing Amount based on Age and Medical Condition */
proc glm data=healthcare_data_cleaned plots(maxpoints=100000);
	class 'Medical Condition'n;
	model 'Billing Amount'n = Age 'Medical Condition'n;
	title "Predictive Model for Billing Amount";
run;
quit;

/* Histogram for Length of Stay */
data healthcare_data_cleaned;
	set healthcare_data;
	length_of_stay = 'Discharge Date'n - 'Date of Admission'n;
run;

proc sgplot data=healthcare_data_cleaned;
	histogram length_of_stay;
	density length_of_stay / type=kernel;
	title "Length of Stay Distribution";
run;

/* Scatter plot between Age and Billing Amount */
proc sgplot data=healthcare_data_cleaned;
	scatter x=Age y='Billing Amount'n / group=Gender;
	title "Age vs. Billing Amount of Gender";
run;

/* Heatmap for Correlation Analysis */
proc corr data=healthcare_data_cleaned plots(maxpoints=100000);
    var Age 'Billing Amount'n 'Room Number'n length_of_stay;
run;

/* Handle Missing Values */
proc means data=healthcare_data_cleaned n nmiss;
run;

/* Impute Missing Values (if any) */
data healthcare_data_imputed;
    set healthcare_data_cleaned;
    if Age = . then Age = median(Age);
    /* Apply similar imputation for other variables */
run;

/* Feature Engineering */
data healthcare_data_features;
    set healthcare_data_imputed;
    if 'Medical Condition'n = "Critical" then critical_flag = 1;
    else critical_flag = 0;
run;

/* Regression Analysis */
proc glm data=healthcare_data_features;
	class Gender;
    model 'Billing Amount'n = Age Gender critical_flag;
    title "Regression Analysis for Billing Amount";
run;

/* Advanced Visualization: Heatmap */
proc sgplot data=healthcare_data_features;
   heatmap x=Age y='Billing Amount'n / colorresponse='Room Number'n colormodel=(blue yellow red);
   title "Heatmap of Age vs. Billing Amount by Room Number";
run;

/* Interactive Plot Export */
proc export data=healthcare_data_features
            outfile='/home/u63958174/sasuser.v94/file.xlsx'
            dbms=xlsx replace;
run;