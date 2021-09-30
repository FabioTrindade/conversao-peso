FROM mcr.microsoft.com/dotnet/sdk:5.0 as build
WORKDIR /app

# Copia o csproj e restaura as dependencia
COPY *.csproj ./
RUN dotnet restore

# Build da aplicacao
COPY . ./
RUN dotnet publish -c Release -o out

# Build da imagem
FROM mcr.microsoft.com/dotnet/sdk:5.0.401
WORKDIR /app
COPY --from=build /app/out .
ENTRYPOINT ["dotnet", "ConversaoPeso.dll"]