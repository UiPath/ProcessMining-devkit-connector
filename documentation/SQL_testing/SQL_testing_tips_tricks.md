# Tooling
-DBT to handle the complete development workflow from raw data to transformed data, including testing and documentation: 
https://www.getdbt.com/product/what-is-dbt/
A Slack community for professionals working with DBT is available for which access can be requested here:
https://www.getdbt.com/community/
-Visual studio code as the code editor to write the transformations: https://code.visualstudio.com/ 
	-Visual studio code has all kind of plug-ins which improve your quality of life. None of the following plugins are necessary to install, but they can come in handy. 
		-Better Jinja
		-vscode-dbt
		-dbt Power User
-We use Gitkraken as the GUI to manage version control over our Git. It should be possible to use Git GUI which you want. 
	Note: It is possible to develop connectors for customers/projects which are not part of a Git repository. In such a case you will not need a Git tool.

# Best practices
## Project structure
In DBT, one query (select-from-where) is named a model. In a DBT project, the folder ‘models’ consists of the separate .sql files where in each file one query is defined.
-https://docs.getdbt.com/docs/guides/best-practices
-https://discourse.getdbt.com/t/how-we-structure-our-dbt-projects/355
-https://discourse.getdbt.com/t/why-the-fishtown-sql-style-guide-uses-so-many-ctes/1091

Some points that are discussed in the above links:
-Limit references to raw data where you rename/cast fields once
-Break complex models up into smaller pieces
-Add tests to your models
-The Fishtown’s style guide (developers of DBT)

Compiling/running a DBT project results in separate compiled .sql files for each of the created models. You can run specific sets of models instead of always your whole dbt project. See for info: https://docs.getdbt.com/reference/node-selection/graph-operators

## Model/query structure
-Always use explicit select statement and not select * for readability and maintainability of correct SQL models. Especially for unions, using the select * can throw errors. A union requires the fields to be the same and in the same order. If only one of the unioned tables changes, a select * does not work anymore.
-Prevent database specific SQL syntax where also a more generic syntax can be used. This makes it easier to re-use the connector for more databases and limits changes when another database is used. 
	If the connector needs to run on multiple databases, macros can be implemented to ‘choose’ which function to use. For an overview of the SQL functions used in the SAP-P2P DA connector and how we handled compatability with Snowflake and SQL server, see: (SAP-P2P DA Connector page on conf. this will be inserted)

## Readability/consistency
-SQL commands and functions are written in lower case, which reads ‘more easily’. 
-Use the same level of indentation for select, from, where, join, etc., to understand more easily the structure of the model.
-Use consistent naming conventions for tables and fields to prevent SQL errors that tables or fields do not exist in your database. We adhere to the following guidelines:
	-Tables and fields start with a capital.
	-Use between separate words in tables and attributes an underscore.
	-All attributes have quotes. Without quotes all attribute names will end up in the database with capital letters (Snowflake).
	-Tables do not have quotes. This is in favor of readability in combination with attributes having quotes.
	-Try to define your attributes as much as possible in an alphabetical order, unless a different order makes more sense.
-All attributes are prefixed with the table they originate from. This is required if an attribute exists in multiple tables which are used in the query, but not required if there is no such ambiguity. For understandability and to easier extend models with more tables we prefix the field by default. 
