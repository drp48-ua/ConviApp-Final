using System;
using System.Data;
using System.Data.SQLite;
using System.Collections.Generic;
using ConviAppWeb.Models;

namespace ConviAppWeb.DataAccess
{
    public class CADGasto
    {
        private string constring { get { return DbConfig.ConnectionString; } }

        // CREATE — método desconectado
        public bool CrearGasto(ENGasto en)
        {
            bool creado = false;
            using (SQLiteConnection c = new SQLiteConnection(constring))
            {
                try
                {
                    c.Open();
                    string sql = "INSERT INTO Gasto (concepto, importe, fecha, pagado, descripcion, registrado_por_id, piso_id) " +
                                 "VALUES (@c, @i, @f, @pa, @d, @r, @pi)";
                    using (SQLiteCommand com = new SQLiteCommand(sql, c))
                    {
                        com.Parameters.AddWithValue("@c", en.Concepto ?? (object)DBNull.Value);
                        com.Parameters.AddWithValue("@i", en.Importe);
                        com.Parameters.AddWithValue("@f", en.Fecha.ToString("o"));
                        com.Parameters.AddWithValue("@pa", en.Pagado ? 1 : 0);
                        com.Parameters.AddWithValue("@d", en.Descripcion ?? (object)DBNull.Value);
                        com.Parameters.AddWithValue("@r", en.RegistradoPorId);
                        com.Parameters.AddWithValue("@pi", en.PisoId.HasValue ? (object)en.PisoId.Value : DBNull.Value);
                        creado = com.ExecuteNonQuery() > 0;
                    }
                }
                catch (Exception) { creado = false; }
            }
            return creado;
        }

        // READ ALL — método conectado
        public List<ENGasto> ListarTodos(int? pisoId = null)
        {
            var lista = new List<ENGasto>();
            SQLiteConnection c = new SQLiteConnection(constring);
            try
            {
                c.Open();
                var sql = pisoId.HasValue ? "SELECT * FROM Gasto WHERE piso_id=@p ORDER BY fecha DESC" : "SELECT * FROM Gasto ORDER BY fecha DESC";
                SQLiteCommand com = new SQLiteCommand(sql, c);
                if (pisoId.HasValue) com.Parameters.AddWithValue("@p", pisoId.Value);
                SQLiteDataReader dr = com.ExecuteReader();
                while (dr.Read()) lista.Add(MapRow(dr));
                dr.Close();
            }
            catch (Exception) { lista = new List<ENGasto>(); }
            finally { c.Close(); }
            return lista;
        }

        // DELETE — método desconectado
        public bool BorrarGasto(ENGasto en)
        {
            bool borrado = false;
            DataSet bdVirtual = new DataSet();
            SQLiteConnection c = new SQLiteConnection(constring);
            try
            {
                SQLiteDataAdapter da = new SQLiteDataAdapter("SELECT * FROM Gasto WHERE id=" + en.Id, c);
                da.Fill(bdVirtual, "gasto");
                DataTable t = bdVirtual.Tables["gasto"];
                DataRow[] filas = t.Select("id=" + en.Id);
                if (filas.Length > 0)
                { filas[0].Delete(); SQLiteCommandBuilder cb = new SQLiteCommandBuilder(da); da.Update(bdVirtual, "gasto"); borrado = true; }
            }
            catch (Exception) { borrado = false; }
            finally { c.Close(); }
            return borrado;
        }

        private ENGasto MapRow(SQLiteDataReader dr) { return new ENGasto
        {
            Id              = Convert.ToInt32(dr["id"]),
            Concepto        = dr["concepto"] != DBNull.Value ? dr["concepto"].ToString() : null,
            Importe         = dr["importe"] != DBNull.Value ? Convert.ToDecimal(dr["importe"]) : 0,
            Fecha           = dr["fecha"] != DBNull.Value ? Convert.ToDateTime(dr["fecha"]) : DateTime.Now,
            Pagado          = dr["pagado"] != DBNull.Value && Convert.ToInt32(dr["pagado"]) == 1,
            Descripcion     = dr["descripcion"] != DBNull.Value ? dr["descripcion"].ToString() : null,
            RegistradoPorId = dr["registrado_por_id"] != DBNull.Value ? Convert.ToInt32(dr["registrado_por_id"]) : 0,
            PisoId          = dr["piso_id"] != DBNull.Value ? (int?)Convert.ToInt32(dr["piso_id"]) : null,
        }; }
    }
}




