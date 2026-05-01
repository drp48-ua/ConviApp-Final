import sqlite3

conn = sqlite3.connect('C:\\Users\\danir\\.gemini\\antigravity\\scratch\\ConviApp-Final\\ConviAppWeb\\conviapp.db')
cursor = conn.cursor()

new_pisos = [
    ("Calle del Sol 45", "Madrid", "28010", 4, 2, 1200.00, "Amplio piso soleado cerca del centro.", 1),
    ("Gran Vía de les Corts 10", "Barcelona", "08007", 3, 1, 950.00, "Acogedor piso en zona céntrica, ideal para estudiantes.", 1),
    ("Avenida blasco Ibañez 22", "Valencia", "46022", 5, 2, 1350.00, "Gran piso en avenida universitaria, vistas excepcionales.", 1),
    ("Calle Betis 14", "Sevilla", "41010", 2, 1, 780.00, "Moderno y céntrico piso reformado con mucho encanto.", 0)
]

cursor.executemany("""
    INSERT INTO Piso (direccion, ciudad, codigo_postal, numero_habitaciones, numero_banos, precio_total, descripcion, disponible)
    VALUES (?, ?, ?, ?, ?, ?, ?, ?)
""", new_pisos)

conn.commit()
conn.close()
print("Pisos added!")
