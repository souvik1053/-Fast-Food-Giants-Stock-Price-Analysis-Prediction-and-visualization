import openai
import pandas as pd
from sqlalchemy import create_engine
from config import DB_URL, OPENAI_API_KEY

# Configure OpenAI API key
openai.api_key = OPENAI_API_KEY

# Database connection
def get_sql_engine():
    return create_engine(DB_URL)

# Function to fetch company summary and recent stock news using OpenAI API
def get_company_details(company_name):
    try:
        # Construct a prompt for OpenAI
        prompt = f"Provide a summary for {company_name} and recent news on its stock performance."
        response = openai.Completion.create(
            engine="text-davinci-003",
            prompt=prompt,
            max_tokens=150
        )
        company_summary = response.choices[0].text.strip()

        # Split summary and news if needed
        summary, *news = company_summary.split("\n", 1)
        news_text = news[0] if news else "No recent news available."

        return summary, news_text
    except Exception as e:
        print(f"Error fetching company details for {company_name}: {e}")
        return None, None

# Function to insert data into the company_details table
def insert_company_details(company_name, summary, news):
    engine = get_sql_engine()
    data = {
        'Company_Name': company_name,
        'Company_Summary': summary,
        'Recent_Stock_News': news
    }
    df = pd.DataFrame([data])
    try:
        with engine.connect() as conn:
            df.to_sql('company_details', con=conn, if_exists='append', index=False)
        print(f"Inserted details for {company_name}.")
    except Exception as e:
        print(f"Error inserting data into company_details: {e}")