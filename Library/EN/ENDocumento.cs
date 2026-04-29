using System;
using System.ComponentModel.DataAnnotations;

namespace ConviAppWeb.Models
{
    /// <summary>
    /// ENDocumento â€” Entidad de Negocio para documentos adjuntos.
    /// Capa de lÃ³gica de negocio (Entrega 3 - Dani).
    /// </summary>
    public class ENDocumento
    {
        // â”€â”€â”€ Atributos privados â”€â”€â”€
        private int _id;
        private string _fileName;
        private byte[] _fileData;
        private string _contentType;
        private long _fileSize;
        private string _type;
        private DateTime _uploadDate;
        private string _description;
        private int? _contratoId;
        private int? _propertyId;
        private int _userId;

        // â”€â”€â”€ Propiedades pÃºblicas â”€â”€â”€
        [Key]
        public int Id
        {
            get { return _id; } set { _id = value; }
        }

        [Required(ErrorMessage = "El nombre del archivo es obligatorio")]
        public string FileName
        {
            get { return _fileName; } set { _fileName = value; }
        }

        [Required]
        public byte[] FileData
        {
            get { return _fileData; } set { _fileData = value; }
        }

        [Required]
        public string ContentType
        {
            get { return _contentType; } set { _contentType = value; }
        } // application/pdf, image/png, etc.

        public long FileSize
        {
            get { return _fileSize; } set { _fileSize = value; }
        }

        [Required]
        public string Type
        {
            get { return _type; } set { _type = value; }
        } // contrato, recibo, factura, dni, otro

        public DateTime UploadDate
        {
            get { return _uploadDate; } set { _uploadDate = value; }
        }

        public string Description
        {
            get { return _description; } set { _description = value; }
        }

        // â”€â”€â”€ Claves forÃ¡neas â”€â”€â”€
        public int? ContratoId
        {
            get { return _contratoId; } set { _contratoId = value; }
        }
        public ENContrato Contrato { get; set; }

        public int? PropertyId
        {
            get { return _propertyId; } set { _propertyId = value; }
        }
        // Property nav eliminada (sin EF)

        public int UserId
        {
            get { return _userId; } set { _userId = value; }
        }
        // User nav eliminada (sin EF)

        // â”€â”€â”€ MÃ©todos de negocio â”€â”€â”€
        public string FileSizeFormatted()
        {
            if (_fileSize < 1024) return _fileSize + " B";
            if (_fileSize < 1048576) return (_fileSize / 1024.0).ToString("F1") + " KB";
            return (_fileSize / 1048576.0).ToString("F1") + " MB";
        }

        public bool IsPdf() { return _contentType == "application/pdf"; }
        public bool IsImage() { return _contentType.StartsWith("image/") == true; }

        /// <summary>Constructor por defecto.</summary>
        public ENDocumento()
        {
            _type = "otro";
            _uploadDate = DateTime.Now;
        }
    }
}




