# COVID-19-Case-Count-Interpolation-Using-Cubic-Splines
The goal is to construct a natural cubic spline that interpolates the given data points, which represent the total number of confirmed COVID-19 cases in Greece over an eight-week period, from March 2, 2020, to April 27, 2020.

Here are the main tasks that have been completed in this project:

1. Cubic Spline Construction: A natural cubic spline has been constructed to accurately fit all the provided data points. The parameters (ai, bi, ci, di) have been calculated for each cubic polynomial Si(x) of the spline.

2. COVID-19 Case Calculation: For each of the 57 days between March 2 and April 27, the corresponding number of COVID-19 cases has been calculated using the constructed spline. These values have been rounded to the nearest integer. The results have been organized in a two-column table, with the first column representing the date, and the second column containing the calculated case numbers.

3. Comparison with Actual Data: The provided Excel file "covid-data.xlsx" contains the actual values of the total number of confirmed COVID-19 cases announced for each day. A plot has been created using the "plot" command to compare the actual and calculated curves for the total number of cases. Additionally, an analysis of the results has been provided.
