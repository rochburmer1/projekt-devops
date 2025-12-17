# Etap 1: Budowanie aplikacji (Build)
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Kopiowanie pliku projektu i pobieranie zależności
COPY ["MyDevOpsApp.csproj", "./"]
RUN dotnet restore "MyDevOpsApp.csproj"

# Kopiowanie reszty plików i budowanie
COPY . .
RUN dotnet publish "MyDevOpsApp.csproj" -c Release -o /app/publish

# Etap 2: Uruchamianie (Runtime) - lżejszy obraz
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/publish .
EXPOSE 8080
ENTRYPOINT ["dotnet", "MyDevOpsApp.dll"]