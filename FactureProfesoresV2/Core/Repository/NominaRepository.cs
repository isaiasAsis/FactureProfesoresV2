using FactureProfesoresV2.Core.Interfaces;
using FactureProfesoresV2.DatabaseInsight;
using FactureProfesoresV2.Domain;
using FactureProfesoresV2.Models;
using Insight.Database;

namespace FactureProfesoresV2.Core.Repository
{
    public class NominaRepository: INominaRepository
    {

        private readonly IProfesorDBConection _profesorDbConnection;

        public NominaRepository(IProfesorDBConection profesorDBConection)
        {
            _profesorDbConnection = profesorDBConection;
        }

        //public (IEnumerable<GetLecciones> nomina, int? totalRows) GetLecciones(GetLeccionesFilter nominaFilter)
        //{
        //    var nomina = _profesorDbConnection.GetCurrent().As<ProfesorDBConnection_Profesor>()
        //                                       .GetLecciones(getLeccionesFilter: nominaFilter);

        //    var totalRows = nomina.FirstOrDefault()?.num_TotalFilas;

        //    var nominaEntity = nomina.Select(nominaResponse => new GetLecciones(nominaResponse)).ToList();

        //    return (nominaEntity, totalRows);
        //}


    }
}
