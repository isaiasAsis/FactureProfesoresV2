namespace FactureProfesoresV2.Domain
{
    public class LeccionCrear
    {
        public string Codigo_Curso { get; set; }

        public int Horas { get; set; }

        public DateTime Fecha_Leccion { get; set; }

        public string Id_Profesor { get; set; }
    }
}
