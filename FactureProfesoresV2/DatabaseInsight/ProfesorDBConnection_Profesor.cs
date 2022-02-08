using FactureProfesoresV2.Domain;
using Insight.Database;
using System.Data;

namespace FactureProfesoresV2.DatabaseInsight
{
    public interface ProfesorDBConnection_Profesor: IDbConnection, IDbTransaction
    {
        [Sql("dbo.ProfesoresCrear")]
        void ProfesorCrear(ProfesorCrear profesorCrear);
    }
}
