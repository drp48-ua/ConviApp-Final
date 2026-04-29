using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace ConviAppWeb.Models
{
    /// <summary>
    /// ENRol â€” Entidad de Negocio para roles de usuario.
    /// Permite controlar permisos: inquilino, administrador, propietario (Moni).
    /// </summary>
    public class ENRol
    {
        // â”€â”€â”€ Atributos privados â”€â”€â”€
        private int _id;
        private string _nombre;
        private string _descripcion;
        private bool _puedeGestionarPisos;
        private bool _puedeVerContratos;
        private bool _puedeGestionarUsuarios;

        // â”€â”€â”€ Propiedades pÃºblicas â”€â”€â”€
        [Key]
        public int Id { get { return _id; } set { _id = value; } }

        [Required]
        [MaxLength(50)]
        public string Nombre { get { return _nombre; } set { _nombre = value; } } // inquilino, administrador, propietario

        [MaxLength(250)]
        public string Descripcion { get { return _descripcion; } set { _descripcion = value; } }

        public bool PuedeGestionarPisos { get { return _puedeGestionarPisos; } set { _puedeGestionarPisos = value; } }
        public bool PuedeVerContratos { get { return _puedeVerContratos; } set { _puedeVerContratos = value; } }
        public bool PuedeGestionarUsuarios { get { return _puedeGestionarUsuarios; } set { _puedeGestionarUsuarios = value; } }


        // â”€â”€â”€ MÃ©todos de negocio â”€â”€â”€
        public bool EsAdministrador() { return _nombre.ToLower() == "administrador"; }
        public bool EsInquilino() { return _nombre.ToLower() == "inquilino"; }
    }
}




