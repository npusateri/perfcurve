/* Program to Curve Grades Based on “
    The Perfect Curve: At Least for Grades” 
    by Lawrence Sher 
    in The Two-Year College Mathematics Journal, Jun., 1977, Vol. 8, No. 3, pp. 148-152

 There are two arguments:
    1. The name of the variable to be curved
    2. The desired revised score of the raw variable's mean 

The program will create a new variable with the name of the raw variable plus "_adj" and label it "Curved" plus the name of the raw variable.

The program will also create a new variable with the name of the raw variable plus "_curve" and label it "Curve for" plus the name of the raw variable.

Finally, the program will also create a new variable with the name of the raw variable plus "_rndadj" and label it "Curved and Rounded" plus the name of the raw variable and round it to the nearest tenth.

The program will not curve the variable if the raw variable's mean is greater than or equal to the desired revised score.

The curve has the following three properties
    1. 0's remain 0's
    2. 100's remain 100's
    3. The curve funtion is monotonic

The curve function is:
    f(x) = 10^(2-2n)*x^n

where n is the ln(Desired Revised Score/100)/ln(Raw Grade Mean/100)
*/

program perfcurve
version 15.0

/*Obtain mean of raw grade*/
quietly: sum `1'
scalar xbar=r(mean)

/*Obtain n*/
scalar n = (ln(`2'/100))/(ln(xbar/100))

/*Curve grades iff Raw Grade Mean is less than Desired Revised Score */
    if xbar < `2' {
                quietly: generate `1'_adj = 10^(2-2*n)*`1'^(n)
                label variable `1'_adj "Curved `1'"
                quietly: generate `1'_rndadj = round(`1'_adj,1)
                label variable `1'_rndadj "Curved and Rounded `1'"
                quietly: generate `1'_curve = `1'_adj-`1'
                label variable `1'_curve "Curve for `1'"

                /* Obtain mean of curved grade */
                quietly sum `1'_adj
                scalar ybar=r(mean)

                /* Display curve function */
                scalar f1 = 10^(2-2*n)
                display "The curve function is: f(x) = " f1 "*x^" n

                /* Display count, mean, median, standard deviation, min, max, and inter-quartile range (75-25) for orginal and curved grades */
                tabstat `1' `1'_adj `1'_rndadj, stats(n mean median sd min max iqr)
            }

            else {
                display "No Curve Applied; Raw Grade Mean is Greater than or Equal to Desired Revised Score"
            }

/* End Program */
end