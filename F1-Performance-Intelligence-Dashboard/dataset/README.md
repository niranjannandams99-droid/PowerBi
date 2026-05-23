### 14 Tables

| Table | Rows | Key Columns |
|---|---|---|
| **results.csv** ⭐ FACT | 26,000+ | resultId, raceId, driverId, constructorId, position, points |
| races.csv | 1,125+ | raceId, year, round, name, date, circuitId |
| drivers.csv | 860+ | driverId, forename, surname, nationality, dob |
| constructors.csv | 210 | constructorId, name, nationality |
| circuits.csv | 77 | circuitId, name, location, country, lat, lng |
| qualifying.csv | 9,600+ | qualifyId, raceId, driverId, q1, q2, q3 |
| lap_times.csv | 538,000+ | raceId, driverId, lap, position, time |
| pit_stops.csv | 10,000+ | raceId, driverId, stop, lap, duration |
| driver_standings.csv | 34,000+ | raceId, driverId, points, position, wins |
| constructor_standings.csv | 13,000+ | raceId, constructorId, points, position |
| constructor_results.csv | 20,000+ | raceId, constructorId, points, status |
| status.csv | 139 | statusId, status (Finished/Engine/Accident...) |
| seasons.csv | 75 | year, url |
| sprint_results.csv | 200+ | Sprint race results from 2021 onwards |
