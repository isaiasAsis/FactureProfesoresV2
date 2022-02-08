namespace FactureProfesoresV2.Models
{
    public class ProfesorCrearModel
    {
        public string Nombre { get; set; }

        public string Identificacion { get; set; }

        public DateTime Fecha_nacimiento { get; set; }

        public string Tipo_moneda { get; set; }

        public decimal Tarifa_horaria { get; set; }

        public string Tipo_profesor { get; set; }
    }
}
