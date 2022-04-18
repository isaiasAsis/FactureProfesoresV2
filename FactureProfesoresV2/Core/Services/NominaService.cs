using FactureProfesoresV2.Core.Interfaces;
using FactureProfesoresV2.DatabaseInsight;
using FactureProfesoresV2.Domain;
using FactureProfesoresV2.Models;
using RestSharp;
using System.Text.Json;

namespace FactureProfesoresV2.Core.Services
{
    public class NominaService : INominaService
    {

        private readonly IProfesorDBConection _profesorDbConnection;
        private readonly ILeccionRepository _leccionRepository;
        private readonly IProfesorRepository _profesorRepository;
        public decimal totalNomina { get; set; }
        public decimal totalAcumuladoExtra { get; set; }
        public decimal totalAcumuladoNoExtra { get; set; }
        public string tipoMoneda { get; set; }

        public NominaService(IProfesorDBConection profesorDBConection,
                                ILeccionRepository leccionRepository,
                                IProfesorRepository profesorRepository)
        {
            _profesorDbConnection = profesorDBConection;
            _leccionRepository = leccionRepository;
            _profesorRepository = profesorRepository;
        }

        public string GenerarNomina(GetLeccionesFilter leccionesFilter)
        {

            var lecciones = _leccionRepository.GetLecciones(leccionesFilter);

            var profesores = _profesorRepository.GetProfesores();

            foreach (var itemLecciones in lecciones)
            {
                foreach (var itemProfesores in profesores)
                {
                    if (itemLecciones.Id_Profesor == itemProfesores.Identificacion && itemProfesores.Tipo_profesor == Constants.Constant.TipoProfesor.EXTRANJERO)
                    {
                        var _exchange = exchange(itemProfesores.Tipo_moneda);

                        if (_exchange.result == "error")
                        {
                            throw new Exception($"No existe moneda con el codigo: {itemProfesores.Tipo_moneda}");
                        }

                        var valorConverted = itemLecciones.Valor_leccion * _exchange.conversion_rates.COP;

                        this.totalAcumuladoExtra = this.totalAcumuladoExtra + valorConverted;
                    }

                    if (itemLecciones.Id_Profesor == itemProfesores.Identificacion && itemProfesores.Tipo_profesor != Constants.Constant.TipoProfesor.EXTRANJERO)
                    {

                        this.totalAcumuladoNoExtra = this.totalAcumuladoNoExtra + itemLecciones.Valor_leccion;
                    }

                    this.totalNomina = totalAcumuladoExtra + totalAcumuladoNoExtra;
                }


            }

            return "El valor total de la nomina para el mes seleccionado es de: " + this.totalNomina;
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
