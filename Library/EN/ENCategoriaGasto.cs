using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ConviAppWeb.Models
{
    /// <summary>
    /// ENCategoriaGasto — CategorÃ­as para clasificar los gastos comunes (Nazim).
    /// Ejemplos: Luz, Agua, Internet, Comunidad.
    /// </summary>
    public class ENCategoriaGasto
    {
        // ─── Atributos privados ───
        private int _id;
        private string _nombre;
        private string _descripcion;
        private string _icono; // nombre de icono (FontAwesome, etc.)

        // ─── Propiedades pÃºblicas ───
        [Key]
        public int Id { get { return _id; } set { _id = value; } }

        [Required]
        [MaxLength(100)]
        public string Nombre { get { return _nombre; } set { _nombre = value; } }

        [MaxLength(300)]
        public string Descripcion { get { return _descripcion; } set { _descripcion = value; } }

        [MaxLength(50)]
        public string Icono { get { return _icono; } set { _icono = value; } }

        // ─── NavegaciÃ³n ───
        public ICollection<ENGasto> Gastos { get; set; }

        // ─── Métodos de negocio ───
        public int TotalGastos() { return Gastos != null ? Gastos.Count : 0; }
    }
}




