using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ConviAppWeb.Models
{
    /// <summary>
    /// ENHabitacion â€” Entidad de Negocio para habitaciones dentro de un piso.
    /// Es la unidad principal de alquiler (Marina).
    /// </summary>
    public class ENHabitacion
    {
        // â”€â”€â”€ Atributos privados â”€â”€â”€
        private int _id;
        private string _numero;
        private decimal _precio;
        private double _metros;
        private bool _disponible;
        private bool _tieneBano;
        private string _descripcion;
        private int _pisoId;

        // â”€â”€â”€ Propiedades pÃºblicas â”€â”€â”€
        [Key]
        public int Id { get { return _id; } set { _id = value; } }

        [Required]
        [MaxLength(20)]
        public string Numero { get { return _numero; } set { _numero = value; } } // "101", "A", etc.

        [Column(TypeName = "decimal(18,2)")]
        [Range(0, double.MaxValue)]
        public decimal Precio { get { return _precio; } set { _precio = value; } }

        [Range(0, 500)]
        public double Metros { get { return _metros; } set { _metros = value; } }

        public bool Disponible { get { return _disponible; } set { _disponible = value; } }

        public bool TieneBano { get { return _tieneBano; } set { _tieneBano = value; } }

        [MaxLength(1000)]
        public string Descripcion { get { return _descripcion; } set { _descripcion = value; } }

        // â”€â”€â”€ Clave forÃ¡nea â”€â”€â”€
        public int PisoId { get { return _pisoId; } set { _pisoId = value; } }

        // â”€â”€â”€ MÃ©todos de negocio â”€â”€â”€
        public bool EstaLibre() { return _disponible; }
        public string DescripcionCorta() { return "Hab. {_numero} â€” {_precio:C}/mes â€” " + _metros + "mÂ²"; }
    }
}




