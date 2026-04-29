using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace ConviAppWeb.Models
{
    /// <summary>
    /// ENUsuario â€” Entidad de Negocio para usuarios de la plataforma.
    /// Representa a inquilinos y administradores (Moni).
    /// </summary>
    public class ENUsuario
    {
        // â”€â”€â”€ Atributos privados â”€â”€â”€
        private int _id;
        private string _nombre;
        private string _apellidos;
        private string _email;
        private string _passwordHash;
        private string _telefono;
        private DateTime _fechaRegistro;
        private bool _activo;
        private int _rolId;
        private int? _suscripcionId;

        // â”€â”€â”€ Propiedades pÃºblicas â”€â”€â”€
        [Key]
        public int Id { get { return _id; } set { _id = value; } }

        [Required(ErrorMessage = "El nombre es obligatorio")]
        [MaxLength(100)]
        public string Nombre { get { return _nombre; } set { _nombre = value; } }

        [MaxLength(150)]
        public string Apellidos { get { return _apellidos; } set { _apellidos = value; } }

        [Required]
        [EmailAddress]
        [MaxLength(200)]
        public string Email { get { return _email; } set { _email = value; } }

        [Required]
        public string PasswordHash { get { return _passwordHash; } set { _passwordHash = value; } }

        [Phone]
        [MaxLength(20)]
        public string Telefono { get { return _telefono; } set { _telefono = value; } }

        public DateTime FechaRegistro { get { return _fechaRegistro; } set { _fechaRegistro = value; } }

        public bool Activo { get { return _activo; } set { _activo = value; } }

        // â”€â”€â”€ Claves forÃ¡neas â”€â”€â”€
        public int RolId { get { return _rolId; } set { _rolId = value; } }
        public ENRol Rol { get; set; }

        public int? SuscripcionId { get { return _suscripcionId; } set { _suscripcionId = value; } }
        public ENSuscripcion Suscripcion { get; set; }

        // â”€â”€â”€ NavegaciÃ³n â”€â”€â”€
        public ICollection<ENContrato> Contratos { get; set; }
        public ICollection<ENPago> Pagos { get; set; }

        // â”€â”€â”€ MÃ©todos de negocio â”€â”€â”€
        public string NombreCompleto() { return "{_nombre} " + _apellidos.Trim(); }
        public bool TieneSuscripcionActiva() { return _suscripcionId.HasValue && _activo; }

        public ENUsuario()
        {
            _fechaRegistro = DateTime.Now;
            _activo = true;
        }
    }
}




