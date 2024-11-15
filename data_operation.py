import pandas as pd
from database import insert_data_to_sql

def preprocess_data(file_name, ticker):
    df = pd.read_csv(file_name)
    df['Date'] = pd.to_datetime(df['Date'])
    df['Month'] = df['Date'].dt.month
    df['Quarter'] = df['Date'].dt.quarter
    df.ffill(inplace=True)

    df['Adj_Close'] = df.get('Adj Close', df['Close'])

    expected_columns = ['Date', 'Open', 'High', 'Low', 'Close', 'Adj_Close', 'Volume', 'Month', 'Quarter']
    missing_columns = [col for col in expected_columns if col not in df.columns]

    if missing_columns:
        print(f"Warning: The following expected columns are missing in {ticker} data file: {missing_columns}")

    df['Company'] = ticker

    return df[[col for col in expected_columns if col in df.columns] + ['Company']]

def insert_csv_to_sql(file_name, table_name):
    df = preprocess_data(file_name, table_name)
    if not df.empty:
        insert_data_to_sql(df, table_name)
        print(f"Inserted data from {file_name} into table '{table_name}'.")
    else:
        print(f"No data to insert from {file_name}.")