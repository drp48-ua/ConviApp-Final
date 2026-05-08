using System;
using System.IO;
using System.Data.SQLite;

namespace ConviAppWeb.DataAccess
{
    public static class DbConfig
    {
        private static bool _walConfigured = false;
        private static readonly object _lock = new object();

        // Ruta al archivo SQLite en el mismo directorio que el ejecutable
        public static string ConnectionString {
            get {
                string cs = "Data Source=" + Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "conviapp.db") + ";Version=3;Default Timeout=5;";
                
                if (!_walConfigured)
                {
                    lock (_lock)
                    {
                        if (!_walConfigured)
                        {
                            _walConfigured = true;
                            try
                            {
                                using (var c = new SQLiteConnection(cs))
                                {
                                    c.Open();
                                    using (var cmd = new SQLiteCommand("PRAGMA journal_mode=WAL;", c))
                                    {
                                        cmd.ExecuteNonQuery();
                                    }
                                    
                                    // MIGRACIONES AUTOMÁTICAS
                                    using (var cmd = new SQLiteCommand("CREATE TABLE IF NOT EXISTS ComunidadUsuario (id INTEGER PRIMARY KEY AUTOINCREMENT, piso_id INTEGER NOT NULL, usuario_id INTEGER NOT NULL, fecha_union DATETIME DEFAULT CURRENT_TIMESTAMP);", c))
                                    {
                                        cmd.ExecuteNonQuery();
                                    }
                                    try { using (var cmd = new SQLiteCommand("ALTER TABLE Piso ADD COLUMN codigo_comunidad TEXT;", c)) { cmd.ExecuteNonQuery(); } } catch { }
                                    try { using (var cmd = new SQLiteCommand("ALTER TABLE Piso ADD COLUMN caracteristicas TEXT;", c)) { cmd.ExecuteNonQuery(); } } catch { }
                                    try { using (var cmd = new SQLiteCommand("ALTER TABLE Piso ADD COLUMN propietario_id INTEGER;", c)) { cmd.ExecuteNonQuery(); } } catch { }
                                    try { using (var cmd = new SQLiteCommand("ALTER TABLE Piso ADD COLUMN imagen_url TEXT;", c)) { cmd.ExecuteNonQuery(); } } catch { }
                                    try { using (var cmd = new SQLiteCommand("ALTER TABLE Usuario ADD COLUMN rol TEXT;", c)) { cmd.ExecuteNonQuery(); } } catch { }
                                }
                            }
                            catch { }
                        }
                    }
                }
                return cs;
            }
        }
    }
}



