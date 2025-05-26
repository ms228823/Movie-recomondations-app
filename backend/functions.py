import sqlite3
import mysql.connector
# from cs50 import SQL
from flask import request,session

def sqlite_execute_query(database,query, data=None, fetch=False, return_id=None, is_dict=False):
    # Create a connection to the database
    # with sqlite3.connect('optica.db') as conn:
    with sqlite3.connect(database) as conn:

        # Set row factory for dictionary-like access to rows, if needed
        if is_dict:
            conn.row_factory = sqlite3.Row

        # Create a cursor object from the connection
        cur = conn.cursor()
        
        # Execute query with or without data
        if data is None:
            cur.execute(query)
        elif isinstance(data, (tuple, list)):
            cur.execute(query, data)  # `data` is already a tuple or list
        else:
            cur.execute(query, (data,))  # Single value, wrap in a tuple
        
        # Commit changes if it's an INSERT, UPDATE, or DELETE operation
        if not fetch:
            conn.commit()

        # For SELECT queries, fetch results if `fetch` is True
        if fetch:
            rows = cur.fetchall()
            if is_dict:
                return [dict(row) for row in rows]  # Convert Row objects to dictionaries
            return rows if rows else []

        # For INSERT queries, return the last inserted row ID if `return_id` is True
        if return_id:
            return cur.lastrowid
        
        # For UPDATE and DELETE, or queries that don’t need to return data
        return None
    
    
# db_config = {
#     'host': 'localhost',
#     'user': 'root',
#     'password': 'your_password',
#     'database': 'your_database'
# }


def mysql_execute_query(db_config, query, data=None, fetch=False, return_id=None, is_dict=False):
    """
    Execute a query on a MySQL database with connection parameters passed in db_config.

    :param db_config: A dictionary containing 'host', 'user', 'password', 'database'.
    :param query: SQL query to execute.
    :param data: Data to pass to the query (default: None).
    :param fetch: Whether to fetch results (default: False).
    :param return_id: Whether to return the last inserted ID for insert operations (default: None).
    :param is_dict: Whether to return rows as dictionaries (default: False).
    :return: Query result (rows or last inserted ID).
    """
    # Create a connection to the MySQL database using the provided db_config
    with mysql.connector.connect(
        host=db_config['host'],
        user=db_config['user'],
        # password=db_config['password'],
        database=db_config['database']
    ) as conn:

        # Create a cursor object from the connection, with dictionary support if needed
        cur = conn.cursor(dictionary=is_dict)
        
        # Execute query with or without data
        if data is None:
            cur.execute(query)
        elif isinstance(data, (tuple, list)):
            cur.execute(query, data)
        else:
            cur.execute(query, (data,))  # Single value, wrap in a tuple
        
        # Commit changes if it's an INSERT, UPDATE, or DELETE operation
        if not fetch:
            conn.commit()

        # For SELECT queries, fetch results if `fetch` is True
        if fetch:
            rows = cur.fetchall()
            return rows if rows else []

        # For INSERT queries, return the last inserted row ID if `return_id` is True
        if return_id:
            return cur.lastrowid
        
        # For UPDATE and DELETE, or queries that don’t need to return data
        return None

    
def split_by_type(data):
    movies = []
    series = []
    for show_id, media_type in data:
        if media_type == 1:
            movies.append(show_id)
        elif media_type == 2:
            series.append(show_id)
    return movies, series