**Forecasting Financial Futures: Enhancing Stock Market Predictions with LSTM Neural Networks**
Project Overview

*This project explores the use of machine learning to predict stock prices, specifically focusing on the closing stock prices of Apple Inc. Utilizing a Long Short-Term Memory (LSTM) neural network, the project aims to forecast 60-day price movements based on historical data. The LSTM model is capable of uncovering complex patterns in time-series data and offers a forward-looking perspective on stock market trends.
Contents*

    Data Collection
    Data Preparation
    Feature Engineering
    Model Building
    Training
    Evaluation
    Prediction
    Conclusion

**1. Data Collection**

The dataset consists of Apple Inc. (AAPL) stock prices from January 1, 2012, to December 17, 2019. The data is obtained from Yahoo Finance using the yfinance library and contains stock market indicators, with the closing price being the primary focus.

python

# Import necessary libraries
import pandas_datareader as pdr
import yfinance as yf

# Download the stock data
df = yf.download('AAPL', start='2012-01-01', end='2019-12-17')

**2. Data Preparation**

The closing price data is extracted and split into training (80%) and testing sets. The data is then scaled to a range of 0 to 1 using MinMaxScaler to enhance the model's performance.

python

# Create a new dataframe with only the 'Close' column
data = df.filter(['Close'])

# Convert the dataframe to a numpy array and scale it
from sklearn.preprocessing import MinMaxScaler
scaler = MinMaxScaler(feature_range=(0, 1))
scaled_data = scaler.fit_transform(data.values)

**3. Feature Engineering**

Sequential datasets are prepared to train the LSTM model. Each feature set consists of stock prices from the previous 60 days, with the target being the price on the following day.

python

# Create the scaled training data set
train_data = scaled_data[0:train_data_len, :]

# Split the data into x_train and y_train datasets
x_train, y_train = [], []

for i in range(60, len(train_data)):
    x_train.append(train_data[i-60:i, 0])
    y_train.append(train_data[i, 0])

x_train = np.array(x_train)
y_train = np.array(y_train)

**4. Model Building**

The LSTM model is built using Keras, consisting of two LSTM layers and two Dropout layers to prevent overfitting. Dense layers finalize the model, which is compiled using the Adam optimizer and mean squared error as the loss function.

python

from keras.models import Sequential
from keras.layers import Dense, LSTM, Dropout

# Build the LSTM model
model = Sequential()
model.add(LSTM(50, return_sequences=True, input_shape=(x_train.shape[1], 1)))
model.add(Dropout(0.2))
model.add(LSTM(50, return_sequences=False))
model.add(Dropout(0.2))
model.add(Dense(25))
model.add(Dense(1))

# Compile the model
model.compile(optimizer='adam', loss='mean_squared_error')

**5. Training**

The model is trained over 100 epochs with a batch size of 32 on the training dataset, allowing it to learn the stock price trends.

python

# Train the model
model.fit(x_train, y_train, batch_size=32, epochs=100)

**6. Evaluation**

The model's performance is evaluated on the test data using the following metrics:

    Root Mean Squared Error (RMSE)
    Mean Absolute Error (MAE)
    Mean Absolute Percentage Error (MAPE)

python

from sklearn.metrics import mean_squared_error, mean_absolute_error

# Calculate and display RMSE, MAE, and MAPE
rmse = np.sqrt(mean_squared_error(y_test, predictions))
mae = mean_absolute_error(y_test, predictions)
mape = np.mean(np.abs((y_test - predictions) / y_test)) * 100

print(f'RMSE: {rmse}')
print(f'MAE: {mae}')
print(f'MAPE: {mape}%')

**7. Prediction**

The trained LSTM model predicts future stock prices for a two-month period starting from the last trading day of the dataset (assumed to be December 31, 2023). The rolling forecast mechanism ensures that the model updates with new predicted values iteratively.

Example Predictions:

bash

2024-01-02  | Day 1  | $138.76
2024-01-03  | Day 2  | $138.22
...
2024-02-26  | Day 40 | $109.57

**8. Conclusion**

The project successfully demonstrates the capability of LSTM models in financial forecasting by predicting Apple Inc.'s stock prices. Further improvements could involve integrating ensemble methods, enhancing interpretability, and continuously retraining the model with new data to ensure accuracy and relevance.
How to Use This Project

    Clone the Repository: Clone the GitHub repository to your local machine.
    Install Required Packages: Install all required Python packages using pip install -r requirements.txt.
    Run the Code: Execute the Jupyter Notebook to understand the entire workflow, from data preparation to prediction.
    Evaluate and Test: Modify parameters, try different stock symbols, and evaluate how the LSTM model performs with other datasets.

**Key Highlights**

    Advanced Time-Series Prediction: LSTM model used to predict stock prices for up to 60 days.
    Sequential Data Processing: Feature engineering with sliding windows of past data to forecast future prices.
    Model Training and Validation: Techniques for training and validating the LSTM model, with additional metrics like RMSE, MAE, and MAPE.
