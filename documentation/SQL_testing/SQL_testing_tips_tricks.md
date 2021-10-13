
# Tooling

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

# Best practices

## Project structure

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

## Model/query structure

- Always use explicit select statement and not select * for readability and maintainability of correct SQL models. Especially for unions, using the select * can throw errors. A union requires the fields to be the same and in the same order. If only one of the unioned tables changes, a select * does not work anymore.
- Prevent database specific SQL syntax where also a more generic syntax can be used. This makes it easier to re-use the connector for more databases and limits changes when another database is used.
  -If the connector needs to run on multiple databases, macros can be implemented to ‘choose’ which function to use. For an overview of the SQL functions used in the SAP-P2P DA connector and how we handled compatability with Snowflake and SQL server, see: (SAP-P2P DA Connector page on conf. this will be inserted)

## Readability/consistency

- SQL commands and functions are written in lower case, which reads ‘more easily’.
- Use the same level of indentation for select, from, where, join, etc., to understand more easily the structure of the model.
- Use consistent naming conventions for tables and fields to prevent SQL errors that tables or fields do not exist in your database. We adhere to the following guidelines:
  - Tables and fields start with a capital.
  - Use between separate words in tables and attributes an underscore.
  - All attributes have quotes. Without quotes all attribute names will end up in the database with capital letters (Snowflake).
  - Tables do not have quotes. This is in favor of readability in combination with attributes having quotes.
  - Try to define your attributes as much as possible in an alphabetical order, unless a different order makes more sense.
- All attributes are prefixed with the table they originate from. This is required if an attribute exists in multiple tables which are used in the query, but not required if there is no such ambiguity. For understandability and to easier extend models with more tables we prefix the field by default.

## Performance

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

# How to validate

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

# SQL learnings

- Consider how NULL values are handled in your database. For example, concatenation with NULL could result in a total value of NULL. That means that ‘Not_a_null_value’ + NULL results in NULL.
- Text strings are written with single quotes.
- Unions: columns should exactly match (names and order). It might be necessary to create empty attributes on parts of the union to get all the attributes (f.e. `NULL as “Attribute_X“`)
- There is a difference between `union` and `union all`: using union, duplicate records are removed, but the performance is lower than when using union all.
- When do you put something in the `where` clause and when in the `on` in a join:
  - [Difference between WHERE and ON](https://dataschool.com/how-to-teach-people-sql/difference-between-where-and-on-in-sql/)

# Differences with on-prem connectors

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
