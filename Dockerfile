FROM  mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app
RUN dotnet new blazor -o BlazorApp
WORKDIR /app/BlazorApp
COPY ./Counter.razor ./Components/Pages/Counter.razor
COPY ./Home.razor ./Components/Pages/Home.razor
RUN dotnet publish -c release -o /app/out

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app/out
COPY --from=build /app/out .
ENTRYPOINT [ "dotnet" ,"BlazorApp.dll" ]