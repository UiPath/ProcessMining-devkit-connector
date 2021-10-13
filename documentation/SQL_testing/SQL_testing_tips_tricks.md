
# SQL connectors: learnings and best practices

## Tooling

- DBT to handle the complete development workflow from raw data to transformed data, including testing and documentation: [WhatisDBT?] (<https://www.getdbt.com/product/what-is-dbt/>)

  A Slack community for professionals working with DBT is available for which access can be requested here: [Getdbt]
  (<https://www.getdbt.com/community/>)

- Visual studio code as the code editor to write the transformations: <https://code.visualstudio.com/>
  - Visual studio code has all kind of plug-ins which improve your quality of life. None of the following plugins are necessary to install, but they can come in handy.
    - Better Jinja
    - vscode-dbt
    - dbt Power User
- We use Gitkraken as the GUI to manage version control over our Git. It should be possible to use Git GUI which you want.
  Note: It is possible to develop connectors for customers/projects which are not part of a Git repository. In such a case you will not need a Git tool.

## Best practices

### Project structure

In DBT, one query (select-from-where) is named a model. In a DBT project, the folder ‘models’ consists of the separate .sql files where in each file one query is defined.

- <https://docs.getdbt.com/docs/guides/best-practices>
- <https://discourse.getdbt.com/t/how-we-structure-our-dbt-projects/355>
- <https://discourse.getdbt.com/t/why-the-fishtown-sql-style-guide-uses-so-many-ctes/1091>

Some points that are discussed in the above links:
-Limit references to raw data where you rename/cast fields once
-Break complex models up into smaller pieces
-Add tests to your models
-The Fishtown’s style guide (developers of DBT)

Compiling/running a DBT project results in separate compiled .sql files for each of the created models. You can run specific sets of models instead of always your whole dbt project. See for info: <https://docs.getdbt.com/reference/node-selection/graph-operators>

### Model/query structure

- Always use explicit select statement and not select * for readability and maintainability of correct SQL models. Especially for unions, using the select * can throw errors. A union requires the fields to be the same and in the same order. If only one of the unioned tables changes, a select * does not work anymore.
- Prevent database specific SQL syntax where also a more generic syntax can be used. This makes it easier to re-use the connector for more databases and limits changes when another database is used.
  -If the connector needs to run on multiple databases, macros can be implemented to ‘choose’ which function to use. For an overview of the SQL functions used in the SAP-P2P DA connector and how we handled compatability with Snowflake and SQL server, see: (SAP-P2P DA Connector page on conf. this will be inserted)

### Readability/consistency

- SQL commands and functions are written in lower case, which reads ‘more easily’.
- Use the same level of indentation for select, from, where, join, etc., to understand more easily the structure of the model.
- Use consistent naming conventions for tables and fields to prevent SQL errors that tables or fields do not exist in your database. We adhere to the following guidelines:
  - Tables and fields start with a capital.
  - Use between separate words in tables and attributes an underscore.
  - All attributes have quotes. Without quotes all attribute names will end up in the database with capital letters (Snowflake).
  - Tables do not have quotes. This is in favor of readability in combination with attributes having quotes.
  - Try to define your attributes as much as possible in an alphabetical order, unless a different order makes more sense.
- All attributes are prefixed with the table they originate from. This is required if an attribute exists in multiple tables which are used in the query, but not required if there is no such ambiguity. For understandability and to easier extend models with more tables we prefix the field by default.

### Performance

- Avoid `select distinct` where it is also possible to build an aggregate and just take one record.
- Use `union all` instead of `union`. Using the union all records from tables are concatenated, while union removes duplicates. In general `union` can be prevented with appropriate filtering beforehand.
- If you are working on a large dataset, you can limit the data you are working with during development by using `limit` in your models. If you want you can add them in your query, where they are only executed if you change a certain setting:

`select A`
`from B`
`where C`
`{% if some condition is true %}`
`limit 100`
`{% endif %}`

See [Jinja&Macros|DBTdocs](<https://docs.getdbt.com/docs/building-a-dbt-project/jinja-macros>) for more information.

- All models are materialized as a table. This cost more diskspace to save the results, however the running time of the queries benefits greatly over the option where you materialized models as a view.

## How to validate

The DBT project is just the set of queries that transforms the raw data into the transformed data. The actual data is stored in the database, for example, Snowflake. To inspect the data at each transformation step you need to inspect the data within the database.

For general validation checks, tests can be implemented in the DBT project: [Tests|dbtDocs](<https://docs.getdbt.com/docs/building-a-dbt-project/tests>)

Validation workflow:

- Consider you have model A and model B, which you join together to create model C. You want to validate the results of model C.

- You need to run all models to create the tables in the database.
  - Run all models by the command ‘dbt run’
  - Run one model by the command ‘dbt run -m model_A’
  - Run multiple models by the command ‘dbt run -m model_A model_B’
- You can only run model C the moment model A and model B are defined, because model C is dependent on the other two models.
- Inspect the data in the database, where tables for model A, B, and C are created.
- Best practice: make sure to run (with a subset of the data) at least all models you have changed to see whether there are any SQL errors before comitting/merging your changes.
- Write `limit` 10 in the end of a query to only get 10 records for validation.
- Make sure to clean up unused models in the database, which may be created during testing or became redundant after refactors.

Useful query to inspect the record count related to a specific field in a table:

`select “Field”, count(“Field”)`
`from Table`
`group by “Field”`

## SQL learnings

- Consider how NULL values are handled in your database. For example, concatenation with NULL could result in a total value of NULL. That means that ‘Not_a_null_value’ + NULL results in NULL.
- Text strings are written with single quotes.
- Unions: columns should exactly match (names and order). It might be necessary to create empty attributes on parts of the union to get all the attributes (f.e. `NULL as “Attribute_X“`)
- There is a difference between `union` and `union all`: using union, duplicate records are removed, but the performance is lower than when using union all.
- When do you put something in the `where` clause and when in the `on` in a join:
  - [Difference between WHERE and ON](https://dataschool.com/how-to-teach-people-sql/difference-between-where-and-on-in-sql/)

## Differences with on-prem connectors

- Look ups:
  - A look up on table A to table B should be written in SQL by a join. In other words, the ‘implicit join’ structure in the on-prem software should be written in SQL by an ‘explicit join’.
  - Table B can not be dependent on table A, because it is just in the join. You need to be more explicit about the order of queries that are executed.
- Aggregates:
  - An aggregate implemented using a ‘group by’ reduces the records in the table. If you group your events table by ‘Case ID’, the resulting table has the same number of records as there are cases.
  - Using the group by aggregate, all select statements/expressions should be an aggregate function like any_value(), min(), sum(), etc.
  - If you want to keep all records from the original table, i.e., grouping the events table by ‘Case ID’ but still want to have a table containing all events, you should use the ‘partition by’ option in a select statement. This is a window function [SQL Window Functions | Advanced SQL - Mode](https://mode.com/sql-tutorial/sql-window-functions/).
- On-prem it does not matter whether you use single or double quotes, but in SQL it does. Use double quotes for fields and single quotes for strings.
- Tables that are unioned should have the exact same fields.
- At each transformation step you need to select which fields you want to define on the table. There is no concept of propagation of fields/visibilities of fields.
- Where clauses in joins are treated different. In the on-prem platform it is possible to do:
(Table_A where X) left join (Table_B where Y) on Table_A.C = Table_B.C.
This is not possible to do in SQL, where you need to either do a full select-from-where query as a nested query or use one where clause in the end.

# SQL connectors: testing

This section describes how to test the implementation and correctness of the connector. The dbt framework offers out of the box functionality to help implement tests.

## Type of tests

On the following levels of the transformations we have different type of tests implemented:

- Input tests
- Transformation tests
  - For P2P DA connector these are the intermediate transformations to create entities and events.
- Output tests

**Input tests**
On the first level, we load in the raw data from the source and cast this data to the correct data type. Also filtering is applied where applicable.

- `Error` Uniqueness for the primary keys. This may be a combination of multiple columns. If the primary key is already not unique in the input table, then it may cause issues later on in the transformations. It is best to check this as early as possible.

- `Error` Not having null values for the primary keys/columns that form the primary key. Having null values may result in incorrect primary keys or in duplicate values.

- `Warning` Attribute length is as expected. Especially with the experience in SAP, key values may start with leading zeros that may be missing if the input is corrupted. However, this is not a hard requirement, as having unexpected lengths is possible or may not lead to issues.

**Transformation tests**
Multiple transformation steps take place between the raw input and the output. Joining tables incorrectly may result in unexpected record counts or duplicate IDs.

- `Error` Uniqueness for the ID columns in the entity tables.
- `Error` Not having null values for the ID columns in the entity tables.
- `Error` Not having null values for the mandatory columns in the events tables, which are the entity ID, activity, and event end.
- `Warning` Uniqueness for the combination of mandatory columns in the events tables. In general, we would not expect that the same activity for the same entity happens at the exact same moment. This could mean a duplication of event records. However, it may be expected behavior. For example, in case the event end only consists of the date and not the exact time, it may happen that the same event happens twice that day.
- `Error` Only one create event per entity instance. For example, a specific purchase order can only be created once in the event log. Having the creation event twice would indicate a duplication of events.

**Output tests**
The output of the transformations should match the input of the ‘app transformations', which is the expected  schema of the corresponding app. 

- `Error` Not having null values for the mandory columns. These are, for example, the IDs.
- `Error` Uniqueness for the ID columns.
- `Error` Existence of all columns. Some columns may not contain any values, but to match the app transformations the columns should at least be present in the output.
- `Error` Data types are as expected. For example, columns that are expected to contain boolean values should be of type boolean and not be numeric or dates. If this differs from the expected types, app transformation could not be performed on these columns resulting in either errors or null values.
- `Error` Equal record counts from raw data to output where applicable. For example, the number of records in the EKKO table should be the same as in the purchase order entity table, purchase order create events table, and the output table. Otherwise, purchase orders might have been duplicated or missing along the transformation steps.

Snowflake does not have functionality to check the existence of all columns. For this test, we select the column to be checked, but when the column does not exist a SQL compilation error occurs. The fact that a compilation error occurs also indicates that the column is not present in the table. See the below screenshot for the difference in results given by dbt. The “Approval_status” could not be found in the output table “Purchase_orders_base”. This is indicated by the ERROR. The “Creation_date” contains null values, while it is a mandatory attribute. This test could be implemented and returns a FAIL.

## Warnings vs Errors

- `Error` in case the data is incorrect in such a way that the data can not be visualized/analyzed later on or leads to incorrect values. For example, unexpected duplication of records.
- `Warning` in case there is a large probability for incorrect data, but that the behavior on which is checked is not a hard requirement. For example, attributes having an unexpected length.

Note that having tests that return either a warning or an error do not prevent generating the data. 

## How to write tests 

Each tests is a separate SQL query. For a test, the following logic is used: a test succeeds if 0 records are returned and a test fails if at least 1 record is returned. 

Example: table T has column_A with values of either length 3 and 4. We expect that all lengths should be 3 for which we can write the following test:

`select column_A`

`from T`

`where len(column_A) <> 3`

This query returns all records where the values have a length 4, resulting in the test to fail. If all records would have had the value 3, this query returns 0 records.

## Testing using dbt

In this framework there are two types of tests which can be done. These are:

- Generic tests: tests implemented as a macro. Examples that are out of the box available in dbt are unique and not_null checks on columns in your data.

- Besproke tests: tests implemented as general queries on specific tables instead of in the form of a macro.

More detailed information on what the difference is on these tests can be found on [Tests|dbtDocs] (<https://docs.getdbt.com/docs/building-a-dbt-project/tests>)

A summary on what is described in the DBT documentation:

- Tests should return 0 records to succeed (or specified otherwise by using the fail_calc config).
- To run tests, there are several useful commands
  - `dbt test`: run all your tests
  - `dbt test --schema`: run all your schema tests
  - `dbt test --data`: run all your data tests
  - `dbt test --schema --models model_1 model_2 etc.`: run the schema tests for specific models.
  - `dbt test --data --models model_1 model_2 etc.`: run the data tests for specific models.
- The severity of a test is default set to error. It is possible to set the type to a warning.

Tip: running tests (and also models) creates a lot of compiled code in your project which will not get cleaned automatically. It is wise to run the command dbt clean every once and a while to cleanup this folder. Note that this command should be executed on the main folder of you application for it to work.

**Out of the box tests offered by DBT**
The tests ‘unique_combination_of_columns' and 'equal_rowcount’ require the package 'dbt_utils' to be installed. You can install this by running 'dbt deps' in your terminal. If you have not yet installed this package, you will see the following message in the terminal. Note that tests from this package are not all compatible with dbt-sqlserver.

