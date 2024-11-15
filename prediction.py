import numpy as np
import pandas as pd
from prophet import Prophet
from database import fetch_historical_data, insert_data_to_sql

# Helper function to get the next 7 weekdays / trading days
def get_next_weekdays(start_date, num_days=7):
    """
    Generate the next num_days weekdays (trading days) starting from the given start_date.
    """
    weekdays = pd.date_range(start=start_date, periods=num_days, freq='B').to_list()  # 'B' represents business days

    return weekdays

def predict_future_price(ticker, days=7):  
    historical_data = fetch_historical_data(ticker)

    if len(historical_data) < 50:
        print(f"Not enough data to predict for {ticker}")
        return pd.DataFrame()

    historical_data.rename(columns={"Date": "ds", "Close": "y"}, inplace=True)

    # Creating moving average and lagged feature
    historical_data['y_moving_avg'] = historical_data['y'].rolling(window=5).mean().shift(1)
    historical_data['y_lag1'] = historical_data['y'].shift(1)
    historical_data.dropna(inplace=True)

    model = Prophet(changepoint_prior_scale=0.1, seasonality_prior_scale=10)
    model.add_regressor('Volume')
    model.add_regressor('y_moving_avg')
    model.add_regressor('y_lag1')

    model.fit(historical_data)

    # Generating future dates for prediction
    last_date = historical_data['ds'].max()
    future_dates = get_next_weekdays(last_date + pd.Timedelta(days=1), days)

    future_df = pd.DataFrame({'ds': future_dates})

    # Setting regressor values using the most recent values from historical data
    future_df['y_lag1'] = historical_data['y'].iloc[-1]
    future_df['y_moving_avg'] = historical_data['y_moving_avg'].iloc[-1]
    future_df['Volume'] = historical_data['Volume'].iloc[-1]

    # Predicting the future prices using the model
    forecast = model.predict(future_df)

    forecast.rename(columns={
        'yhat': 'Predicted_Price',
        'yhat_lower': 'Lower_Confidence_Interval',
        'yhat_upper': 'Upper_Confidence_Interval'
    }, inplace=True)

    # Selecting only the relevant columns for insertion
    forecast = forecast[['ds', 'Predicted_Price', 'Lower_Confidence_Interval', 'Upper_Confidence_Interval']]
    forecast['Company'] = ticker

    try:
        insert_data_to_sql(forecast, 'stock_predictions')
        print(f"Prediction data for {ticker} has been saved to the database.")
    except Exception as e:
        print(f"Error saving prediction data for {ticker}: {e}")

    return forecast