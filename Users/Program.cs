using System.Diagnostics.CodeAnalysis;

namespace Service;

[ExcludeFromCodeCoverage(Justification = "This class contains application startup code.")]
public static class Program
{

    public static void Main(string[] args)
    {
        var builder = ConfigureBuilder(args);
        var app = builder.Build();

        ConfigureApplication(app).Run();
    }

    public static WebApplicationBuilder ConfigureBuilder(string[] args)
    {
        var builder = WebApplication.CreateBuilder(args);

        builder.Services.AddHealthChecks();

        return builder;
    }

    private static WebApplication ConfigureApplication(WebApplication app)
    {
        app.MapHealthChecks("/health");


        return app;
    }

}

