using System;
using System.ComponentModel.DataAnnotations;

namespace ConviAppWeb.Models
{
    /// <summary>
    /// ENFavorito â€” Entidad de Negocio para habitaciones o pisos guardados como favoritos.
    /// Permite al usuario acceder rÃ¡pidamente a los alojamientos de su interÃ©s (Marina).
    /// </summary>
    public class ENFavorito
    {
        // â”€â”€â”€ Atributos privados â”€â”€â”€
        private int _id;
        private DateTime _fechaGuardado;
        private int _usuarioId;
        private int? _habitacionId;
        private int? _pisoId;

        // â”€â”€â”€ Propiedades pÃºblicas â”€â”€â”€
        [Key]
        public int Id { get { return _id; } set { _id = value; } }

        public DateTime FechaGuardado { get { return _fechaGuardado; } set { _fechaGuardado = value; } }

        // â”€â”€â”€ Claves forÃ¡neas â”€â”€â”€
        public int UsuarioId { get { return _usuarioId; } set { _usuarioId = value; } }
        public int? HabitacionId { get { return _habitacionId; } set { _habitacionId = value; } }
        public int? PisoId { get { return _pisoId; } set { _pisoId = value; } }

        // â”€â”€â”€ MÃ©todos de negocio â”€â”€â”€
        public bool EsFavoritoHabitacion() { return _habitacionId.HasValue; }
        public bool EsFavoritoPiso() { return _pisoId.HasValue; }

        public ENFavorito() { _fechaGuardado = DateTime.Now; }
    }
}




