# Use the official .NET image as the base image
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 80

# Use the SDK image to build the application
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src/test/cdtransformation.tests

# Copy the project file and restore dependencies
COPY ["test/cdtransformation.tests/cdtransformation.tests.csproj", "test/cdtransformation.tests"]
RUN dotnet restore "test/cdtransformation.tests/cdtransformation.tests.csproj"

# Copy everything else and build
COPY . .
WORKDIR "/src/test/cdtransformation.tests"
RUN dotnet build "cdtransformation.tests.csproj" -c Release -o /app/build

# Publish the application
FROM build AS publish
RUN dotnet publish "cdtransformation.tests.csproj" -c Release -o /app/publish

# Create the final runtime image
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .

# Update the entry point
ENTRYPOINT ["dotnet", "cdtransformation.tests.dll"]
