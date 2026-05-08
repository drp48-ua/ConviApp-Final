using System;
using System.Data.SQLite;

namespace ConviAppWeb.DataAccess
{
    public class CADChatSilenciado
    {
        private string constring { get { return DbConfig.ConnectionString; } }

        public bool Silenciar(int silenciante, int silenciado)
        {
            if (EstaSilenciado(silenciante, silenciado)) return true;
            using (var c = new SQLiteConnection(constring))
            {
                c.Open();
                using (var cmd = new SQLiteCommand("INSERT INTO ChatSilenciado (silenciante_id, silenciado_id) VALUES (@s, @d)", c))
                {
                    cmd.Parameters.AddWithValue("@s", silenciante);
                    cmd.Parameters.AddWithValue("@d", silenciado);
                    return cmd.ExecuteNonQuery() > 0;
                }
            }
        }

        public bool Dessilenciar(int silenciante, int silenciado)
        {
            using (var c = new SQLiteConnection(constring))
            {
                c.Open();
                using (var cmd = new SQLiteCommand("DELETE FROM ChatSilenciado WHERE silenciante_id=@s AND silenciado_id=@d", c))
                {
                    cmd.Parameters.AddWithValue("@s", silenciante);
                    cmd.Parameters.AddWithValue("@d", silenciado);
                    return cmd.ExecuteNonQuery() > 0;
                }
            }
        }

        public bool EstaSilenciado(int silenciante, int silenciado)
        {
            using (var c = new SQLiteConnection(constring))
            {
                c.Open();
                using (var cmd = new SQLiteCommand("SELECT COUNT(*) FROM ChatSilenciado WHERE silenciante_id=@s AND silenciado_id=@d", c))
                {
                    cmd.Parameters.AddWithValue("@s", silenciante);
                    cmd.Parameters.AddWithValue("@d", silenciado);
                    return Convert.ToInt32(cmd.ExecuteScalar()) > 0;
                }
            }
        }
    }
}
