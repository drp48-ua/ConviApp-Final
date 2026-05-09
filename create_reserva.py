import sqlite3

def create_table():
    conn = sqlite3.connect('ConviAppWeb/conviapp.db')
    cursor = conn.cursor()
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS Reserva (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        fecha_inicio TEXT,
        fecha_fin TEXT,
        estado TEXT,
        motivo TEXT,
        usuario_id INTEGER,
        zona_comun_id INTEGER
    );
    """)
    conn.commit()
    conn.close()
    print("Table Reserva created successfully")

if __name__ == '__main__':
    create_table()
