from sqlalchemy import create_engine
import pandas as pd
from config import DB_URL

def get_sql_engine():
    """Returns a SQLAlchemy engine to connect to the database."""
    return create_engine(DB_URL)

def insert_data_to_sql(df, table_name):
    """Inserts data from a DataFrame into the specified SQL table."""
    engine = get_sql_engine()
    table_name = table_name.lower()

    # Handling NaN values by replacing them with 0
    if df.isnull().values.any():
        print(f"Warning: NaN values detected in DataFrame for table '{table_name}'. Filling NaNs with 0.")
        df.fillna(0, inplace=True)

    # Check if 'Close' column exists and is a valid Series
    if 'Close' in df.columns:
        if isinstance(df['Close'], pd.Series):
            # Convert 'Close' column to numeric, coercing errors into NaN
            df['Close'] = pd.to_numeric(df['Close'], errors='coerce')
            # Apply formatting to 'Close' and set NaN values as '0.00'
            df['Close'] = df['Close'].apply(lambda x: f"{x:.2f}" if pd.notnull(x) else "0.00")
        else:
            print(f"Warning: 'Close' column in DataFrame for table '{table_name}' is not a valid Series.")
    else:
        print(f"Warning: 'Close' column not found in DataFrame for table '{table_name}'.")

    # Clean column names to ensure no unwanted characters
    df.columns = [col if isinstance(col, str) else str(col[0]) for col in df.columns]
    df.columns = [col.strip() for col in df.columns]  # Strip any extra spaces if present

    # Insert data into the SQL table
    try:
        with engine.connect() as conn:
            df.to_sql(table_name, con=conn, if_exists='append', index=False)
        print(f"Data inserted successfully into table '{table_name}'.")
    except Exception as e:
        print(f"Error inserting data into table '{table_name}': {e}")

def fetch_historical_data(ticker):
    """Fetches historical stock data (Date, Close, Volume) from the database."""
    engine = get_sql_engine()
    query = f"SELECT Date, Close, Volume FROM `{ticker.lower()}` ORDER BY Date"

    try:
        historical_data = pd.read_sql(query, engine)

        if historical_data.empty:
            print(f"No historical data found for {ticker}.")
            return pd.DataFrame()

        # Ensure the 'Date' column is parsed correctly and drop any invalid rows
        historical_data['Date'] = pd.to_datetime(historical_data['Date'], errors='coerce')
        historical_data.dropna(subset=['Date'], inplace=True)
        return historical_data
    except Exception as e:
        print(f"Error fetching historical data for {ticker}: {e}")
        return pd.DataFrame()
