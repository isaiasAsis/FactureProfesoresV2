using FactureProfesoresV2.Domain;

namespace FactureProfesoresV2.Core.Interfaces
{
    public interface INominaService
    {

        public string GenerarNomina(GetLeccionesFilter nominaFilter);
    }
}
