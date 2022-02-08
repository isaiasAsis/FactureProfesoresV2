using Microsoft.Data.SqlClient;
using System.Data.Common;

namespace FactureProfesoresV2.DatabaseInsight
{
    public class ProfesorDBConnection : IProfesorDBConection
    {

        public DbConnection Current = null;
        private IConfiguration _configuration;

        public ProfesorDBConnection(IConfiguration configuration)
        {
            Current = new SqlConnection(ConnectionString());
            _configuration = configuration; 
        }

        public string ConnectionString()
        {
            return _configuration.GetConnectionString("DefaultConnection");
        }

        public DbConnection GetCurrent()
        {
            DbConnection dbConnection = new SqlConnection(ConnectionString());
            return dbConnection;
        }
    }
}
