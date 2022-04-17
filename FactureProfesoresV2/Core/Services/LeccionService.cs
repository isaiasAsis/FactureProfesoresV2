using FactureProfesoresV2.Core.Interfaces;
using FactureProfesoresV2.DatabaseInsight;
using FactureProfesoresV2.Domain;

namespace FactureProfesoresV2.Core.Services
{
    public class LeccionService : ILeccionService
    {
        private readonly IProfesorDBConection _profesorDbConnection;
        private readonly ILeccionRepository _leccionRepository;
        public LeccionService(IProfesorDBConection profesorDbConnection,
                                ILeccionRepository leccionRepository)
        {
            _profesorDbConnection = profesorDbConnection;
            _leccionRepository = leccionRepository;
        }

        public void LeccionCrear(LeccionCrear leccionCrear)
        {   

            _leccionRepository.LeccionCrear(leccionCrear: leccionCrear);
        }

    }
}
