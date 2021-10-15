
# How to validate

The DBT project is just the set of queries that transforms the raw data into the transformed data. The actual data is stored in the database, for example, Snowflake. To inspect the data at each transformation step you need to inspect the data within the database.

For general validation checks, tests can be implemented in the DBT project: [Tests | dbt Docs](https://docs.getdbt.com/docs/building-a-dbt-project/tests)

Validation workflow:

- Consider you have model A and model B, which you join together to create model C. You want to validate the results of model C.

- You need to run all models to create the tables in the database.
  - Run all models by the command `dbt run`
  - Run one model by the command `dbt run -m model_A`
  - Run multiple models by the command `dbt run -m model_A model_B`
- You can only run model C the moment model A and model B are defined, because model C is dependent on the other two models.
- Inspect the data in the database, where tables for model A, B, and C are created.
- Best practice: make sure to run (with a subset of the data) at least all models you have changed to see whether there are any SQL errors before comitting/merging your changes.
- Write `limit 10` in the end of a query to only get 10 records for validation.
- Make sure to clean up unused models in the database, which may be created during testing or became redundant after refactors.

Useful query to inspect the record count related to a specific field in a table:

```json

select "Field", count("Field")
from Table
group by "Field"

```

# Automated testing & validation
The following section will describe the validation plan and which tests will be executed when the connector is tested. The eventual goal of this plan is to both show what needs to be done when a connector is validated and enable testing of the connector as early and convenient as possible. 

*At the moment this plan is being constructed.*
