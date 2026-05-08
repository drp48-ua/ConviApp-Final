using System;
using System.Data;
using System.Data.SQLite;
using System.Collections.Generic;
using ConviAppWeb.Models;

namespace ConviAppWeb.DataAccess
{
    public class CADPiso
    {
        private string constring { get { return DbConfig.ConnectionString; } }

        // CREATE — método desconectado
        public int CrearPiso(ENPiso en)
        {
            int creadoId = 0;
            DataSet bdVirtual = new DataSet();
            SQLiteConnection c = new SQLiteConnection(constring);
            try
            {
                SQLiteDataAdapter da = new SQLiteDataAdapter("SELECT * FROM Piso LIMIT 0", c);
                da.Fill(bdVirtual, "piso");
                DataTable t = bdVirtual.Tables["piso"];
                DataRow nueva = t.NewRow();
                nueva["direccion"]          = en.Direccion ?? (object)DBNull.Value;
                nueva["ciudad"]             = en.Ciudad ?? (object)DBNull.Value;
                nueva["codigo_postal"]      = en.CodigoPostal ?? (object)DBNull.Value;
                nueva["numero_habitaciones"]= en.NumeroHabitaciones;
                nueva["numero_banos"]       = en.NumeroBanos;
                nueva["precio_total"]       = en.PrecioTotal;
                nueva["descripcion"]        = en.Descripcion ?? (object)DBNull.Value;
                nueva["disponible"]         = en.Disponible ? 1 : 0;
                nueva["codigo_comunidad"]   = en.CodigoComunidad ?? (object)DBNull.Value;
                nueva["caracteristicas"]    = en.Caracteristicas ?? (object)DBNull.Value;
                nueva["propietario_id"]     = en.PropietarioId > 0 ? (object)en.PropietarioId : DBNull.Value;
                nueva["imagen_url"]         = en.ImagenUrl ?? (object)DBNull.Value;
                nueva["es_privado"]         = en.EsPrivado ? 1 : 0;
                nueva["nombre"]             = en.Nombre ?? (object)DBNull.Value;
                t.Rows.Add(nueva);
                SQLiteCommandBuilder cb = new SQLiteCommandBuilder(da);
                da.Update(bdVirtual, "piso");
                
                // Obtener el ID insertado
                using (SQLiteCommand cmd = new SQLiteCommand("SELECT MAX(id) FROM Piso", c))
                {
                    c.Open();
                    creadoId = Convert.ToInt32(cmd.ExecuteScalar());
                }
            }
            catch (Exception) { creadoId = 0; }
            finally { c.Close(); }
            return creadoId;
        }

        // READ por id — método conectado
        public ENPiso LeerPiso(int id)
        {
            ENPiso en = null;
            SQLiteConnection c = new SQLiteConnection(constring);
            try
            {
                c.Open();
                SQLiteCommand com = new SQLiteCommand("SELECT * FROM Piso WHERE id=@id", c);
                com.Parameters.AddWithValue("@id", id);
                SQLiteDataReader dr = com.ExecuteReader();
                if (dr.Read()) en = MapRow(dr);
                dr.Close();
            }
            catch (Exception) { en = null; }
            finally { c.Close(); }
            return en;
        }

        // READ ALL — método conectado
        public List<ENPiso> ListarTodos()
        {
            var lista = new List<ENPiso>();
            SQLiteConnection c = new SQLiteConnection(constring);
            try
            {
                c.Open();
                SQLiteCommand com = new SQLiteCommand("SELECT * FROM Piso ORDER BY id ASC", c);
                SQLiteDataReader dr = com.ExecuteReader();
                while (dr.Read()) lista.Add(MapRow(dr));
                dr.Close();
            }
            catch (Exception) { lista = new List<ENPiso>(); }
            finally { c.Close(); }
            return lista;
        }

        // COUNT — método conectado
        public int ObtenerTotal()
        {
            int total = 0;
            SQLiteConnection c = new SQLiteConnection(constring);
            try
            {
                c.Open();
                SQLiteCommand com = new SQLiteCommand("SELECT COUNT(*) FROM Piso", c);
                total = Convert.ToInt32(com.ExecuteScalar());
            }
            catch (Exception) { }
            finally { c.Close(); }
            return total;
        }

        private ENPiso MapRow(SQLiteDataReader dr) { return new ENPiso
        {
            Id                = Convert.ToInt32(dr["id"]),
            Direccion         = dr["direccion"] != DBNull.Value ? dr["direccion"].ToString() : null,
            Ciudad            = dr["ciudad"] != DBNull.Value ? dr["ciudad"].ToString() : null,
            CodigoPostal      = dr["codigo_postal"] != DBNull.Value ? dr["codigo_postal"].ToString() : null,
            NumeroHabitaciones= dr["numero_habitaciones"] != DBNull.Value ? Convert.ToInt32(dr["numero_habitaciones"]) : 0,
            NumeroBanos       = dr["numero_banos"] != DBNull.Value ? Convert.ToInt32(dr["numero_banos"]) : 0,
            PrecioTotal       = dr["precio_total"] != DBNull.Value ? Convert.ToDecimal(dr["precio_total"]) : 0,
            Descripcion       = dr["descripcion"] != DBNull.Value ? dr["descripcion"].ToString() : null,
            Disponible        = dr["disponible"] != DBNull.Value && Convert.ToInt32(dr["disponible"]) == 1,
            CodigoComunidad   = dr["codigo_comunidad"] != DBNull.Value ? dr["codigo_comunidad"].ToString() : null,
            Caracteristicas   = dr["caracteristicas"] != DBNull.Value ? dr["caracteristicas"].ToString() : null,
            PropietarioId     = dr["propietario_id"] != DBNull.Value ? Convert.ToInt32(dr["propietario_id"]) : 0,
            ImagenUrl         = dr["imagen_url"] != DBNull.Value ? dr["imagen_url"].ToString() : null,
            EsPrivado         = dr.GetSchemaTable().Select("ColumnName = 'es_privado'").Length > 0 && dr["es_privado"] != DBNull.Value && Convert.ToInt32(dr["es_privado"]) == 1,
            Nombre            = dr.GetSchemaTable().Select("ColumnName = 'nombre'").Length > 0 && dr["nombre"] != DBNull.Value ? dr["nombre"].ToString() : null
        }; }
        public bool BorrarPiso(int id)
        {
            bool exito = false;
            using (SQLiteConnection c = new SQLiteConnection(constring))
            {
                try
                {
                    c.Open();
                    using (SQLiteCommand com = new SQLiteCommand("DELETE FROM Piso WHERE id=@id", c))
                    {
                        com.Parameters.AddWithValue("@id", id);
                        exito = com.ExecuteNonQuery() > 0;
                    }
                }
                catch (Exception) { exito = false; }
            }
            return exito;
        }
    }
}




