using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ConviAppWeb.Models
{
    public class ENComunidadUsuario
    {
        [Key]
        public int Id { get; set; }

        public int PisoId { get; set; }
        public ENPiso Piso { get; set; }

        public int UsuarioId { get; set; }
        public ENUsuario Usuario { get; set; }

        public DateTime FechaUnion { get; set; }

        public ENComunidadUsuario()
        {
            FechaUnion = DateTime.Now;
        }
    }
}
