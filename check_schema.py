import sqlite3

def check_schema():
    conn = sqlite3.connect('ConviAppWeb/conviapp.db')
    cursor = conn.cursor()
    cursor.execute("SELECT name FROM sqlite_master WHERE type='table';")
    print(cursor.fetchall())
    
if __name__ == '__main__':
    check_schema()
