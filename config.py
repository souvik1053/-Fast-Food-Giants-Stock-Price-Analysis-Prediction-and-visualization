import os
from dotenv import load_dotenv # type: ignore
# Load environment variables from .env file
load_dotenv()

# Database configuration
DB_URL = os.getenv('DB_URL')
CSV_DIRECTORY = os.getenv('CSV_DIRECTORY')
OPENAI_API_KEY= os.getenv('OPENAI_API_KEY')
TICKERS = ['BRK-A', 'DNUT', 'DPZ', 'LKNCY', 'MCD', 'PZZA', 'QSR', 'SBUX', 'WEN', 'YUM']