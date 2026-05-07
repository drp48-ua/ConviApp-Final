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



