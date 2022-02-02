# ce_unit: Cost-effectiveness analysis user-defined types

When used in expression, it automatically converts units, and simplifies units of results when possible; in case of incompatible units, errors are raised.
The class flexibly allows expansion beyond predefined units.
Using units may eliminate a whole class of potential programming mistakes.

The units could include:
* cost
* QALYs
* DALYs
* (life) time (years)
* natural units like numbers of deaths, cases, etc

For example, see documentation for the units package [here](https://cran.r-project.org/web/packages/units/vignettes/measurement_units_in_R.html).
