using FactureProfesoresV2.Core.Interfaces;
using FactureProfesoresV2.DatabaseInsight;
using FactureProfesoresV2.Domain;
using FactureProfesoresV2.Models;
using RestSharp;
using System.Globalization;
using System.Text.Json;

namespace FactureProfesoresV2.Core.Services
{
    public class ProfesorService : IProfesorService
    {
        private readonly IProfesorDBConection _profesorDbConnection;
        private readonly IProfesorRepository _profesorRepository;

        public ProfesorService(IProfesorDBConection profesorDBConection,
                                IProfesorRepository profesorRepository)
        {
            _profesorDbConnection = profesorDBConection;
            _profesorRepository = profesorRepository;
        }

        public void ProfesorCrear(ProfesorCrear profesorCrear)
        {

            var _exchange = exchange(profesorCrear.Tipo_moneda);

            if (_exchange.result == "error")
            {
                throw new Exception($"No existe moneda con el codigo: {profesorCrear.Tipo_moneda}");
            }

            profesorCrear.Equivalencia = _exchange.conversion_rates.COP;

            profesorCrear.Tipo_profesor =  CultureInfo.InvariantCulture.TextInfo.ToUpper(profesorCrear.Tipo_profesor);

            _profesorRepository.ProfesoresCrear(profesorCrear: profesorCrear);
        }

        public Exchange exchange(string codeMoneda)
        {
            var client = new RestClient($"https://v6.exchangerate-api.com/v6/9612b7c30b5a81d23698c9ae/latest/{codeMoneda}");
            var request = new RestRequest("", Method.Get);
            var response = client.ExecuteGetAsync(request).Result;
            var jsonResponse = JsonSerializer.Deserialize<Exchange>(response.Content);
            return jsonResponse;
        }
    }
}
