using System;
using System.ComponentModel.DataAnnotations;

namespace ConviAppWeb.Models
{
    /// <summary>
    /// ENNotificacion â€” Entidad de Negocio para notificaciones automÃ¡ticas.
    /// EnvÃ­a avisos sobre pagos pendientes, tareas sin realizar, incidencias (Lidia).
    /// </summary>
    public class ENNotificacion
    {
        // â”€â”€â”€ Atributos privados â”€â”€â”€
        private int _id;
        private string _titulo;
        private string _mensaje;
        private string _tipo;
        private bool _leida;
        private DateTime _fechaCreacion;
        private DateTime? _fechaLectura;
        private int _usuarioId;

        // â”€â”€â”€ Propiedades pÃºblicas â”€â”€â”€
        [Key]
        public int Id { get { return _id; } set { _id = value; } }

        [Required]
        [MaxLength(200)]
        public string Titulo { get { return _titulo; } set { _titulo = value; } }

        [Required]
        [MaxLength(1000)]
        public string Mensaje { get { return _mensaje; } set { _mensaje = value; } }

        [Required]
        [MaxLength(50)]
        public string Tipo { get { return _tipo; } set { _tipo = value; } } // pago, tarea, incidencia, reserva, general

        public bool Leida { get { return _leida; } set { _leida = value; } }

        public DateTime FechaCreacion { get { return _fechaCreacion; } set { _fechaCreacion = value; } }

        public DateTime? FechaLectura { get { return _fechaLectura; } set { _fechaLectura = value; } }

        // â”€â”€â”€ Clave forÃ¡nea â”€â”€â”€
        public int UsuarioId { get { return _usuarioId; } set { _usuarioId = value; } }

        // â”€â”€â”€ MÃ©todos de negocio â”€â”€â”€
        public bool EsLeida() { return _leida; }
        public void MarcarComoLeida() { _leida = true; _fechaLectura = DateTime.Now; }
        public bool EsReciente() { return (DateTime.Now - _fechaCreacion).TotalHours < 24; }

        public ENNotificacion()
        {
            _fechaCreacion = DateTime.Now;
            _leida = false;
        }
    }
}




