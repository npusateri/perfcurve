program perfcurve
version 14.0

/*Obtain mean of raw grade*/
quietly: sum `1'
scalar xbar=r(mean)

/*Obtain n*/
scalar n = (ln(`2'/100))/(ln(xbar/100))

/*Curve grades iff Raw Grade Mean is less than Desired Revised Score */
    if xbar < `2' {
                quietly: generate `1'_curved = 10^(2-2*n)*`1'^(n)
				quietly: replace `1'_curved = round(`1'_curved,1)
                label variable `1'_curved "Curved `1'"
                
                quietly: generate curve4`1' = `1'_curved-`1'
                label variable curve4`1' "Curve for `1'"

                /* Obtain mean of curved grade */
                quietly sum `1'_curved
                scalar ybar=r(mean)

                /* Display curve function */
                scalar f1 = 10^(2-2*n)
                display "The curve function is: f(x) = " f1 "*x^" n

                /* Display count, mean, median, standard deviation, min, max, and inter-quartile range (75-25) for orginal and curved grades */
                tabstat `1' `1'_curved curve4`1', stats(n mean median sd min max iqr)
            }

            else {
                display "No Curve Applied; Raw Grade Mean is Greater than or Equal to Desired Revised Score"
            }

/* End Program */
end
