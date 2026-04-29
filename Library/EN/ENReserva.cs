using System;
using System.ComponentModel.DataAnnotations;

namespace ConviAppWeb.Models
{
    /// <summary>
    /// ENReserva — Entidad de Negocio para reservas de zonas comunes.
    /// Permite organizar el uso de espacios compartidos (Lidia).
    /// </summary>
    public class ENReserva
    {
        // ─── Atributos privados ───
        private int _id;
        private DateTime _fechaInicio;
        private DateTime _fechaFin;
        private string _estado;
        private string _motivo;
        private int _usuarioId;
        private int _zonaComunId;

        // ─── Propiedades pÃºblicas ───
        [Key]
        public int Id { get { return _id; } set { _id = value; } }

        [Required]
        public DateTime FechaInicio { get { return _fechaInicio; } set { _fechaInicio = value; } }

        [Required]
        public DateTime FechaFin { get { return _fechaFin; } set { _fechaFin = value; } }

        [Required]
        public string Estado { get { return _estado; } set { _estado = value; } } // pendiente, confirmada, cancelada

        [MaxLength(300)]
        public string Motivo { get { return _motivo; } set { _motivo = value; } }

        // ─── Claves forÃ¡neas ───
        public int UsuarioId { get { return _usuarioId; } set { _usuarioId = value; } }
        public ENUsuario Usuario { get; set; }

        public int ZonaComunId { get { return _zonaComunId; } set { _zonaComunId = value; } }
        public ENZonaComun ZonaComun { get; set; }

        // ─── Métodos de negocio ───
        public bool EsActiva() { return _estado == "confirmada" && _fechaFin >= DateTime.Now; }
        public bool EstaVencida() { return _fechaFin < DateTime.Now; }
        public double DuracionHoras() { return (_fechaFin - _fechaInicio).TotalHours; }

        public ENReserva() { _estado = "pendiente"; }
    }
}




