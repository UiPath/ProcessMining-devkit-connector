# Validation

This document describes how to validate the transformations of the connector. A dbt project is the set of queries that transforms the raw data into the transformed data, but the actual data is stored in the database. To inspect the data at each transformation step you need to inspect the data within the database. Dbt offers functionality to include tests in the connector, which supports the validation process.

## Workflow
Consider you have model A and model B, which you join together to create model C. You want to validate the results of model C.

- You need to run all models to create the tables in the database.
  - Run all models by the command `dbt run`.
  - Or run multiple models by the command `dbt run -m model_A model_B`
- You can only run model C the moment model A and model B are defined, because model C is dependent on the other two models.
- Inspect the data in the database, where tables for model A, B, and C are created.
- Make sure to run at least all models you have changed while developing to see whether there are any SQL errors before comitting your changes.
- Make sure to clean up unused models in the database, which may be created during testing or became redundant after refactors.

Useful query to inspect the record count related to a specific field in a table:

```json
select "Field", count("Field")
from Table
group by "Field"
```

## Tests with dbt
Dbt offers out of the box tests such as `unique` and `not_null` checks on columns in your data. Tests that are not out of the box available can be implemented as a macro. More detailed information on tests with dbt can be found on [Tests | dbt Docs](https://docs.getdbt.com/docs/building-a-dbt-project/tests).

Each tests is a separate SQL query. For a test, the following logic is used: a test succeeds if 0 records are returned and a test fails if at least 1 record is returned. For example, `table T` has `column_A` with values of either length 3 and 4. It is expected that all lengths should be 3 for which the following test can be written:

```json
select column_A
from T
where len(column_A) <> 3
```

This query returns all records where the values have a length 4, resulting in the test to fail. If all records would have had the value 3, this query returns 0 records.

## Type of tests
Different type of tests are useful for the following levels of the transformations:
- Input tests
- Transformation tests
- Output tests

### Input tests 
On the first level, the raw data from the source is loaded and casted to the correct data type. Also filtering is applied where applicable.

- `Error` Uniqueness for the primary keys. This may be a combination of multiple columns. If the primary key is already not unique in the input table, then it may cause issues later on in the transformations. It is best to check this as early as possible.
- `Error` Not having null values for the primary keys/columns that form the primary key. Having null values may result in incorrect primary keys or in duplicate values.
- `Warning` Attribute length is as expected. Key values may start with leading zeros that may be missing if the input is corrupted. However, this is not a hard requirement, as having unexpected lengths is possible or may not lead to issues.

### Transformation tests

Multiple transformation steps take place between the raw input and the output. Joining tables incorrectly may result in unexpected record counts or duplicate IDs.

- `Error` Uniqueness for the ID columns in the entity tables.
- `Error` Not having null values for the ID columns in the entity tables.
- `Error` Not having null values for the mandatory columns in the events tables, which are the entity ID, activity, and event end.
- `Warning` Uniqueness for the combination of mandatory columns in the events tables. In general, we would not expect that the same activity for the same entity happens at the exact same moment. This could mean a duplication of event records. However, it may be expected behavior. For example, in case the event end only consists of the date and not the exact time, it may happen that the same event happens twice that day.
- `Error` Only one create event per entity instance. For example, a specific purchase order can only be created once in the event log. Having the creation event twice would indicate a duplication of events.

### Output tests

The output of the transformations should match the input of the ‘app transformations', which is the expected  schema of the corresponding app. 

- `Error` Not having null values for the mandory columns. These are, for example, the IDs.
- `Error` Uniqueness for the ID columns.
- `Error` Existence of all columns. Some columns may not contain any values, but to match the app transformations the columns should at least be present in the output.
- `Error` Data types are as expected. For example, columns that are expected to contain boolean values should be of type boolean and not be numeric or dates. If this differs from the expected types, app transformation could not be performed on these columns resulting in either errors or null values.
- `Error` Equal record counts from raw data to output where applicable. For example, the number of records in the input table should be the same as in the entity table. Otherwise, records may have been duplicated or missing along the transformation steps.


### Warnings vs Errors

- `Error` In case the data is incorrect in such a way that the data can not be visualized/analyzed later on or leads to incorrect values. For example, unexpected duplication of records.
- `Warning` In case there is a large probability for incorrect data, but that the behavior on which is checked is not a hard requirement. For example, attributes having an unexpected length.

The severity of a test is default set to error. Note that having tests that return either a warning or an error do not prevent generating the data.

## Automated testing & validation
The following section will describe the validation plan and which tests will be executed when the connector is tested. The goal of this plan is to describe what needs to be done to validate the connector and to enable the validation as early and convenient as possible. 

*At the moment this plan is being constructed.*
