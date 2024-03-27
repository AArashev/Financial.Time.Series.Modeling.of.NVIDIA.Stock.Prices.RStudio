# Install and load necessary packages
install.packages("quantmod")
install.packages("forecast")
install.packages("tseries")
install.packages("FinTS")
install.packages("rugarch")
install.packages("portes")
install.packages("tseries")
install.packages("urca")
install.packages("PerformanceAnalytics")

library(quantmod)
library(forecast)
library(tseries)
library(FinTS)
library(rugarch)
library(portes)
library(PerformanceAnalytics)
library(quantmod)
library(ggplot2)


# Retrieve NVIDIA stock data
getSymbols("NVDA", from="2012-01-01", to="2022-01-01", src="yahoo")
data <- NVDA$NVDA.Close

# Convert to time series and plot
data.ts <- ts(data, frequency=30)
plot(data, type="l", col="black", main="NVIDIA Corporation")

# Decompose time series and plot
decomp <- decompose(data.ts, "multiplicative")
plot(decomp)

#TESTS______________________________________________
# Stationarity tests
adf.test(data.ts, alternative='stationary')
pp.test(data.ts, alternative='stationary')
kpss.test(data.ts)
plot(diff(data.ts), type="l", col="black", main="After First Difference")


# Stationarity tests on log-differenced data
adf.test(diff(log(data.ts)), alternative='stationary')
pp.test(diff(log(data.ts)), alternative='stationary')
kpss.test(diff(log(data.ts)))

# Autocorrelation functions
acf(data.ts, type = "correlation", main="Autocorrelation Function (ACF)")
pacf(data.ts, main="Partial Autocorrelation Function (PACF)")

# Prepare data for ARIMA and fit models
modelauto <- auto.arima(data, seasonal = TRUE)
print(BIC(modelauto))
print(modelauto)

model1 <- arima(data.ts1, order=c(1,0,0), seasonal = list(order=c(1,0,0), period=30))
model2 <- arima(data.ts1, order=c(1,0,2), seasonal = list(order=c(1,0,0), period=30))
model3 <- arima(data.ts1, order=c(2,0,0), seasonal = list(order=c(1,0,0), period=30))
model4 <- arima(data.ts1, order=c(2,0,2), seasonal = list(order=c(2,0,0), period=30))
model5 <- arima(data.ts1, order=c(2,0,3), seasonal = list(order=c(1,0,0), period=30))

print(BIC(model1))
print(BIC(model2))
print(BIC(model3))
print(BIC(model4))
print(BIC(model5))

forecasted_values <- forecast(modelauto, h=12)
print(forecasted_values)
plot(forecasted_values, main="Forecast of NVDA Stock Prices")





plot(residuals(modelauto), main="Residuals of SARIMA(1,1,0)(1,0,0)")



Box.test(residuals(modelauto), lag=1, type="Ljung-Box")

Box.test(residuals(modelauto)^2, lag=1, type="Ljung-Box")

shapiro.test(residuals(modelauto))

shapiro.test(residuals(modelauto)^2)

qqnorm(residuals(modelauto), pch=1, frame=FALSE)

qqline(residuals(modelauto), col="red", lwd=2)




# Fitting the ARIMA model and extracting the residuals

resid_arima <- residuals(modelauto)

# Loading the rugarch package
library("rugarch")

# Specifying and fitting GARCH models to the ARIMA residuals
# Replace 'data.ts1' with 'resid_arima', which are the residuals from the ARIMA model

# GARCH(1,0)
garch1 <- ugarchfit(spec = ugarchspec(mean.model = list(armaOrder = c(0,1), include.mean = TRUE), 
                                      variance.model = list(model = "sGARCH", garchOrder = c(1, 0))), 
                    solver = 'hybrid', data = data)summary(garch1)

# GARCH(1,2)
garch2 <- ugarchfit(spec = ugarchspec(mean.model = list(armaOrder = c(0,1), include.mean = TRUE), 
                                      variance.model = list(model = "sGARCH", garchOrder = c(1, 2))), 
                    solver = 'hybrid', data = data)
summary(garch2)

# GARCH(2,1)
garch3 <- ugarchfit(spec = ugarchspec(mean.model = list(armaOrder = c(0,1), include.mean = TRUE), 
                                      variance.model = list(model = "sGARCH", garchOrder = c(2, 1))), 
                    solver = 'hybrid', data = data)
summary(garch3)

# GARCH(2,2)
garch4 <- ugarchfit(spec = ugarchspec(mean.model = list(armaOrder = c(0,1), include.mean = TRUE), 
                                      variance.model = list(model = "sGARCH", garchOrder = c(2, 2))), 
                    solver = 'hybrid', data = data)
