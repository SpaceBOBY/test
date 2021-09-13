# Get base SDK Image
FROM mcr.microsoft.com/dotnet/aspnet:5.0-focal as base
ARG CONTAINER_PORT=80
WORKDIR /app
EXPOSE $CONTAINER_PORT

# Copy the CSPROJ files to src, restore dependencies and build 
FROM mcr.microsoft.com/dotnet/sdk:5.0-focal as build
WORKDIR /src
COPY . ./
RUN dotnet restore "Weather/Weather.csproj"
RUN dotnet build --configuration Release -o /app/build

# Publish project
FROM build as publish
RUN dotnet publish --configuration Release -o /app/publish

# Generate runtime image
FROM base AS final
ARG CONTAINER_PORT=80
ENV CONTAINER_PORT ${CONTAINER_PORT}
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT dotnet "Weather.dll"