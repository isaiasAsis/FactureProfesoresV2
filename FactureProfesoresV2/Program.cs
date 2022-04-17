using FactureProfesoresV2.Core.Interfaces;
using FactureProfesoresV2.Core.Repository;
using FactureProfesoresV2.Core.Services;
using FactureProfesoresV2.DatabaseInsight;
using Insight.Database;
using Microsoft.OpenApi.Models;
using System.Security.Claims;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

var swaggerGroup = new List<string>()
{
    "Profesores",
    "Lecciones",
    "Nomina"
};
builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
    foreach (var item in swaggerGroup)
    {
        c.SwaggerDoc(item, new OpenApiInfo { Title = "Profesores", Version = "v1" });
    }
});

builder.Services.AddTransient<IProfesorService, ProfesorService>();
builder.Services.AddTransient<IProfesorRepository, ProfesorRepository>();
builder.Services.AddTransient<ILeccionService, LeccionService>();
builder.Services.AddTransient<ILeccionRepository, LeccionRepository>();
builder.Services.AddTransient<INominaService, NominaService>();
builder.Services.AddTransient<INominaRepository, NominaRepository>();
builder.Services.AddTransient<IProfesorDBConection, ProfesorDBConnection>();
var app = builder.Build();

SqlInsightDbProvider.RegisterProvider();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI(c =>
    {
        foreach (var groupName in swaggerGroup)
        {
            c.SwaggerEndpoint($"/swagger/{groupName}/swagger.json", groupName);
        }
    });
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
