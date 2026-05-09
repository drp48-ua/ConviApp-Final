using System;
using System.Data;
using System.Data.SQLite;
using System.Collections.Generic;
using ConviAppWeb.Models;

namespace ConviAppWeb.DataAccess
{
    public class CADComunidadUsuario
    {
        private string constring { get { return DbConfig.ConnectionString; } }

        public bool UnirUsuarioAComunidad(int pisoId, int usuarioId)
        {
            bool exito = false;
            using (SQLiteConnection c = new SQLiteConnection(constring))
            {
                try
                {
                    c.Open();
                    // Verificar si ya existe
                    using (SQLiteCommand check = new SQLiteCommand("SELECT COUNT(*) FROM ComunidadUsuario WHERE piso_id=@p AND usuario_id=@u", c))
                    {
                        check.Parameters.AddWithValue("@p", pisoId);
                        check.Parameters.AddWithValue("@u", usuarioId);
                        if (Convert.ToInt32(check.ExecuteScalar()) > 0)
                        {
                            return true; // Ya está unido
                        }
                    }

                    using (SQLiteCommand com = new SQLiteCommand("INSERT INTO ComunidadUsuario (piso_id, usuario_id) VALUES (@p, @u)", c))
                    {
                        com.Parameters.AddWithValue("@p", pisoId);
                        com.Parameters.AddWithValue("@u", usuarioId);
                        exito = com.ExecuteNonQuery() > 0;
                    }
                }
                catch (Exception) { exito = false; }
            }
            return exito;
        }

        public bool ExpulsarUsuario(int pisoId, int usuarioId)
        {
            bool exito = false;
            using (SQLiteConnection c = new SQLiteConnection(constring))
            {
                try
                {
                    c.Open();
                    using (SQLiteCommand com = new SQLiteCommand("DELETE FROM ComunidadUsuario WHERE piso_id=@p AND usuario_id=@u", c))
                    {
                        com.Parameters.AddWithValue("@p", pisoId);
                        com.Parameters.AddWithValue("@u", usuarioId);
                        exito = com.ExecuteNonQuery() > 0;
                    }
                }
                catch (Exception) { exito = false; }
            }
            return exito;
        }

        public List<ENUsuario> ObtenerUsuariosDeComunidad(int pisoId)
        {
            var lista = new List<ENUsuario>();
            using (SQLiteConnection c = new SQLiteConnection(constring))
            {
                try
                {
                    c.Open();
                    using (SQLiteCommand com = new SQLiteCommand("SELECT u.* FROM Usuario u INNER JOIN ComunidadUsuario cu ON u.id = cu.usuario_id WHERE cu.piso_id = @p", c))
                    {
                        com.Parameters.AddWithValue("@p", pisoId);
                        using (SQLiteDataReader dr = com.ExecuteReader())
                        {
                            while (dr.Read())
                            {
                                var en = new ENUsuario();
                                en.Id = Convert.ToInt32(dr["id"]);
                                en.Nombre = dr["nombre"] != DBNull.Value ? dr["nombre"].ToString() : null;
                                en.Apellidos = dr["apellidos"] != DBNull.Value ? dr["apellidos"].ToString() : null;
                                en.Email = dr["email"].ToString();
                                en.Telefono = dr["telefono"] != DBNull.Value ? dr["telefono"].ToString() : null;
                                lista.Add(en);
                            }
                        }
                    }
                }
                catch (Exception) { }
            }
            return lista;
        }

