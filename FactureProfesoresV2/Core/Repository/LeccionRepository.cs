using FactureProfesoresV2.Core.Interfaces;
using FactureProfesoresV2.DatabaseInsight;
using FactureProfesoresV2.Domain;
using FactureProfesoresV2.Models;
using Insight.Database;

namespace FactureProfesoresV2.Core.Repository
{
    public class LeccionRepository: ILeccionRepository
    {

        private readonly IProfesorDBConection _profesorDbConnection;

        public LeccionRepository(IProfesorDBConection profesorDBConection)
        {
            _profesorDbConnection = profesorDBConection;
        }

        public void LeccionCrear(LeccionCrear leccionCrear)
        {
            _profesorDbConnection.GetCurrent().As<ProfesorDBConnection_Profesor>()
                                               .LeccionCrear(leccionCrear: leccionCrear);
        }

        //public (IEnumerable<GetLecciones> lecciones, int? totalRows) GetLecciones(GetLeccionesFilter leccionesFilter)
        //{
        //    var lecciones = _profesorDbConnection.GetCurrent().As<ProfesorDBConnection_Profesor>()
        //                                       .GetLecciones(getLeccionesFilter: leccionesFilter);

        //    var totalRows = lecciones.FirstOrDefault()?.num_TotalFilas;

        //    var leccionesEntity = lecciones.Select(leccionesResponse => new GetLecciones(leccionesResponse)).ToList();

        //    return (leccionesEntity, totalRows);
        //}

        public List<LeccionModel> GetLecciones(GetLeccionesFilter leccionesFilter)
        {
            return _profesorDbConnection.GetCurrent().As<ProfesorDBConnection_Profesor>()
                                               .GetLecciones(leccionesFilter);
        }

    }
}
