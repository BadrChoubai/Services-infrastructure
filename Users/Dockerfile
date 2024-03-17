FROM mcr.microsoft.com/dotnet/sdk:8.0 as base
WORKDIR /app
EXPOSE 8081
EXPOSE 8080

FROM mcr.microsoft.com/dotnet/sdk:8.0 as build
WORKDIR /src
COPY ["./Service.csproj", "."]
RUN dotnet restore "./Service.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "Service.csproj" -c Release -o /app/build

FROM build as publish
RUN dotnet publish "Service.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base as final
ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=false
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Service.dll"]