        public List<ENPiso> ObtenerComunidadesDeUsuario(int usuarioId)
        {
            var lista = new List<ENPiso>();
            using (SQLiteConnection c = new SQLiteConnection(constring))
            {
                try
                {
                    c.Open();
                    using (SQLiteCommand com = new SQLiteCommand("SELECT p.* FROM Piso p INNER JOIN ComunidadUsuario cu ON p.id = cu.piso_id WHERE cu.usuario_id = @u", c))
                    {
                        com.Parameters.AddWithValue("@u", usuarioId);
                        using (SQLiteDataReader dr = com.ExecuteReader())
                        {
                            while (dr.Read())
                            {
                                var en = new ENPiso();
                                en.Id = Convert.ToInt32(dr["id"]);
                                en.Direccion = dr["direccion"] != DBNull.Value ? dr["direccion"].ToString() : null;
                                en.Ciudad = dr["ciudad"] != DBNull.Value ? dr["ciudad"].ToString() : null;
                                en.CodigoComunidad = dr["codigo_comunidad"] != DBNull.Value ? dr["codigo_comunidad"].ToString() : null;
                                en.Descripcion = dr["descripcion"] != DBNull.Value ? dr["descripcion"].ToString() : null;
                                en.PrecioTotal = dr["precio_total"] != DBNull.Value ? Convert.ToDecimal(dr["precio_total"]) : 0;
                                en.Nombre = dr["nombre"] != DBNull.Value ? dr["nombre"].ToString() : null;
                                en.PropietarioId = dr["propietario_id"] != DBNull.Value ? Convert.ToInt32(dr["propietario_id"]) : 0;
                                en.EsPrivado = dr.GetSchemaTable().Select("ColumnName = 'es_privado'").Length > 0 && dr["es_privado"] != DBNull.Value && Convert.ToInt32(dr["es_privado"]) == 1;
                                en.NumeroHabitaciones = dr.GetSchemaTable().Select("ColumnName = 'numero_habitaciones'").Length > 0 && dr["numero_habitaciones"] != DBNull.Value ? Convert.ToInt32(dr["numero_habitaciones"]) : 0;
                                lista.Add(en);
                            }
                        }
                    }
                }
                catch (Exception) { }
            }
            return lista;
        }
        
        public ENPiso BuscarComunidadPorCodigo(string codigo)
        {
            ENPiso en = null;
            using (SQLiteConnection c = new SQLiteConnection(constring))
            {
                try
                {
                    c.Open();
                    using (SQLiteCommand com = new SQLiteCommand("SELECT * FROM Piso WHERE codigo_comunidad = @c", c))
                    {
                        com.Parameters.AddWithValue("@c", codigo);
                        using (SQLiteDataReader dr = com.ExecuteReader())
                        {
                            if (dr.Read())
                            {
                                en = new ENPiso();
                                en.Id = Convert.ToInt32(dr["id"]);
                                en.Direccion = dr["direccion"] != DBNull.Value ? dr["direccion"].ToString() : null;
                                en.Ciudad = dr["ciudad"] != DBNull.Value ? dr["ciudad"].ToString() : null;
                                en.CodigoComunidad = dr["codigo_comunidad"] != DBNull.Value ? dr["codigo_comunidad"].ToString() : null;
                                en.Descripcion = dr["descripcion"] != DBNull.Value ? dr["descripcion"].ToString() : null;
                                en.PrecioTotal = dr.GetSchemaTable().Select("ColumnName = 'precio_total'").Length > 0 && dr["precio_total"] != DBNull.Value ? Convert.ToDecimal(dr["precio_total"]) : 0;
                                en.Nombre = dr.GetSchemaTable().Select("ColumnName = 'nombre'").Length > 0 && dr["nombre"] != DBNull.Value ? dr["nombre"].ToString() : null;
                                en.PropietarioId = dr.GetSchemaTable().Select("ColumnName = 'propietario_id'").Length > 0 && dr["propietario_id"] != DBNull.Value ? Convert.ToInt32(dr["propietario_id"]) : 0;
                                en.EsPrivado = dr.GetSchemaTable().Select("ColumnName = 'es_privado'").Length > 0 && dr["es_privado"] != DBNull.Value && Convert.ToInt32(dr["es_privado"]) == 1;
                                en.NumeroHabitaciones = dr.GetSchemaTable().Select("ColumnName = 'numero_habitaciones'").Length > 0 && dr["numero_habitaciones"] != DBNull.Value ? Convert.ToInt32(dr["numero_habitaciones"]) : 0;
                            }
                        }
                    }
                }
                catch (Exception) { }
            }
            return en;
        }
    }
}
