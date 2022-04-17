using FactureProfesoresV2.Domain;
using FactureProfesoresV2.Models;

namespace FactureProfesoresV2.Core.Interfaces
{
    public interface IProfesorRepository
    {
        public void ProfesoresCrear(ProfesorCrear profesorCrear);

        public List<ProfesorModel> GetProfesores();
    }
}
