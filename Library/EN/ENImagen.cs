using System;
using System.ComponentModel.DataAnnotations;

namespace ConviAppWeb.Models
{
    /// <summary>
    /// ENImagen â€” Entidad de Negocio para imÃ¡genes de habitaciones y pisos.
    /// Permite mostrar fotos del alojamiento (Marina).
    /// </summary>
    public class ENImagen
    {
        // â”€â”€â”€ Atributos privados â”€â”€â”€
        private int _id;
        private string _url;
        private string _descripcion;
        private bool _esPrincipal;
        private DateTime _fechaSubida;
        private int? _habitacionId;
        private int? _pisoId;

        // â”€â”€â”€ Propiedades pÃºblicas â”€â”€â”€
        [Key]
        public int Id { get { return _id; } set { _id = value; } }

        [Required]
        [MaxLength(500)]
        public string Url { get { return _url; } set { _url = value; } }

        [MaxLength(200)]
        public string Descripcion { get { return _descripcion; } set { _descripcion = value; } }

        public bool EsPrincipal { get { return _esPrincipal; } set { _esPrincipal = value; } }

        public DateTime FechaSubida { get { return _fechaSubida; } set { _fechaSubida = value; } }

        // â”€â”€â”€ Claves forÃ¡neas â”€â”€â”€
        public int? HabitacionId { get { return _habitacionId; } set { _habitacionId = value; } }
        public int? PisoId { get { return _pisoId; } set { _pisoId = value; } }

        // â”€â”€â”€ MÃ©todos de negocio â”€â”€â”€
        public bool EsImagenPrincipal() { return _esPrincipal; }

        public ENImagen() { _fechaSubida = DateTime.Now; }
    }
}




