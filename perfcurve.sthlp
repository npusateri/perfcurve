{smcl}
{* *! version 1.1 27september2023}{...}
{findalias asfradohelp}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] help" "help help"}{...}
{viewerjumpto "Syntax" "perfcurve##syntax"}{...}
{viewerjumpto "Description" "perfcurve##description"}{...}
{viewerjumpto "Examples" "perfcurve##examples"}{...}
{viewerjumpto "References" "perfcurve##references"}{...}
{title:Perfect Curve}

{phang}
{bf:perfcurve} {hline 2} Curves the scores of an assessment according to {help perfcurve##LS1997: “The Perfect Curve: At Least for Grades” by Sher (1977)}.

{marker syntax}{...}
{title:Syntax}

{p 8 17 2}
{cmdab:perfcurve}
[{var}] [#]

{marker description}{...}
{title:Description}

This program curves scores accoring to the following three principles: (1) 0's remain 0's, (2) 100's remain 100's, 
and (3) the curve function is monotonic. 

{pstd}
{cmd:perfcurve} curves the scores of a {var} according to {help perfcurve##LS1997: Sher (1977)}. 
The curve is applied {it:iff} the mean of the raw scores is less than the desired score, #.
The mean of {var} is curved up to # according to the function f(x)=10^(2-2n)*x^n,
where n=log(#/100)/log(xbar/100), where xbar is the mean of {var}. 

{pstd}
If the curve is applied, {bf:perfcurve} generates two new variables: (1) {var}_curved: the curved scores and
(2) curve4{var}: the per score curve for each score. 

{pstd}
{bf:perfcurve} reports the number, mean, median, standard deviation, min, max, and inter-quartile range 
of the original scores, the curved scores, and the curve.

{pstd}
If the mean of the raw scores is greater than or equal to the desired score, #, the curve is not applied.

{marker examples}{...}
{title:Examples}

{phang}{cmd:. perfcurve quiz1 80}{p_end}

{pstd} where the mean score of quiz1 will be curved to an 80, and the curve function will be applied to each score. 
Note that mean of quiz1_curved is not an 80, but rather, the orignal mean is curved up to an 80, 
and then the resulting curve applied to each score.


{marker references}{...}
{title:References}

{phang}
{browse "https://github.com/npusateri/perfcurve": “perfcurve on Github”}  

{marker LS1997}{...}
{phang}
Lawrence Sher. 1977.
{browse "https://doi.org/10.2307/3027265": “The Perfect Curve: At Least for Grades”.}
The Two-Year College Mathematics Journal
