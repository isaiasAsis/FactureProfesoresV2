using FactureProfesoresV2.Core.Interfaces;
using FactureProfesoresV2.Domain;
using FactureProfesoresV2.Models;
using Microsoft.AspNetCore.Mvc;

namespace FactureProfesoresV2.Controllers
{
    [Route("Api/[controller]")]
    [ApiController]
    [ApiExplorerSettings(GroupName = "Profesores")]
    public class ProfesorController : Controller
    {
        private readonly IProfesorService _profesorService;

        public ProfesorController(IProfesorService profesorService)
        {
            _profesorService = profesorService;
        }

        [HttpPost]
        public IActionResult ProfesorCrear([FromBody] ProfesorCrearModel profesorCrearModel) 
        {

            try
            {
                if (ModelState.IsValid)
                {
                    var profesorCrear = new ProfesorCrear
                    {
                        Nombre = profesorCrearModel.Nombre,
                        Identificacion = profesorCrearModel.Identificacion,
                        Fecha_nacimiento = profesorCrearModel.Fecha_nacimiento,
                        Tipo_moneda = profesorCrearModel.Tipo_moneda,
                        Tarifa_horaria = profesorCrearModel.Tarifa_horaria,
                        Tipo_profesor = profesorCrearModel.Tipo_profesor,
                    };
                    _profesorService.ProfesorCrear(profesorCrear);
                }
            return Ok();
            }
            catch (Exception ex)
            {

                return BadRequest(ex.Message);
            }
            


        }
    }
}
