# perfcurve
A Stata package to curve exam scores

## The Perfect Curve

The perfcurve command curves the scores of an assessment according to “The Perfect Curve: At Least for Grades” by Sher (1977).

Sher (1977) outlines the following three principles for the "perfect curve"
1. 0's remain 0's
2. 100's remain 100's
3. the curve function is monotonic

Specifically, the command identifies the mean of the uncurved scores, calculates a curve function to adjust that uncurved mean score to a new specified score, and then applied the curve function to all the scores. The curve function is applied iff the mean of the raw scores is less than the newly specified goal score.  The mean of raw score, $\overline{x}$ is curved up to specified score, $g$ according to the function $f(x)=10^(2-2n)*x^n$, where $x$ is the raw score, $n=\frac{log(g/100)}{log(\overline{x}/100)}$, $g$ is the goal score, and $\overline{x}$ is the mean of raw score.

Note that mean of the curved scores is not equal to the specified goal score, but rather, the raw mean is curved up to the specified goal score, and then the resulting curve function applied to each score.

## References
Lawrence Sher. 1977. “The Perfect Curve: At Least for Grades”.  The Two-Year College Mathematics Journal. DOI: [https://doi.org/10.2307/3027265](https://doi.org/10.2307/3027265)


