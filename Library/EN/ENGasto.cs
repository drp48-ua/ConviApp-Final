using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ConviAppWeb.Models
{
    /// <summary>
    /// ENGasto — Entidad de Negocio para gastos compartidos del piso.
    /// Registra costes comunes: luz, agua, internet, etc. (Nazim).
    /// </summary>
    public class ENGasto
    {
        // ─── Atributos privados ───
        private int _id;
        private string _concepto;
        private decimal _importe;
        private DateTime _fecha;
        private bool _pagado;
        private string _descripcion;
        private int _registradoPorId;
        private int? _pisoId;
        private int? _categoriaId;

        // ─── Propiedades pÃºblicas ───
        [Key]
        public int Id { get { return _id; } set { _id = value; } }

        [Required]
        [MaxLength(200)]
        public string Concepto { get { return _concepto; } set { _concepto = value; } }

        [Column(TypeName = "decimal(18,2)")]
        [Range(0.01, double.MaxValue)]
        public decimal Importe { get { return _importe; } set { _importe = value; } }

        public DateTime Fecha { get { return _fecha; } set { _fecha = value; } }

        public bool Pagado { get { return _pagado; } set { _pagado = value; } }

        [MaxLength(500)]
        public string Descripcion { get { return _descripcion; } set { _descripcion = value; } }

        // ─── Claves forÃ¡neas ───
        public int RegistradoPorId { get { return _registradoPorId; } set { _registradoPorId = value; } }
        public ENUsuario RegistradoPor { get; set; }

        public int? PisoId { get { return _pisoId; } set { _pisoId = value; } }
        public ENPiso Piso { get; set; }

        public int? CategoriaId { get { return _categoriaId; } set { _categoriaId = value; } }
        public ENCategoriaGasto Categoria { get; set; }

        // ─── Métodos de negocio ───
        public bool EstaPagado() { return _pagado; }
        public decimal ImportePorPersona(int numPersonas) { return numPersonas > 0 ? _importe / numPersonas : _importe; }

        public ENGasto()
        {
            _fecha = DateTime.Now;
            _pagado = false;
        }
    }
}




