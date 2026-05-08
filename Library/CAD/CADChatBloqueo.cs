using System;
using System.Collections.Generic;
using System.Data.SQLite;

namespace ConviAppWeb.DataAccess
{
    public class CADChatBloqueo
    {
        private string constring { get { return DbConfig.ConnectionString; } }

        public bool Bloquear(int bloqueante, int bloqueado)
        {
            if (EstaBloqueado(bloqueante, bloqueado)) return true;
            using (var c = new SQLiteConnection(constring))
            {
                c.Open();
                using (var cmd = new SQLiteCommand("INSERT INTO ChatBloqueo (bloqueante_id, bloqueado_id) VALUES (@b, @d)", c))
                {
                    cmd.Parameters.AddWithValue("@b", bloqueante);
                    cmd.Parameters.AddWithValue("@d", bloqueado);
                    return cmd.ExecuteNonQuery() > 0;
                }
            }
        }

        public bool Desbloquear(int bloqueante, int bloqueado)
        {
            using (var c = new SQLiteConnection(constring))
            {
                c.Open();
                using (var cmd = new SQLiteCommand("DELETE FROM ChatBloqueo WHERE bloqueante_id=@b AND bloqueado_id=@d", c))
                {
                    cmd.Parameters.AddWithValue("@b", bloqueante);
                    cmd.Parameters.AddWithValue("@d", bloqueado);
                    return cmd.ExecuteNonQuery() > 0;
                }
            }
        }

        public bool EstaBloqueado(int bloqueante, int bloqueado)
        {
            using (var c = new SQLiteConnection(constring))
            {
                c.Open();
                using (var cmd = new SQLiteCommand("SELECT COUNT(*) FROM ChatBloqueo WHERE bloqueante_id=@b AND bloqueado_id=@d", c))
                {
                    cmd.Parameters.AddWithValue("@b", bloqueante);
                    cmd.Parameters.AddWithValue("@d", bloqueado);
                    return Convert.ToInt32(cmd.ExecuteScalar()) > 0;
                }
            }
        }
    }
}
