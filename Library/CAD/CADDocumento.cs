using System;
using System.Data;
using System.Data.SQLite;
using System.Collections.Generic;
using ConviAppWeb.Models;

namespace ConviAppWeb.DataAccess
{
    public class CADDocumento
    {
        private string constring { get { return DbConfig.ConnectionString; } }

        // CREATE — método desconectado
        public bool CrearDocumento(ENDocumento en)
        {
            bool creado = false;
            using (SQLiteConnection c = new SQLiteConnection(constring))
            {
                c.Open();
                string sql = "INSERT INTO Documento (file_name, file_data, content_type, file_size, type, description, upload_date, property_id, user_id) " +
                             "VALUES (@fn, @fd, @ct, @fs, @ty, @de, @ud, @pi, @ui)";
                using (SQLiteCommand com = new SQLiteCommand(sql, c))
                {
                    com.Parameters.AddWithValue("@fn", en.FileName ?? (object)DBNull.Value);
                    com.Parameters.AddWithValue("@fd", en.FileData ?? (object)DBNull.Value);
                    com.Parameters.AddWithValue("@ct", en.ContentType ?? (object)DBNull.Value);
                    com.Parameters.AddWithValue("@fs", en.FileSize);
                    com.Parameters.AddWithValue("@ty", en.Type ?? "otro");
                    com.Parameters.AddWithValue("@de", en.Description ?? (object)DBNull.Value);
                    com.Parameters.AddWithValue("@ud", en.UploadDate.ToString("o"));
                    com.Parameters.AddWithValue("@pi", en.PropertyId.HasValue ? (object)en.PropertyId.Value : DBNull.Value);
                    com.Parameters.AddWithValue("@ui", en.UserId);
                    creado = com.ExecuteNonQuery() > 0;
                }
            }
            return creado;
        }

        // READ por id — método conectado
        public ENDocumento LeerDocumento(int id)
        {
            ENDocumento en = null;
            SQLiteConnection c = new SQLiteConnection(constring);
            try
            {
                c.Open();
                SQLiteCommand com = new SQLiteCommand("SELECT * FROM Documento WHERE id=@id", c);
                com.Parameters.AddWithValue("@id", id);
                SQLiteDataReader dr = com.ExecuteReader();
                if (dr.Read()) en = MapRow(dr);
                dr.Close();
            }
            catch (Exception) { en = null; }
            finally { c.Close(); }
            return en;
        }

        // READ ALL por usuario — método conectado
        public List<ENDocumento> ListarPorUsuario(int userId)
        {
            var lista = new List<ENDocumento>();
            SQLiteConnection c = new SQLiteConnection(constring);
            try
            {
                c.Open();
                SQLiteCommand com = new SQLiteCommand("SELECT id, file_name, content_type, file_size, type, description, upload_date, property_id, user_id FROM Documento WHERE user_id=@u ORDER BY upload_date DESC", c);
                com.Parameters.AddWithValue("@u", userId);
                SQLiteDataReader dr = com.ExecuteReader();
                while (dr.Read()) lista.Add(MapRow(dr, skipData: true));
                dr.Close();
            }
            catch (Exception) { lista = new List<ENDocumento>(); }
            finally { c.Close(); }
            return lista;
        }

        // READ ALL por comunidad (todos los inquilinos) — excluye contratos (privados)
        public List<ENDocumento> ListarPorComunidad(int pisoId)
        {
            var lista = new List<ENDocumento>();
            SQLiteConnection c = new SQLiteConnection(constring);
            try
            {
                c.Open();
                // Trae documentos de todos los usuarios que pertenecen a la comunidad, excluyendo tipo "contrato"
                SQLiteCommand com = new SQLiteCommand(
                    "SELECT d.id, d.file_name, d.content_type, d.file_size, d.type, d.description, d.upload_date, d.property_id, d.user_id " +
                    "FROM Documento d " +
                    "INNER JOIN ComunidadUsuario cu ON cu.usuario_id = d.user_id " +
                    "WHERE cu.piso_id = @p AND d.type != 'contrato' " +
                    "ORDER BY d.upload_date DESC", c);
                com.Parameters.AddWithValue("@p", pisoId);
                SQLiteDataReader dr = com.ExecuteReader();
                while (dr.Read()) lista.Add(MapRow(dr, skipData: true));
                dr.Close();
            }
            catch (Exception) { lista = new List<ENDocumento>(); }
            finally { c.Close(); }
            return lista;
        }

        // DELETE — método desconectado
        public bool BorrarDocumento(ENDocumento en)
        {
            bool borrado = false;
            DataSet bdVirtual = new DataSet();
            SQLiteConnection c = new SQLiteConnection(constring);
            try
            {
                SQLiteDataAdapter da = new SQLiteDataAdapter("SELECT * FROM Documento WHERE id=" + en.Id, c);
                da.Fill(bdVirtual, "documento");
                DataTable t = bdVirtual.Tables["documento"];
                DataRow[] filas = t.Select("id=" + en.Id);
                if (filas.Length > 0) { filas[0].Delete(); SQLiteCommandBuilder cb = new SQLiteCommandBuilder(da); da.Update(bdVirtual, "documento"); borrado = true; }
            }
            catch (Exception) { borrado = false; }
            finally { c.Close(); }
            return borrado;
        }

        private ENDocumento MapRow(SQLiteDataReader dr, bool skipData = false) { return new ENDocumento
        {
            Id          = Convert.ToInt32(dr["id"]),
            FileName    = dr["file_name"] != DBNull.Value ? dr["file_name"].ToString() : null,
            FileData    = skipData ? null : (dr["file_data"] != DBNull.Value ? (byte[])dr["file_data"] : null),
            ContentType = dr["content_type"] != DBNull.Value ? dr["content_type"].ToString() : null,
            FileSize    = dr["file_size"] != DBNull.Value ? Convert.ToInt64(dr["file_size"]) : 0,
            Type        = dr["type"] != DBNull.Value ? dr["type"].ToString() : null,
            Description = dr["description"] != DBNull.Value ? dr["description"].ToString() : null,
            UploadDate  = dr["upload_date"] != DBNull.Value ? Convert.ToDateTime(dr["upload_date"]) : DateTime.Now,
            PropertyId  = dr["property_id"] != DBNull.Value ? (int?)Convert.ToInt32(dr["property_id"]) : null,
            UserId      = dr["user_id"] != DBNull.Value ? Convert.ToInt32(dr["user_id"]) : 0,
        }; }
    }
}




