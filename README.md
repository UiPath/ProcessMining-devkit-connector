# Devkit connector
The devkit connector describes the standardized format of UiPath Process Mining connectors that are developed with [dbt](https://docs.getdbt.com/). Use this template to quick start the development of a new connector. Before developing a new connector, please read the [dbt introduction](https://docs.getdbt.com/docs/introduction/).

A UiPath Process Mining connector is part of the Connector & App Framework. For information about the framework, see the [UiPath documentation](https://docs.uipath.com/process-mining/v0/docs/connector-and-app-framework). Here you can also find information about what is expected from a UiPath Process Mining connector and how to work with dbt.

## Repository structure
The repository contains the following:
- `.vscode\`: workspace settings that are relevant when working in Visual Studio Code.
- `documentation\`: connector documentation template.
- `extractors\`: the extraction methods to load input data.
- `sample_data\`: input data files to validate the transformations.
- `scripts\`: scripts to extract data, run transformations, and run tests.
- `transformations\`: the transformations of the connector (example dbt project).
- `.gitignore`: list of generated files from running the transformations.
- `README.md`: introduction to the connector.
- `license.txt`: license for UiPath Process Mining connectors.
- `settings.json`: settings for the connector.
- `third-party_licenses.txt`: licenses for relevant third party tools used in the connector.

## Example
The devkit connector contains a simple procurement example on how to write transformations in a dbt project. The example dbt project can be found in the `transformations` folder. The input data and the process are artificial and simplified compared to a real procurement process. The structure of the dbt project is the advised structure to have in any connector.

### Process description
The entities that are involved in this process are *purchase orders* and *invoices*. A purchase order is created in the system after which it needs two approvals before it can be executed. Once the invoice for the order is received, the invoice is entered into the system. The invoice contains the price, the payment due date, and the payment timestamp. Until the payment is done, the payment timestamp on the invoice is empty. Once the payment is done, the payment timestamp is updated.

### Data model
The goal of every connector is to transform raw input data into a data model for process mining. The data model describes the tables and fields of the output which can be used by a specific process mining app. This example project transforms the input data to the [TemplateOne data model](https://docs.uipath.com/process-mining/docs/input-tables-of-templateone-10) in which the purchase orders function as the cases.

The raw input data is split over six .csv files and can be found in the `sample_data` folder. Import the files in your database to run the transformations on this sample data. See the comments in the transformations on how the raw input data is transformed to the data model.

### Folder structure
The example dbt project contains the following:

- `macros\`: functions to use in the dbt project that are not included in the [pm-utils package](https://github.com/UiPath/ProcessMining-pm-utils).
- `models\`: the transformations of the example project in the advised structure of a connector.
    - `Frequently_used_transforms.sql`: example query with frequently used transformations.
    - `Multiple_databases_support.sql`: example query to illustrate multiple databases support.
- `seeds\`: .csv files containing a mapping for static data, such as automation estimates.
- `dbt_project.yml`: by this file dbt knows the directory is a dbt project. It contains configurations for your project.
- `packages.yml`: lists the packages used in this dbt project. The example project uses the pm-utils package and can be installed by running the command `dbt deps`.
- `profiles.yml`: contains the configuration to connect to your database.

The files `.sqlfluff` and `.sqlfluffignore` contain configuration on the SQL linter [SQLFluff](https://docs.sqlfluff.com/en/stable/), which checks the SQL on style guidelines.

### Tests
The example project includes tests to validate the transformations. The implemented tests can be found in the `models\schema` folder. Some tests are offered out of the box by dbt and others are from the pm-utils package. 

### Multiple databases support
For an illustration on how a dbt project can run on multiple databases, see `Multiple_databases_support.sql`. The Jinja language allows to define which lines of code should end up in the compiled query. Based on the value of `target.type` either the code for SQL Server or for Snowflake is used. This functionality can best be implemented in macros for readability of the transformations. Some useful functions are implemented in the pm-utils package.
