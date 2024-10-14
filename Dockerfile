# Use the official .NET image as the base image
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 80

# Use the SDK image to build the application
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY ["cdtransformation.tests/cdtransformation.tests.csproj", "MyApp/"]
RUN dotnet restore "cdtransformation.tests/cdtransformation.tests.csproj"
COPY . .
WORKDIR "/src/MyApp"
RUN dotnet build "cdtransformation.tests/cdtransformation.tests.csproj" -c Release -o /app/build

# Publish the application
FROM build AS publish
RUN dotnet publish "cdtransformation.tests/cdtransformation.tests.csproj" -c Release -o /app/publish

# Create the final runtime image
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "MyApp.dll"]
