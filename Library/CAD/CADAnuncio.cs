using System;
using System.Data.SQLite;
using System.Collections.Generic;
using ConviAppWeb.Models;

namespace ConviAppWeb.DataAccess
{
    public class CADAnuncio
    {
        private string constring { get { return DbConfig.ConnectionString; } }

        public CADAnuncio()
        {
            // Inicializar tabla y datos por defecto si no existen
            using (SQLiteConnection c = new SQLiteConnection(constring))
            {
                try
                {
                    c.Open();
                    string sql = @"
                        CREATE TABLE IF NOT EXISTS Anuncio (
                            id INTEGER PRIMARY KEY AUTOINCREMENT,
                            seccion TEXT UNIQUE,
                            titulo TEXT,
                            subtitulo TEXT,
                            imagen_url TEXT
                        );
                        INSERT OR IGNORE INTO Anuncio (seccion, titulo, subtitulo, imagen_url) VALUES ('Tareas', 'Limpieza a Domicilio', '-10% en tu primer servicio de limpieza.', 'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?w=400&h=300&fit=crop');
                        INSERT OR IGNORE INTO Anuncio (seccion, titulo, subtitulo, imagen_url) VALUES ('Gastos', 'Ahorra en Internet', 'Fibra + Móvil desde 19,90€/mes', 'https://images.unsplash.com/photo-1544197150-b99a580bb7a8?w=400&h=300&fit=crop');
                        INSERT OR IGNORE INTO Anuncio (seccion, titulo, subtitulo, imagen_url) VALUES ('Incidencias', 'Seguro de Hogar', 'Protege tu piso por menos de 5€/mes', 'https://images.unsplash.com/photo-1560518883-ce09059eeffa?w=400&h=300&fit=crop');
                        INSERT OR IGNORE INTO Anuncio (seccion, titulo, subtitulo, imagen_url) VALUES ('Mensajes', 'Pizza a domicilio', '2x1 en pizzas medianas hoy.', 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=400&h=300&fit=crop');
                        INSERT OR IGNORE INTO Anuncio (seccion, titulo, subtitulo, imagen_url) VALUES ('Reservas', 'Gimnasio cercano', 'Matrícula gratis este mes.', 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=400&h=300&fit=crop');
                    ";
                    using (SQLiteCommand com = new SQLiteCommand(sql, c))
                    {
                        com.ExecuteNonQuery();
                    }
                }
                catch (Exception) { }
            }
        }

        public List<ENAnuncio> ListarTodos()
        {
            var lista = new List<ENAnuncio>();
            using (SQLiteConnection c = new SQLiteConnection(constring))
            {
                try
                {
                    c.Open();
                    using (SQLiteCommand com = new SQLiteCommand("SELECT * FROM Anuncio ORDER BY id ASC", c))
                    {
                        SQLiteDataReader dr = com.ExecuteReader();
                        while (dr.Read())
                        {
                            lista.Add(new ENAnuncio {
                                Id = Convert.ToInt32(dr["id"]),
                                Seccion = dr["seccion"].ToString(),
                                Titulo = dr["titulo"].ToString(),
                                Subtitulo = dr["subtitulo"].ToString(),
                                ImagenUrl = dr["imagen_url"].ToString()
                            });
                        }
                    }
                }
                catch (Exception) { }
            }
            return lista;
        }

        public ENAnuncio LeerPorSeccion(string seccion)
        {
            ENAnuncio en = null;
            using (SQLiteConnection c = new SQLiteConnection(constring))
            {
                try
                {
                    c.Open();
                    using (SQLiteCommand com = new SQLiteCommand("SELECT * FROM Anuncio WHERE seccion = @s", c))
                    {
                        com.Parameters.AddWithValue("@s", seccion);
                        SQLiteDataReader dr = com.ExecuteReader();
                        if (dr.Read())
                        {
                            en = new ENAnuncio {
                                Id = Convert.ToInt32(dr["id"]),
                                Seccion = dr["seccion"].ToString(),
                                Titulo = dr["titulo"].ToString(),
                                Subtitulo = dr["subtitulo"].ToString(),
                                ImagenUrl = dr["imagen_url"].ToString()
                            };
                        }
                    }
                }
                catch (Exception) { }
            }
            return en;
        }

        public bool Actualizar(ENAnuncio en)
        {
            bool ok = false;
            using (SQLiteConnection c = new SQLiteConnection(constring))
            {
                try
                {
                    c.Open();
                    using (SQLiteCommand com = new SQLiteCommand("UPDATE Anuncio SET titulo=@t, subtitulo=@s, imagen_url=@i WHERE id=@id", c))
                    {
                        com.Parameters.AddWithValue("@t", en.Titulo);
                        com.Parameters.AddWithValue("@s", en.Subtitulo);
                        com.Parameters.AddWithValue("@i", en.ImagenUrl);
                        com.Parameters.AddWithValue("@id", en.Id);
                        ok = com.ExecuteNonQuery() > 0;
                    }
                }
                catch (Exception) { }
            }
            return ok;
        }
    }
}
