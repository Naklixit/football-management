# Football Management

Simple Java servlet + JSP web application for managing football teams, players, matches and stats.

## Summary

- Small university / demo webapp built with Maven, Servlets and JSPs.
- Project layout follows a standard Maven webapp structure: Java sources under `src/main/java` and web resources (JSP, CSS, JS) under `src/main/webapp`.

## Notable folders

- `src/main/java` — servlet and helper classes (packages include `LoginAndRegister`, `MatchManagement`, `PlayerManagement`, `StatsManagement`, `TeamManagement`).
- `src/main/webapp` — JSP pages and static assets (`css`, `js`, `FE`, etc.).
- `target/` — Maven build output (ignored by `.gitignore`).

## Prerequisites

- Java JDK 8 or newer
- Apache Maven 3.6+
- A servlet container (Tomcat 8/9/10) or use your IDE's run configuration
- MySQL (project contains direct JDBC calls in JSPs referencing a database named `cuoi_ki`)

## Build

From the project root run:

```
mvn clean package
```

This produces a WAR under `target/` which you can deploy to Tomcat (`target/*.war`).

## Run (development)

- Import the project into IntelliJ IDEA or Eclipse as a Maven project and run on a configured Tomcat server.
- Or deploy `target/*.war` to your Tomcat `webapps/` folder and start Tomcat.

## Database

This project currently uses direct JDBC connections in JSP files (search for `jdbc:mysql://localhost:3306/cuoi_ki`). You must:

- Create a MySQL database named `cuoi_ki` (or update the connection strings in the code).
- Update usernames/passwords in the code before running (hard-coded credentials appear in JSPs). Do NOT commit real credentials — consider externalizing configuration to a properties file or environment variables.

## Security note

There are hard-coded DB credentials and direct DB calls from JSPs in this repository. For production use:

- Remove credentials from source, load them from secure config.
- Move DB logic out of JSPs into servlets / DAO classes and use prepared statements to avoid SQL injection.

## Next steps / recommendations

- Externalize DB configuration (`src/main/resources` or environment variables).
- Add instructions or SQL schema for creating the database and tables used by the app.
- Add unit/integration tests and CI build.
