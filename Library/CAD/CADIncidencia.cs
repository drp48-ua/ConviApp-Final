using System;
using System.Data;
using System.Data.SQLite;
using System.Collections.Generic;
using ConviAppWeb.Models;

namespace ConviAppWeb.DataAccess
{
    public class CADIncidencia
    {
        private string constring { get { return DbConfig.ConnectionString; } }

        // CREATE — método desconectado
        public bool CrearIncidencia(ENIncidencia en)
        {
            bool creado = false;
            using (SQLiteConnection c = new SQLiteConnection(constring))
            {
                c.Open();
                string sql = "INSERT INTO Incidencia (titulo, descripcion, estado, prioridad, fecha_reporte, reportada_por_id, piso_id) " +
                             "VALUES (@t, @d, @e, @p, @f, @r, @pi)";
                using (SQLiteCommand com = new SQLiteCommand(sql, c))
                {
                    com.Parameters.AddWithValue("@t", en.Titulo ?? (object)DBNull.Value);
                    com.Parameters.AddWithValue("@d", en.Descripcion ?? (object)DBNull.Value);
                    com.Parameters.AddWithValue("@e", en.Estado ?? "abierta");
                    com.Parameters.AddWithValue("@p", en.Prioridad ?? "media");
                    com.Parameters.AddWithValue("@f", en.FechaReporte.ToString("o"));
                    com.Parameters.AddWithValue("@r", en.ReportadaPorId);
                    com.Parameters.AddWithValue("@pi", en.PisoId.HasValue ? (object)en.PisoId.Value : DBNull.Value);
                    creado = com.ExecuteNonQuery() > 0;
                }
            }
            return creado;
        }

        // READ ALL — método conectado
        public List<ENIncidencia> ListarTodas(int? pisoId = null)
        {
            var lista = new List<ENIncidencia>();
            try
            {
                using (SQLiteConnection c = new SQLiteConnection(constring))
                {
                    c.Open();
                    var sql = pisoId.HasValue ? "SELECT * FROM Incidencia WHERE piso_id=@p ORDER BY fecha_reporte DESC" : "SELECT * FROM Incidencia ORDER BY fecha_reporte DESC";
                    using (SQLiteCommand com = new SQLiteCommand(sql, c))
                    {
                        if (pisoId.HasValue) com.Parameters.AddWithValue("@p", pisoId.Value);
                        using (SQLiteDataReader dr = com.ExecuteReader())
                        {
                            while (dr.Read()) lista.Add(MapRow(dr));
                        }
                    }
                }
            }
            catch (Exception) { lista = new List<ENIncidencia>(); }
            return lista;
        }

        // UPDATE estado — método conectado
        public bool ActualizarEstado(int id, string estado)
        {
            bool ok = false;
            try
            {
                using (SQLiteConnection c = new SQLiteConnection(constring))
                {
                    c.Open();
                    using (SQLiteCommand com = new SQLiteCommand("UPDATE Incidencia SET estado=@e WHERE id=@id", c))
                    {
                        com.Parameters.AddWithValue("@e", estado);
                        com.Parameters.AddWithValue("@id", id);
                        ok = com.ExecuteNonQuery() > 0;
                    }
                }
            }
            catch (Exception) { ok = false; }
            return ok;
        }

        // DELETE — elimina físicamente la incidencia
        public bool EliminarIncidencia(int id)
        {
            bool ok = false;
            using (SQLiteConnection c = new SQLiteConnection(constring))
            {
                c.Open();
                using (SQLiteCommand com = new SQLiteCommand("DELETE FROM Incidencia WHERE id=@id", c))
                {
                    com.Parameters.AddWithValue("@id", id);
                    ok = com.ExecuteNonQuery() > 0;
                }
            }
            return ok;
        }

        // COUNT abiertas — método conectado
        public int ObtenerTotalAbiertas()
        {
            int total = 0;
            try
            {
                using (SQLiteConnection c = new SQLiteConnection(constring))
                {
                    c.Open();
                    using (SQLiteCommand com = new SQLiteCommand("SELECT COUNT(*) FROM Incidencia WHERE estado='abierta'", c))
                    {
                        total = Convert.ToInt32(com.ExecuteScalar());
                    }
                }
            }
            catch (Exception) { }
            return total;
        }

        private ENIncidencia MapRow(SQLiteDataReader dr) { return new ENIncidencia
        {
            Id             = Convert.ToInt32(dr["id"]),
            Titulo         = dr["titulo"] != DBNull.Value ? dr["titulo"].ToString() : null,
            Descripcion    = dr["descripcion"] != DBNull.Value ? dr["descripcion"].ToString() : null,
            Estado         = dr["estado"] != DBNull.Value ? dr["estado"].ToString() : "abierta",
            Prioridad      = dr["prioridad"] != DBNull.Value ? dr["prioridad"].ToString() : "media",
            FechaReporte   = dr["fecha_reporte"] != DBNull.Value ? Convert.ToDateTime(dr["fecha_reporte"]) : DateTime.Now,
            ReportadaPorId = dr["reportada_por_id"] != DBNull.Value ? Convert.ToInt32(dr["reportada_por_id"]) : 0,
            PisoId         = dr["piso_id"] != DBNull.Value ? (int?)Convert.ToInt32(dr["piso_id"]) : null,
        }; }
    }
}




