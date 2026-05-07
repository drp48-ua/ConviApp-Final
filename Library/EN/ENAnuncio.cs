using System;
using System.ComponentModel.DataAnnotations;

namespace ConviAppWeb.Models
{
    public class ENAnuncio
    {
        public int Id { get; set; }
        public string Seccion { get; set; }
        public string Titulo { get; set; }
        public string Subtitulo { get; set; }
        public string ImagenUrl { get; set; }
    }
}
