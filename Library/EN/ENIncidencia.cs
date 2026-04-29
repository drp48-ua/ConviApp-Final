using System;
using System.ComponentModel.DataAnnotations;

namespace ConviAppWeb.Models
{
    /// <summary>
    /// ENIncidencia â€” Entidad de Negocio para incidencias o averÃ­as del piso.
    /// GestiÃ³n de problemas y seguimiento de su resoluciÃ³n (Nazim).
    /// </summary>
    public class ENIncidencia
    {
        // â”€â”€â”€ Atributos privados â”€â”€â”€
        private int _id;
        private string _titulo;
        private string _descripcion;
        private string _estado;
        private string _prioridad;
        private DateTime _fechaReporte;
        private DateTime? _fechaResolucion;
        private int _reportadaPorId;
        private int? _pisoId;
        private int? _habitacionId;

        // â”€â”€â”€ Propiedades pÃºblicas â”€â”€â”€
        [Key]
        public int Id { get { return _id; } set { _id = value; } }

        [Required]
        [MaxLength(200)]
        public string Titulo { get { return _titulo; } set { _titulo = value; } }

        [Required]
        [MaxLength(2000)]
        public string Descripcion { get { return _descripcion; } set { _descripcion = value; } }

        [Required]
        public string Estado { get { return _estado; } set { _estado = value; } } // abierta, en_progreso, resuelta

        [MaxLength(20)]
        public string Prioridad { get { return _prioridad; } set { _prioridad = value; } } // baja, media, alta, urgente

        public DateTime FechaReporte { get { return _fechaReporte; } set { _fechaReporte = value; } }
        public DateTime? FechaResolucion { get { return _fechaResolucion; } set { _fechaResolucion = value; } }

        // â”€â”€â”€ Claves forÃ¡neas â”€â”€â”€
        public int ReportadaPorId { get { return _reportadaPorId; } set { _reportadaPorId = value; } }
        public ENUsuario ReportadaPor { get; set; }

        public int? PisoId { get { return _pisoId; } set { _pisoId = value; } }
        public ENPiso Piso { get; set; }

        public int? HabitacionId { get { return _habitacionId; } set { _habitacionId = value; } }
        public ENHabitacion Habitacion { get; set; }

        // â”€â”€â”€ MÃ©todos de negocio â”€â”€â”€
        public bool EstaResuelta() { return _estado == "resuelta"; }
        public bool EsUrgente() { return _prioridad == "urgente"; }
        public int? DiasAbierta() { return _fechaResolucion.HasValue
            ? (int)(_fechaResolucion.Value - _fechaReporte).TotalDays
            : (int)(DateTime.Now - _fechaReporte).TotalDays; }

        public ENIncidencia()
        {
            _fechaReporte = DateTime.Now;
            _estado = "abierta";
            _prioridad = "media";
        }
    }
}




