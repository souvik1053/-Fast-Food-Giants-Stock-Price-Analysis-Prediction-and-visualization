import os
from config import CSV_DIRECTORY, TICKERS
from data_operation import insert_csv_to_sql
from database import fetch_historical_data
from prediction import predict_future_price
from company_details import get_company_details, insert_company_details
def load_csv_data_to_sql(csv_directory, tickers):
    for ticker in tickers:
        file_name = os.path.join(csv_directory, f"{ticker}.csv")
        if os.path.exists(file_name):
            insert_csv_to_sql(file_name, ticker.lower())
        else:
            print(f"CSV file for {ticker} not found at {file_name}.")

def update_stock_data(tickers):
    for ticker in tickers:
        # Inserting historical data from CSV into the respective tables
        csv_file = os.path.join(CSV_DIRECTORY, f"{ticker}.csv")
        if os.path.exists(csv_file):
            insert_csv_to_sql(csv_file, ticker)

        historical_data = fetch_historical_data(ticker)

        if historical_data.empty:
            print(f"No historical data found for {ticker}. Skipping update.")
            continue

        last_date = historical_data['Date'].max()
        print(f"Last date for {ticker}: {last_date}")

        # Running prediction for the next 7 days
        prediction = predict_future_price(ticker, days=7)

        if not prediction.empty:
            print(f"Prediction for {ticker}:\n{prediction}")

def update_company_details(companies):
    for company in companies:
        summary, news = get_company_details(company)
        if summary and news:
            insert_company_details(company, summary, news)
        else:
            print(f"Failed to retrieve details for {company}.")
            


if __name__ == '__main__':
    # Loading CSV data into the database
    load_csv_data_to_sql(CSV_DIRECTORY, TICKERS)

    # Updating stock data and predicting future prices
    update_stock_data(TICKERS)
    update_company_details(TICKERS)