using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ConviAppWeb.Models
{
    /// <summary>
    /// ENCategoriaGasto â€” CategorÃ­as para clasificar los gastos comunes (Nazim).
    /// Ejemplos: Luz, Agua, Internet, Comunidad.
    /// </summary>
    public class ENCategoriaGasto
    {
        // â”€â”€â”€ Atributos privados â”€â”€â”€
        private int _id;
        private string _nombre;
        private string _descripcion;
        private string _icono; // nombre de icono (FontAwesome, etc.)

        // â”€â”€â”€ Propiedades pÃºblicas â”€â”€â”€
        [Key]
        public int Id { get { return _id; } set { _id = value; } }

        [Required]
        [MaxLength(100)]
        public string Nombre { get { return _nombre; } set { _nombre = value; } }

        [MaxLength(300)]
        public string Descripcion { get { return _descripcion; } set { _descripcion = value; } }

        [MaxLength(50)]
        public string Icono { get { return _icono; } set { _icono = value; } }

        // â”€â”€â”€ NavegaciÃ³n â”€â”€â”€
        public ICollection<ENGasto> Gastos { get; set; }

        // â”€â”€â”€ MÃ©todos de negocio â”€â”€â”€
        public int TotalGastos() { return Gastos != null ? Gastos.Count : 0; }
    }
}




