using FactureProfesoresV2.Domain;
using FactureProfesoresV2.Models;
using Insight.Database;
using System.Data;

namespace FactureProfesoresV2.DatabaseInsight
{
    public interface ProfesorDBConnection_Profesor: IDbConnection, IDbTransaction
    {
        [Sql("dbo.ProfesoresCrear")]
        void ProfesorCrear(ProfesorCrear profesorCrear);

        [Sql("dbo.GetProfesores")]
        List<ProfesorModel> GetProfesores();

        [Sql("dbo.LeccionesCrear")]
        void LeccionCrear(LeccionCrear leccionCrear);

        [Sql("dbo.GetLecciones")]
        List<LeccionModel> GetLecciones(GetLeccionesFilter getLeccionesFilter);
    }
}
