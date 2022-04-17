using FactureProfesoresV2.Core.Interfaces;
using FactureProfesoresV2.Domain;
using FactureProfesoresV2.Models;
using Microsoft.AspNetCore.Mvc;

namespace FactureProfesoresV2.Controllers
{
    [Route("Api/[controller]")]
    [ApiController]
    [ApiExplorerSettings(GroupName = "Nomina")]
    public class NominaController : Controller
    {

        private readonly INominaService _nominaService;
        public string reporte;

        public NominaController(INominaService nominaService)
        {
            _nominaService = nominaService;
        }

        [HttpPost]
        [Route("GenerarNomina")]
        public IActionResult GetNomina([FromBody] GetLeccionesFilter nominaFilter)
        {

            try
            {

                var result = _nominaService.GenerarNomina(nominaFilter);

                return Ok(result);
            }
            catch (Exception ex)
            {

                return BadRequest(ex.Message);
            }



        }
    }
}
