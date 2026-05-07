using System;
using System.Data;
using System.Data.SQLite;
using System.Collections.Generic;
using ConviAppWeb.Models;

namespace ConviAppWeb.DataAccess
{
    public class CADMensaje
    {
        private string constring { get { return DbConfig.ConnectionString; } }

        // CREATE — método desconectado
        public bool CrearMensaje(ENMensaje en)
        {
            bool creado = false;
            using (SQLiteConnection c = new SQLiteConnection(constring))
            {
                try
                {
                    c.Open();
                    string sql = "INSERT INTO Mensaje (contenido, fecha_envio, leido, emisor_id, receptor_id, piso_id) " +
                                 "VALUES (@c, @f, @l, @e, @r, @pi)";
                    using (SQLiteCommand com = new SQLiteCommand(sql, c))
                    {
                        com.Parameters.AddWithValue("@c", en.Contenido ?? (object)DBNull.Value);
                        com.Parameters.AddWithValue("@f", en.FechaEnvio.ToString("o"));
                        com.Parameters.AddWithValue("@l", en.Leido ? 1 : 0);
                        com.Parameters.AddWithValue("@e", en.EmisorId);
                        com.Parameters.AddWithValue("@r", en.ReceptorId.HasValue ? (object)en.ReceptorId.Value : DBNull.Value);
                        com.Parameters.AddWithValue("@pi", en.PisoId.HasValue ? (object)en.PisoId.Value : DBNull.Value);
                        creado = com.ExecuteNonQuery() > 0;
                    }
                }
                catch (Exception) { creado = false; }
            }
            return creado;
        }

        // READ ALL — método conectado
        public List<ENMensaje> ListarTodos(int? pisoId = null)
        {
            var lista = new List<ENMensaje>();
            SQLiteConnection c = new SQLiteConnection(constring);
            try
            {
                c.Open();
                var sql = pisoId.HasValue ? "SELECT * FROM Mensaje WHERE piso_id=@p ORDER BY fecha_envio ASC" : "SELECT * FROM Mensaje ORDER BY fecha_envio ASC";
                SQLiteCommand com = new SQLiteCommand(sql, c);
                if (pisoId.HasValue) com.Parameters.AddWithValue("@p", pisoId.Value);
                SQLiteDataReader dr = com.ExecuteReader();
                while (dr.Read()) lista.Add(MapRow(dr));
                dr.Close();
            }
            catch (Exception) { lista = new List<ENMensaje>(); }
            finally { c.Close(); }
            return lista;
        }

        private ENMensaje MapRow(SQLiteDataReader dr) { return new ENMensaje
        {
            Id         = Convert.ToInt32(dr["id"]),
            Contenido  = dr["contenido"] != DBNull.Value ? dr["contenido"].ToString() : null,
            FechaEnvio = dr["fecha_envio"] != DBNull.Value ? Convert.ToDateTime(dr["fecha_envio"]) : DateTime.Now,
            Leido      = dr["leido"] != DBNull.Value && Convert.ToInt32(dr["leido"]) == 1,
            EmisorId   = dr["emisor_id"] != DBNull.Value ? Convert.ToInt32(dr["emisor_id"]) : 0,
            PisoId     = dr["piso_id"] != DBNull.Value ? (int?)Convert.ToInt32(dr["piso_id"]) : null,
        }; }
    }
}




