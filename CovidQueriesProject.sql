--select *
--from PortfolioProject..covid_deaths$
--order by 3,4

--select *
--from PortfolioProject..covid_vaxx$
--order by 3,4

--Select Data that we are going to use

--Select Location, date, total_cases, new_cases, total_deaths, population
--from PortfolioProject..covid_deaths$
--order by 1,2

--Looking at Total Cases vs Total Deaths
-- Shows likelihood of dying from contracting covid-19
--Select Location, date, total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
--from PortfolioProject..covid_deaths$
--where location like '%states%'
--order by 1,2

--Looking at Total Cases vs The Population  KEEP THIS!!!!
--Shows what percentage of population got covid
--Select Location, date, total_cases,population, (total_cases/population)*100 as DeathPercentage
--from PortfolioProject..covid_deaths$
--where location like '%states%'
--order by 1,2

-- Looking at Total Vaxx vs Total Deaths

--Select Location, date, total_cases,total_vaccinations,total_deaths,(total_vaccinations/total_deaths)*100 as VaccineDeaths
--from PortfolioProject..covid_vaxx$
--where location like '%states%'
--order by 1,2

--Breaking Things Down By Continent
--Showing continents with the highest death count per population

--Select continent, MAX(cast(total_deaths as int)) as TotalDeathCount
--from PortfolioProject..covid_deaths$
--Where location like '%states%'
--where continent is not null
--Group by continent
--order by TotalDeathCount desc

--Global Numbers

--select sum(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as int))/Sum(new_cases)*100 as DeathPercentage
--From PortfolioProject..covid_deaths$
--where location like '%states%'
--where continent is not null
--Group by date
--order by 1,2;

--Total Population vs Vaccinations
--Shows Percentage of Population that has recieved at least one Covid Vaccine

--Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
--, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
--From PortfolioProject..covid_deaths$ dea
--Join PortfolioProject..covid_vaxx$ vac
	--On dea.location = vac.location
	--and dea.date = vac.date
--where dea.continent is not null 
--order by 2,3


--cREATING View to store data for visulaization

Create View PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProject..covid_deaths$ dea
Join PortfolioProject..covid_vaxx$ vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 