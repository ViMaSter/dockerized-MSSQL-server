# Dockerized database

This repository contains everything required to setup a local MSSQL database + migrate the schema to either a production (without example data) or development (with example data) using [Flyway](https://flywaydb.org/).

## Architecture
### Migrations
|     folder    |         filename format        |                                               description                                              |
|:-------------:|--------------------------------|--------------------------------------------------------------------------------------------------------|
| `base`        | `V[major]__[name].sql`         | These scripts are to be executed inside **production** and **development** instances of your database. |
| `exampleData` | `V[major].[minor]__[name].sql` | These scripts are to be executed only on **development** instances.                                    |
Replace `major` and `minor` with a number [similar to semantic versioning](https://semver.org/) and `name` with any name of your choosing for the change.

For example, you can create an employees table:
```sql
/* base/V1__CreateEmployeesTable.sql */
---
CREATE TABLE `employees` (
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(255) NOT NULL ,
	`employedSince` DATETIME NOT NULL,
	PRIMARY KEY (`id`)
)
```
And fill it with example data:
```sql
/* exampleData/V1.1__AddExampleEmployees.sql */
---
INSERT INTO `employees` (`name`, `employedSince`) VALUES
('David Dague', '2020-11-07 12:52:50'),
('Maurice Zerjav', '2020-11-07 12:53:52');
```

## Setup
Running this, will create a local MSSQL with production and development data
1. Clone this repository to your local machine
2. Create a file called `.env` inside the root of your local clone of the repository with the following content and replace values wrapped in `[]`:
```
DB_Pass=[RANDOMIZED STRING OF ALPHANUMERIC CHARACTERS]  # must adhere to MSSQL password policy
WITH_EXAMPLE_DATA=true                                  # leave this set to "true" to pre-fill the DB with a small set of example data
FROM_BACKUP=false                                       # if you're trying to use a `.bak`-backup file from before flyway was used, set this to 'true' and move your backup to `/migrations/queries/initDB/init.bak`, otherwise leave it 'false'
```
3. [Create `.sql`-files inside `migrations`](#Architecture)
4. Run `docker-compose up --build --force-recreate --renew-anon-volumes --no-start`
4. Run `docker-compose staty`
5. Configure your app to use the following connection string: `data source=host.docker.internal,1433;initial catalog=localDB;persist security info=True;user id=sa;password=[RANDOMIZED STRING OF ALPHANUMERIC CHARACTERS];MultipleActiveResultSets=True;` and replace `[RANDOMIZED STRING OF ALPHANUMERIC CHARACTERS]` with the one used inside your `.env`-file.

Note: Check the [SQL Server Password Policy](https://docs.microsoft.com/en-us/sql/relational-databases/security/password-policy?view=sql-server-ver15#password-complexity) to ensure your chosen password adheres to the policy - otherwise, the sql server will not start.

### Starting from a backup (optional)
You can initialize the server using a MSSQL `.bak`-file. To do so, do the following steps between step 3 and 4 of the [setup](#Setup):
1. Create your `.bak`-file
2. Place the file inside `migrations/initDB`
3. Call it `init.bak`
4. Change the database name inside the `init.bak`-file to `localDB`
5. Change `FROM_BACKUP=false` inside the `.env`-file to `FROM_BACKUP=true`