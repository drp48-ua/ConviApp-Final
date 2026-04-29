using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace ConviAppWeb.Models
{
    /// <summary>
    /// ENZonaComun — Entidad de Negocio para zonas comunes del piso.
    /// Ejemplos: lavanderÃ­a, cocina, sala de estudio (Lidia).
    /// </summary>
    public class ENZonaComun
    {
        // ─── Atributos privados ───
        private int _id;
        private string _nombre;
        private string _descripcion;
        private int _capacidad;
        private bool _disponible;
        private int? _pisoId;

        // ─── Propiedades pÃºblicas ───
        [Key]
        public int Id { get { return _id; } set { _id = value; } }

        [Required]
        [MaxLength(100)]
        public string Nombre { get { return _nombre; } set { _nombre = value; } } // lavanderÃ­a, cocina, sala_estudio

        [MaxLength(500)]
        public string Descripcion { get { return _descripcion; } set { _descripcion = value; } }

        [Range(1, 100)]
        public int Capacidad { get { return _capacidad; } set { _capacidad = value; } }

        public bool Disponible { get { return _disponible; } set { _disponible = value; } }

        // ─── Clave forÃ¡nea ───
        public int? PisoId { get { return _pisoId; } set { _pisoId = value; } }

        // ─── Métodos de negocio ───
        public bool EstaDisponible() { return _disponible; }
        public int TotalReservas() { return 0; } // Se calcularÃ­a con una consulta ADO.NET

        public ENZonaComun() { _disponible = true; _capacidad = 1; }
    }
}




