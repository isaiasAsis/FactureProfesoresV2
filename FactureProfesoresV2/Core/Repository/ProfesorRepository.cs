using FactureProfesoresV2.Core.Interfaces;
using FactureProfesoresV2.DatabaseInsight;
using FactureProfesoresV2.Domain;
using Insight.Database;

namespace FactureProfesoresV2.Core.Repository
{
    public class ProfesorRepository : IProfesorRepository
    {
        private readonly IProfesorDBConection _profesorDbConnection;

        public ProfesorRepository(IProfesorDBConection profesorDBConection)
        {
            _profesorDbConnection = profesorDBConection;
        }

        public void ProfesoresCrear(ProfesorCrear profesorCrear)
        {
            _profesorDbConnection.GetCurrent().As<ProfesorDBConnection_Profesor>()
                                               .ProfesorCrear(profesorCrear: profesorCrear);
        }
    }
}
