using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ConviAppWeb.Models
{
    /// <summary>
    /// ENPiso â€” Entidad de Negocio para pisos gestionados por la inmobiliaria.
    /// Un piso puede contener varias habitaciones (Marina).
    /// </summary>
    public class ENPiso
    {
        // â”€â”€â”€ Atributos privados â”€â”€â”€
        private int _id;
        private string _direccion;
        private string _ciudad;
        private string _codigoPostal;
        private int _numeroHabitaciones;
        private int _numeroBanos;
        private decimal _precioTotal;
        private string _descripcion;
        private bool _disponible;
        private string _caracteristicas; // JSON o CSV de extras (parking, ascensor, etc.)

        // â”€â”€â”€ Propiedades pÃºblicas â”€â”€â”€
        [Key]
        public int Id { get { return _id; } set { _id = value; } }

        [Required]
        [MaxLength(300)]
        public string Direccion { get { return _direccion; } set { _direccion = value; } }

        [Required]
        [MaxLength(100)]
        public string Ciudad { get { return _ciudad; } set { _ciudad = value; } }

        [MaxLength(10)]
        public string CodigoPostal { get { return _codigoPostal; } set { _codigoPostal = value; } }

        [Range(1, 20)]
        public int NumeroHabitaciones { get { return _numeroHabitaciones; } set { _numeroHabitaciones = value; } }

        [Range(1, 10)]
        public int NumeroBanos { get { return _numeroBanos; } set { _numeroBanos = value; } }

        [Column(TypeName = "decimal(18,2)")]
        public decimal PrecioTotal { get { return _precioTotal; } set { _precioTotal = value; } }

        [MaxLength(2000)]
        public string Descripcion { get { return _descripcion; } set { _descripcion = value; } }

        public bool Disponible { get { return _disponible; } set { _disponible = value; } }

        public string Caracteristicas { get { return _caracteristicas; } set { _caracteristicas = value; } }

        // â”€â”€â”€ NavegaciÃ³n â”€â”€â”€
        public ICollection<ENHabitacion> Habitaciones { get; set; }

        // â”€â”€â”€ MÃ©todos de negocio â”€â”€â”€
        public bool TieneHabitacionesLibres() { return _disponible; }
        public string DireccionCompleta() { return "{_direccion}, {_codigoPostal} " + _ciudad.Trim(); }

        public ENPiso() { _disponible = true; }
    }
}




