using System;
using System.ComponentModel.DataAnnotations;

namespace ConviAppWeb.Models
{
    /// <summary>
    /// ENTarea â€” Entidad de Negocio para tareas domÃ©sticas compartidas.
    /// Organiza responsabilidades entre inquilinos (Maca).
    /// </summary>
    public class ENTarea
    {
        // â”€â”€â”€ Atributos privados â”€â”€â”€
        private int _id;
        private string _titulo;
        private string _descripcion;
        private string _estado;
        private DateTime _fechaCreacion;
        private DateTime? _fechaLimite;
        private string _prioridad;
        private int _creadaPorId;
        private int? _asignadaAId;
        private int? _pisoId;

        // â”€â”€â”€ Propiedades pÃºblicas â”€â”€â”€
        [Key]
        public int Id { get { return _id; } set { _id = value; } }

        [Required]
        [MaxLength(200)]
        public string Titulo { get { return _titulo; } set { _titulo = value; } }

        [MaxLength(1000)]
        public string Descripcion { get { return _descripcion; } set { _descripcion = value; } }

        [Required]
        public string Estado { get { return _estado; } set { _estado = value; } } // pendiente, en_progreso, completada

        public DateTime FechaCreacion { get { return _fechaCreacion; } set { _fechaCreacion = value; } }

        public DateTime? FechaLimite { get { return _fechaLimite; } set { _fechaLimite = value; } }

        [MaxLength(20)]
        public string Prioridad { get { return _prioridad; } set { _prioridad = value; } } // baja, media, alta

        // â”€â”€â”€ Claves forÃ¡neas â”€â”€â”€
        public int CreadaPorId { get { return _creadaPorId; } set { _creadaPorId = value; } }
        public ENUsuario CreadaPor { get; set; }

        public int? AsignadaAId { get { return _asignadaAId; } set { _asignadaAId = value; } }
        public ENUsuario AsignadaA { get; set; }

        public int? PisoId { get { return _pisoId; } set { _pisoId = value; } }
        public ENPiso Piso { get; set; }

        // â”€â”€â”€ MÃ©todos de negocio â”€â”€â”€
        public bool EstaCompletada() { return _estado == "completada"; }
        public bool EstaVencida() { return _fechaLimite.HasValue && _fechaLimite.Value < DateTime.Now && !EstaCompletada(); }

        public ENTarea()
        {
            _fechaCreacion = DateTime.Now;
            _estado = "pendiente";
            _prioridad = "media";
        }
    }
}




