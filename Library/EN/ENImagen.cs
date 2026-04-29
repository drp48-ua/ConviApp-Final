using System;
using System.ComponentModel.DataAnnotations;

namespace ConviAppWeb.Models
{
    /// <summary>
    /// ENImagen — Entidad de Negocio para imágenes de habitaciones y pisos.
    /// Permite mostrar fotos del alojamiento (Marina).
    /// </summary>
    public class ENImagen
    {
        // ─── Atributos privados ───
        private int _id;
        private string _url;
        private string _descripcion;
        private bool _esPrincipal;
        private DateTime _fechaSubida;
        private int? _habitacionId;
        private int? _pisoId;

        // ─── Propiedades pÃºblicas ───
        [Key]
        public int Id { get { return _id; } set { _id = value; } }

        [Required]
        [MaxLength(500)]
        public string Url { get { return _url; } set { _url = value; } }

        [MaxLength(200)]
        public string Descripcion { get { return _descripcion; } set { _descripcion = value; } }

        public bool EsPrincipal { get { return _esPrincipal; } set { _esPrincipal = value; } }

        public DateTime FechaSubida { get { return _fechaSubida; } set { _fechaSubida = value; } }

        // ─── Claves forÃ¡neas ───
        public int? HabitacionId { get { return _habitacionId; } set { _habitacionId = value; } }
        public int? PisoId { get { return _pisoId; } set { _pisoId = value; } }

        // ─── Métodos de negocio ───
        public bool EsImagenPrincipal() { return _esPrincipal; }

        public ENImagen() { _fechaSubida = DateTime.Now; }
    }
}




