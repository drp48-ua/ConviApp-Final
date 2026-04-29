using System;
using System.ComponentModel.DataAnnotations;

namespace ConviAppWeb.Models
{
    /// <summary>
    /// ENMensaje â€” Entidad de Negocio para mensajes entre usuarios del piso.
    /// Facilita la comunicaciÃ³n interna (Maca).
    /// </summary>
    public class ENMensaje
    {
        // â”€â”€â”€ Atributos privados â”€â”€â”€
        private int _id;
        private string _contenido;
        private DateTime _fechaEnvio;
        private bool _leido;
        private int _emisorId;
        private int? _receptorId;
        private int? _pisoId; // mensajes de grupo del piso

        // â”€â”€â”€ Propiedades pÃºblicas â”€â”€â”€
        [Key]
        public int Id { get { return _id; } set { _id = value; } }

        [Required]
        [MaxLength(2000)]
        public string Contenido { get { return _contenido; } set { _contenido = value; } }

        public DateTime FechaEnvio { get { return _fechaEnvio; } set { _fechaEnvio = value; } }

        public bool Leido { get { return _leido; } set { _leido = value; } }

        // â”€â”€â”€ Claves forÃ¡neas â”€â”€â”€
        public int EmisorId { get { return _emisorId; } set { _emisorId = value; } }
        public ENUsuario Emisor { get; set; }

        public int? ReceptorId { get { return _receptorId; } set { _receptorId = value; } }
        public ENUsuario Receptor { get; set; }

        public int? PisoId { get { return _pisoId; } set { _pisoId = value; } }
        public ENPiso Piso { get; set; }

        // â”€â”€â”€ MÃ©todos de negocio â”€â”€â”€
        public bool EsMensajeGrupal() { return _pisoId.HasValue && !_receptorId.HasValue; }
        public bool EsMensajePrivado() { return _receptorId.HasValue; }
        public void MarcarComoLeido() { _leido = true; }

        public ENMensaje()
        {
            _fechaEnvio = DateTime.Now;
            _leido = false;
        }
    }
}




