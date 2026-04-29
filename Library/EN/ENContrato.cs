using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ConviAppWeb.Models
{
    /// <summary>
    /// ENContrato â€” Entidad de Negocio para contratos de arrendamiento.
    /// Capa de lÃ³gica de negocio (Entrega 3 - Dani).
    /// Incluye atributos privados, propiedades pÃºblicas y estructura de comisiones.
    /// </summary>
    public class ENContrato
    {
        // â”€â”€â”€ Atributos privados â”€â”€â”€
        private int _id;
        private string _type;
        private DateTime _startDate;
        private DateTime _endDate;
        private decimal _monthlyRent;
        private decimal _depositAmount;
        private string _status;
        private string _notes;
        private int _propertyId;
        private int _userId;
        private decimal _commissionRate; // % comisiÃ³n sobre renta mensual (ej. 5 = 5%)

        // â”€â”€â”€ Propiedades pÃºblicas â”€â”€â”€
        [Key]
        public int Id
        {
            get { return _id; } set { _id = value; }
        }

        [Required(ErrorMessage = "El tipo de contrato es obligatorio")]
        public string Type
        {
            get { return _type; } set { _type = value; }
        } // arrendamiento, temporal, subarriendo

        [Required]
        public DateTime StartDate
        {
            get { return _startDate; } set { _startDate = value; }
        }

        [Required]
        public DateTime EndDate
        {
            get { return _endDate; } set { _endDate = value; }
        }

        [Column(TypeName = "decimal(18,2)")]
        [Range(0, double.MaxValue, ErrorMessage = "La renta debe ser positiva")]
        public decimal MonthlyRent
        {
            get { return _monthlyRent; } set { _monthlyRent = value; }
        }

        [Column(TypeName = "decimal(18,2)")]
        public decimal DepositAmount
        {
            get { return _depositAmount; } set { _depositAmount = value; }
        }

        [Required]
        public string Status
        {
            get { return _status; } set { _status = value; }
        } // activo, vencido, cancelado

        public string Notes
        {
            get { return _notes; } set { _notes = value; }
        }

        /// <summary>Porcentaje de comisiÃ³n sobre la renta mensual (ej: 5 = 5%).</summary>
        [Column(TypeName = "decimal(5,2)")]
        [Range(0, 100)]
        public decimal CommissionRate
        {
            get { return _commissionRate; } set { _commissionRate = value; }
        }

        // â”€â”€â”€ Claves forÃ¡neas â”€â”€â”€
        public int PropertyId
        {
            get { return _propertyId; } set { _propertyId = value; }
        }
        // Property nav eliminada (sin EF)

        public int UserId
        {
            get { return _userId; } set { _userId = value; }
        }
        // User nav eliminada (sin EF)

        // â”€â”€â”€ NavegaciÃ³n â”€â”€â”€
        public ICollection<ENPago> Pagos { get; set; }
        public ICollection<ENDocumento> Documentos { get; set; }

        // â”€â”€â”€ MÃ©todos de negocio â”€â”€â”€
        public bool IsActive() { return _status == "activo" && _endDate >= DateTime.Now; }

        public int RemainingMonths() { return IsActive() ? (int)((_endDate - DateTime.Now).TotalDays / 30) : 0; }

        public decimal TotalContractValue() { return _monthlyRent * (decimal)((_endDate - _startDate).TotalDays / 30); }

        /// <summary>Calcula la comisiÃ³n mensual segÃºn el porcentaje configurado.</summary>
        public decimal CalculateMonthlyCommission() { return _monthlyRent * (_commissionRate / 100m); }

        /// <summary>Calcula la comisiÃ³n total durante toda la vigencia del contrato.</summary>
        public decimal CalculateTotalCommission() { return TotalContractValue() * (_commissionRate / 100m); }

        /// <summary>Constructor por defecto â€” valores iniciales.</summary>
        public ENContrato()
        {
            _status = "activo";
            _commissionRate = 0m;
        }
    }
}




