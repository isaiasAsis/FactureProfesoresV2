using FactureProfesoresV2.Core.Interfaces;
using FactureProfesoresV2.Domain;
using FactureProfesoresV2.Models;
using Microsoft.AspNetCore.Mvc;

namespace FactureProfesoresV2.Controllers
{
    [Route("Api/[controller]")]
    [ApiController]
    [ApiExplorerSettings(GroupName = "Lecciones")]
    public class LeccionController : Controller
    {
        private readonly ILeccionService _leccionService;

        public LeccionController(ILeccionService leccionService)
        {
            _leccionService = leccionService;
        }

        [HttpPost]
        [Route("LeccionesCrear")]
        public IActionResult LeccionCrear([FromBody] LeccionCrearModel leccionCrearModel)
        {

            try
            {
                if (ModelState.IsValid)
                {
                    var leccionCrear = new LeccionCrear
                    {
                        Codigo_Curso = leccionCrearModel.Codigo_Curso,
                        Horas = leccionCrearModel.Horas,
                        Fecha_Leccion = leccionCrearModel.Fecha_Leccion,
                        Id_Profesor = leccionCrearModel.Id_Profesor,

                    };
                    _leccionService.LeccionCrear(leccionCrear);
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
