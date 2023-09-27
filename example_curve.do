clear all

/*	Set Working Directory to Location of Data 
	commented out for example */
* cd 

/*	Import Data */
import delimited "fictional_q1.csv"

/*	Curve Grades 
	Here, the curve function is set to transform the pre-curve average (62.96) to an 80 */
perfcurve q1 80

/*  Add Bonus (up to 100 pts total) 
	It is critical that this step is done after the curve. 
	If the Bonus is added before the curve, it no longer functions as an optinal bonus 
	If there is no bonus, this block can be skipped */
gen nocurve=q1+bonus 
	label variable nocurve "Uncurved Q1 Score with Bonus"

gen q1_final=q1_curved + bonus 
replace q1_final=100 if q1_final>100 & q1_final!=. 
	label variable q1_final "Curved Q1 with Bonus"
	label variable q1_curved "Curved Q1 pre Bonus"

/* Section Rankings */	
egen n_q1_final = count(q1_final) 
egen i_q1_final = rank(q1_final) , track 
sum i_q1_final
gen rank = r(max)-i_q1_final+1
	label variable rank "Class Rank"
gen pcrank = ((i_q1_final - 1) / (n_q1_final - 1))*100  
	label variable pcrank "Percentile Rank"
drop n_q1_final i_q1_final


/* Generate Standard Letter Grades */
gen     std_let = "F"  if q1_final<60
replace std_let = "D"  if q1_final>=60 & q1_final <67
replace std_let = "D+" if q1_final>=67 & q1_final <70
replace std_let = "C-" if q1_final>=70 & q1_final <73
replace std_let = "C"  if q1_final>=73 & q1_final <77
replace std_let = "C+" if q1_final>=77 & q1_final <80
replace std_let = "B-" if q1_final>=80 & q1_final <83
replace std_let = "B"  if q1_final>=83 & q1_final <87
replace std_let = "B+" if q1_final>=87 & q1_final <90
replace std_let = "A-" if q1_final>=90 & q1_final <93
replace std_let = "A"  if q1_final>=93
replace std_let = " "  if q1_final==.
label variable std_let "Letter Grade"

tab std_let 

/* Order Variables */
order first last id q1_final curve4q1 std_let rank pcrank nocurve  q1 bonus q1_curved

/* Summerize Grades */
sum nocurve q1_final curve4q1

/* Sort Data */
sort last first

/* Export Data */
*export delimited first last id q1_final curve4q1_final rank q1 bonus using "q1_final.csv", replace

scatter pcrank q1_final, mlabel(std_let) ms(none) mlabposition(0)
