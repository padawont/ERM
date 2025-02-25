from fastapi import FastAPI
import psycopg2
from dotenv import load_dotenv
import os
DB_USER = os.getenv("POSTGRES_USER")
DB_PASS = os.getenv("POSTGRES_PASSWORD")
DB_NAME = os.getenv("POSTGRES_DB")
DB_PORT = os.getenv("PORT_DB")


def get_db_connection():
    conn = psycopg2.connect(
        database=DB_NAME,
        user=DB_USER,
        password=DB_PASS,
        port=DB_PORT
    )
    return conn


load_dotenv()
app = FastAPI()


@app.get("/")
def root():
    return {"message":"hello world"}



@app.get('/table_names')
def table_names():
    conn = get_db_connection()
    