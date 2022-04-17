namespace FactureProfesoresV2.Models
{
    public class LeccionModel
    {

        public string Codigo_Curso { get; set; }

        public int Horas { get; set; }

        public DateTime Fecha_Leccion { get; set; }

        public string Id_Profesor { get; set; }

        public decimal Valor_leccion { get; set; }

    }
}
