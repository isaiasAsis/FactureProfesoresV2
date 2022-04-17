using FactureProfesoresV2.Domain;
using FactureProfesoresV2.Models;

namespace FactureProfesoresV2.Core.Interfaces
{
    public interface ILeccionRepository
    {
        public void LeccionCrear(LeccionCrear leccionCrear);
        public List<LeccionModel> GetLecciones(GetLeccionesFilter leccionFilter);
    }
}