summary(garch4)

# GARCH(2,3)
garch5 <- ugarchfit(spec = ugarchspec(mean.model = list(armaOrder = c(0,1), include.mean = TRUE), 
                                      variance.model = list(model = "sGARCH", garchOrder = c(2, 3))), 
                    solver = 'hybrid', data = data)
summary(garch5)

# Forecasting with one of the GARCH models (example with garch2)
  forecast_garch1 <- ugarchforecast(garch1, n.ahead = 10)
print(forecast_garch1)
plot(forecast_garch1)




orecast_garch1 <- ugarchforecast(garch1, n.ahead = 10)

print(forecast_garch1)
plot(forecast_garch1)





















#_______A/B test
# Set the time period for the stock data
start_date <- as.Date("2012-01-01")
end_date <- as.Date("2022-01-01")

# Fetch stock data for NVDA and AMD from Yahoo Finance
getSymbols("NVDA", from = start_date, to = end_date, src = "yahoo")
getSymbols("AMD", from = start_date, to = end_date, src = "yahoo")

# Calculate daily returns for NVDA and AMD
nvda_returns <- dailyReturn(NVDA$NVDA.Adjusted)
amd_returns <- dailyReturn(AMD$AMD.Adjusted)

# Combine the returns into a single data frame for plotting
combined_returns <- merge.xts(nvda_returns, amd_returns)
colnames(combined_returns) <- c("NVDA", "AMD")

# Convert to a data frame for ggplot
combined_returns_df <- fortify.zoo(combined_returns)

# Plot the returns
ggplot(data = combined_returns_df, aes(x = Index)) +
  geom_line(aes(y = NVDA, color = "NVDA")) +
  geom_line(aes(y = AMD, color = "AMD")) +
  labs(title = "NVDA vs AMD Stock Returns", x = "Time", y = "Daily Returns") +
  scale_color_manual(values = c("NVDA" = "green", "AMD" = "red"))

# Calculate correlation between NVDA and AMD returns
correlation <- cor(combined_returns[, "NVDA"], combined_returns[, "AMD"])
print(paste("Correlation between NVDA and AMD returns: ", correlation))



#A/B testing 
#_____________________________________________________________________________________
risk_free_rate <- 0.01


# Calculate daily returns for NVDA and AMD
nvda_returns <- dailyReturn(NVDA$NVDA.Adjusted)
amd_returns <- dailyReturn(AMD$AMD.Adjusted)

# Convert to vectors for calculations
nvda_returns_vector <- coredata(nvda_returns)
amd_returns_vector <- coredata(amd_returns)

# Get market data for beta calculations, using S&P 500 as an example
getSymbols("^GSPC", from="2012-01-01", to="2022-01-01", src="yahoo")
market_returns <- dailyReturn(GSPC$GSPC.Adjusted)
market_returns_vector <- coredata(market_returns)

# Calculate volatility (standard deviation of returns)
nvda_sd <- sd(nvda_returns_vector)
amd_sd <- sd(amd_returns_vector)

# Calculate Sharpe Ratios
nvda_sharpe <- (mean(nvda_returns_vector) - risk_free_rate) / nvda_sd
amd_sharpe <- (mean(amd_returns_vector) - risk_free_rate) / amd_sd

# Calculate Betas
nvda_beta <- cov(nvda_returns_vector, market_returns_vector) / var(market_returns_vector)
amd_beta <- cov(amd_returns_vector, market_returns_vector) / var(market_returns_vector)

# Calculate average trading volume
nvda_volume <- mean(NVDA$NVDA.Volume)
amd_volume <- mean(AMD$AMD.Volume)

# Calculate maximum drawdowns
nvda_mdd <- maxDrawdown(nvda_returns)
amd_mdd <- maxDrawdown(amd_returns)

# Calculate cumulative returns
nvda_cumulative <- cumprod(1 + nvda_returns_vector) - 1
amd_cumulative <- cumprod(1 + amd_returns_vector) - 1
nvda_final_cumulative <- last(nvda_cumulative)
amd_final_cumulative <- last(amd_cumulative)

# Create a data frame with the calculated factors
factors <- data.frame(
  NVDA=c(nvda_sd, nvda_sharpe, nvda_beta, nvda_volume, nvda_mdd, nvda_final_cumulative),
  AMD=c(amd_sd, amd_sharpe, amd_beta, amd_volume, amd_mdd, amd_final_cumulative),
  row.names=c("Volatility", "Sharpe Ratio", "Beta", "Avg Volume", "Max Drawdown", "Cumulative Returns")
)

# Print the factors
print(factors)







