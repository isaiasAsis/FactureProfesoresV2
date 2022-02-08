using System.Data.Common;

namespace FactureProfesoresV2.DatabaseInsight
{
    public interface IProfesorDBConection
    {
        public DbConnection GetCurrent();
    }
}
