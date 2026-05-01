using System;
using System.IO;

namespace ConviAppWeb.DataAccess
{
    public static class DbConfig
    {
        // Ruta al archivo SQLite en el mismo directorio que el ejecutable
        public static string ConnectionString {
            get {
                string dbName = "conviapp.db";
                string baseDir = AppDomain.CurrentDomain.BaseDirectory;
                string fullPath = Path.Combine(baseDir, dbName);

                // Si no existe en el directorio actual (ej. bin/), buscamos en el padre (root del proyecto)
                if (!File.Exists(fullPath))
                {
                    string parentDir = Path.GetDirectoryName(baseDir.TrimEnd(Path.DirectorySeparatorChar));
                    if (parentDir != null && File.Exists(Path.Combine(parentDir, dbName)))
                    {
                        fullPath = Path.Combine(parentDir, dbName);
                    }
                }

                return "Data Source=" + fullPath + ";Version=3;";
            }
        }
    }
}



