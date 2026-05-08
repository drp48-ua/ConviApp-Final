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
            ReceptorId = dr["receptor_id"] != DBNull.Value ? (int?)Convert.ToInt32(dr["receptor_id"]) : null,
            PisoId     = dr["piso_id"] != DBNull.Value ? (int?)Convert.ToInt32(dr["piso_id"]) : null,
        }; }

        // Mensajes entre dos usuarios específicos (chat 1:1)
        public List<ENMensaje> ListarConversacion(int userId1, int userId2)
        {
            var lista = new List<ENMensaje>();
            using (var c = new SQLiteConnection(constring))
            {
                c.Open();
                string sql = "SELECT * FROM Mensaje WHERE (emisor_id=@a AND receptor_id=@b) OR (emisor_id=@b AND receptor_id=@a) ORDER BY fecha_envio ASC";
                using (var com = new SQLiteCommand(sql, c))
                {
                    com.Parameters.AddWithValue("@a", userId1);
                    com.Parameters.AddWithValue("@b", userId2);
                    using (var dr = com.ExecuteReader()) { while (dr.Read()) lista.Add(MapRow(dr)); }
                }
            }
            return lista;
        }

        // Marcar como leídos todos los mensajes de un emisor hacia el usuario actual
        public void MarcarLeidos(int emisorId, int receptorId)
        {
            using (var c = new SQLiteConnection(constring))
            {
                c.Open();
                using (var cmd = new SQLiteCommand("UPDATE Mensaje SET leido=1 WHERE emisor_id=@e AND receptor_id=@r AND leido=0", c))
                {
                    cmd.Parameters.AddWithValue("@e", emisorId);
                    cmd.Parameters.AddWithValue("@r", receptorId);
                    cmd.ExecuteNonQuery();
                }
            }
        }

        // Listar todos los interlocutores distintos con los que el usuario ha hablado
        public List<int> ListarInterlocutores(int userId)
        {
            var ids = new List<int>();
            using (var c = new SQLiteConnection(constring))
            {
                c.Open();
                string sql = "SELECT DISTINCT CASE WHEN emisor_id=@u THEN receptor_id ELSE emisor_id END AS otro " +
                             "FROM Mensaje WHERE (emisor_id=@u OR receptor_id=@u) AND receptor_id IS NOT NULL ORDER BY fecha_envio DESC";
                using (var cmd = new SQLiteCommand(sql, c))
                {
                    cmd.Parameters.AddWithValue("@u", userId);
                    using (var dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            int otro = Convert.ToInt32(dr["otro"]);
                            if (!ids.Contains(otro)) ids.Add(otro);
                        }
                    }
                }
            }
            return ids;
        }

        // Último mensaje en una conversación
        public ENMensaje UltimoMensaje(int userId1, int userId2)
        {
            ENMensaje en = null;
            using (var c = new SQLiteConnection(constring))
            {
                c.Open();
                string sql = "SELECT * FROM Mensaje WHERE (emisor_id=@a AND receptor_id=@b) OR (emisor_id=@b AND receptor_id=@a) ORDER BY fecha_envio DESC LIMIT 1";
                using (var cmd = new SQLiteCommand(sql, c))
                {
                    cmd.Parameters.AddWithValue("@a", userId1);
                    cmd.Parameters.AddWithValue("@b", userId2);
                    using (var dr = cmd.ExecuteReader()) { if (dr.Read()) en = MapRow(dr); }
                }
            }
            return en;
        }

        // Eliminar conversación entre dos usuarios
        public void EliminarConversacion(int userId1, int userId2)
        {
            using (var c = new SQLiteConnection(constring))
            {
                c.Open();
                using (var cmd = new SQLiteCommand("DELETE FROM Mensaje WHERE (emisor_id=@a AND receptor_id=@b) OR (emisor_id=@b AND receptor_id=@a)", c))
                {
                    cmd.Parameters.AddWithValue("@a", userId1);
                    cmd.Parameters.AddWithValue("@b", userId2);
                    cmd.ExecuteNonQuery();
                }
            }
        }

        // Mensajes no leídos que el usuario tiene pendientes
        public int ContarNoLeidos(int userId)
        {
            using (var c = new SQLiteConnection(constring))
            {
                c.Open();
                using (var cmd = new SQLiteCommand("SELECT COUNT(*) FROM Mensaje WHERE receptor_id=@u AND leido=0", c))
                {
                    cmd.Parameters.AddWithValue("@u", userId);
                    return Convert.ToInt32(cmd.ExecuteScalar());
                }
            }
        }
    }
}




