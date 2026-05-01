import sqlite3
import os

db_path = r"ConviAppWeb\conviapp.db"
if not os.path.exists(db_path):
    print(f"File {db_path} not found")
else:
    conn = sqlite3.connect(db_path)
    cursor = conn.cursor()
    try:
        cursor.execute("SELECT id, email, password_hash, rol FROM Usuario")
        rows = cursor.fetchall()
        print("ID | Email | PasswordHash | Rol")
        print("-" * 40)
        for row in rows:
            print(f"{row[0]} | {row[1]} | {row[2]} | {row[3]}")
    except Exception as e:
        print(f"Error: {e}")
    conn.close()
