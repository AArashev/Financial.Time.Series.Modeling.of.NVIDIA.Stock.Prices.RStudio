**Advanced Time Series Analysis and Forecasting for NVIDIA Corporation (NVDA) Stock Prices**
Project Overview

This project performs a detailed time series analysis on NVIDIA Corporation's stock prices over a ten-year period (January 2012 to January 2022). Using R's statistical computing capabilities, the project decomposes, models, and forecasts the stock price behavior. An ARIMA model is initially applied, and a GARCH model is later implemented to account for volatility clustering.
Packages Purpose

**The following R packages are employed for various stages of financial data analysis and visualization:**

    quantmod: For fetching financial stock data.
    forecast: To facilitate time series forecasting.
    tseries: For conducting statistical tests and time series analysis.
    FinTS: Focuses on financial time series analysis.
    rugarch: Fits GARCH models to capture volatility patterns.
    PerformanceAnalytics: Provides performance and risk metrics for financial market analysis.
    ggplot2: Utilized for advanced data visualization.

**1. Time Series Decomposition**

The NVIDIA stock prices are decomposed into three components:

    Trend: A general increase is observed over the period, indicating a rising stock value.
    Seasonal: Displays periodic cyclical patterns, although not overly dominant.
    Random: Represents irregular fluctuations typical in financial series.

**2. Stationarity and Differencing**

Tests for stationarity are conducted to confirm the suitability of the time series for modeling:

    Augmented Dickey-Fuller (ADF) and Phillips-Perron (PP) Tests: Both tests indicate non-stationarity with p-values of 0.99.
    KPSS Test: Confirms non-stationarity with a p-value of 0.01.
    After applying a first difference transformation, the ADF and PP tests suggest that the series becomes stationary.

**3. Autocorrelation Functions**

    ACF Plot: Displays significant autocorrelations at subsequent lags, suggesting non-stationarity.
    PACF Plot: Measures the correlation of the series with its lags, showing no significant correlation when intermediate effects are removed.

**4. ARIMA Modeling and BIC Comparison**

The ARIMA model is used to forecast NVIDIA stock prices:

    ARIMA(520) Model: The model comprises 5 autoregressive terms, 2 differences, and no moving average terms.
    BIC Value: A BIC (Bayesian Information Criterion) value of 11578.97 is calculated, providing a basis for model selection.

**5. Residual Diagnostics and Tests**
    Box-Ljung Test: Applied to residuals and their squares to detect autocorrelation.
        Residuals Test: p-value of 0.1784 indicates no significant autocorrelation.
        Squared Residuals Test: p-value < 2.2e-16 suggests strong evidence of autocorrelation, indicating potential volatility clustering.
    Shapiro-Wilk Normality Test: Tests residual normality and identifies deviations.

**6. Normal Q-Q Plot of Residuals**

A Q-Q plot is generated to visualize deviations from normality, particularly evident in the tails.
**7. Evaluation and Forecasting with GARCH Model**

    GARCH(10) Model Implementation: Addresses volatility clustering in the NVIDIA stock prices, capturing the influence of prior volatility on current volatility.
    Forecast Outputs:
        Price Forecasts: Initial price is forecasted at 138.622 (T+1), with subsequent predictions remaining constant.
        Volatility Estimates: Forecasted to marginally decrease over time, suggesting stable volatility.

**8. Discussion**

The project's forecast reveals a constant stock price prediction post the initial forecast point, which contradicts typical stock behavior. The findings highlight the need to assess model suitability and contextualize forecasts within broader market conditions.
**9. Conclusion**

This project highlights the complexities of financial time series forecasting using ARIMA and GARCH models. The unexpected steadiness in price predictions and diminishing volatility showcase the limitations of traditional models and the need for continuous refinement and external market analysis.
How to Use This Project

    Clone the Repository: Download the project files to your local machine.
    Install Required Packages: Use install.packages() in R to install the necessary libraries.
    Run the Analysis: Follow the R scripts to perform time series decomposition, stationarity tests, ARIMA modeling, and GARCH forecasting on NVIDIA stock data.
    Visualize and Interpret Results: Use provided plots and summaries to interpret trends, autocorrelation, and forecast results.
