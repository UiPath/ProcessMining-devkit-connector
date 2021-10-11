# Devkit template connector
Template connector containing a simple procurement example on how to write transformations in a [dbt project](https://docs.getdbt.com/).
Before using this connector, please read the [dbt introduction](https://docs.getdbt.com/docs/introduction/).
## Installation 
### Prerequisites
- To install and run a dbt project, you need Python 3.6 or higher. You can download it from [here](https://www.python.org/downloads/).
- For editing and running a dbt project, we advise Visual Studio Code. You can download it from [here](https://code.visualstudio.com/download).
- To run the transformations you need to have access to a SQL Server database.
### Create a Python virtual environment
It is advised to create a Python virtual environment in which you will install dbt. 
- Create a folder where your virtual environment will be located.
- Open the command prompt and run the following commands:
    - Install the Python package `virtualenv`: `py -m pip install virtualenv`.
    - Go to your folder where you want to create the environment: `cd [path_to_your_folder]`.
    - Create a virtual environment (named venv): `py -m virtualenv venv`.
    - Activate the virtual environment: `venv\Scripts\activate`.
### Install dbt from GitHub source
Make sure the virtual environment is still activated.
- Clone the git repository: `git clone https://github.com/dbt-labs/dbt.git`.
- Move to the cloned folder: `cd dbt`.
- Install all requirements: `pip install -r requirements.txt`.
- To check whether the installation is successful execute the command `dbt --version`.

To run transformations on SQL Server, you need to install the package `dbt-sqlserver`. This is a community plugin for dbt and not part of the core functionality.
More information about this plugin can be found [here](https://docs.getdbt.com/reference/warehouse-profiles/mssql-profile).
- Install the package in your virtual environment: `pip install dbt-sqlserver`.
- If not already installed, install the SQL Server driver `ODBC Driver 17 for SQL Server`.

Make sure that the installed version of dbt and dbt-sqlserver are the same. Having a newer version of dbt could result in not having all functionality available.
## Getting started 

### Folder structure
The dbt project in this repository contains the following:
- macros: generic functions that can be used in transformations.
    - tests: functions to test the transformations.
- models: the transformations of the example project in the advised structure of a connector.
    - `Frequently_used_transforms.sql`: example query with frequently used transforms.
    - `Multiple_databases_support.sql`: example query to illustrate multiple databases support.
- `dbt_project.yml`: by this file dbt knows the directory is a dbt project. It contains configurations for your project.
- `profiles.yml`: contains the configuration to connect to your database.

Besides the dbt project, the repository contains the following folders: 
- .vscode: workspace settings that are relevant when working in Visual Studio Code.
- development_data: contains .csv files with sample data for the example project.
### Configuration
- Add the environment variable `DBT_PROFILES_DIR` with as value the path to the *folder* where the `profiles.yml` is located.
    - If you work on multiple dbt projects, make sure to put the `profiles.yml` at a location where all projects can access it.
    - You need only one `profiles.yml` with a configuration for each project. 
- Follow the [dbt documentation](https://docs.getdbt.com/dbt-cli/configure-your-profile) on how to configure your profile.
- Set the name of your schema in the `dbt_project.yml`. By default, the schema name is *template_connector*.

### Running the project
Import the .csv files from `development_data` in your database to run the transformations on this sample data.
If you are using SQL Sever Management Studio, you can upload the files by right click on the database and choose `Tasks -> Import Flat File`.

To run the dbt project you need to activate the virtual environment where dbt is installed.
Follow the steps below to run the dbt project using Visual Studio Code:
- Install the Python extension `ms-python.python` in Visual Studio Code.
- Set the Python interpreter to the `python.exe` of your virtual environment.
- The policy on your machine should allow you to execute scripts. Set your policy to `RemoteSigned` by opening a terminal and running the command: `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser`
- Right click on the models folder and choose `Open in Integrated Terminal`.

If a Python interpreter is set and you open the project in an integrated terminal, the virtual environment is directly activated and you can run the dbt project.

## Example project
The dbt project in this repository contains the transformations for a procurement process. The input data and the process are artificial and simplified compared to a real procurement process. The structure of the *models* folder in this dbt project is the advised structure to follow when developing a connector.

### Process description
The entities that are involved in this process are *purchase orders* and *invoices*. A purchase order is created in the system after which it needs two approvals before it can be executed. Once the invoice for the order is received, the invoice is entered into the system. The invoice contains the price, the payment due date, and the payment timestamp. Until the payment is done, the payment timestamp on the invoice is empty. Once the payment is done, the payment timestamp is updated.

### Data model
The goal of every connector is to transform raw input data into a data model for process mining. The data model describes the tables and attributes of the output which can be used by a specific process mining app. This example project transforms the input data to the [TemplateOne data model](https://docs.uipath.com/process-mining/docs/input-tables-of-templateone-10) in which the purchase orders function as the cases.

The raw input data is split over six .csv files. See the comments in the transformations on how the raw input data is transformed to the data model. For an overview of frequently used transforms, see `Frequently_used_transforms.sql`.
### Tests
The example project includes tests to validate the transformations. For information about tests in dbt projects, please read the [dbt tests documentation](https://docs.getdbt.com/docs/building-a-dbt-project/tests). The implemented tests can be found in the *models/schema* folder. Some tests are offered out of the box by dbt and others are implemented in macros. Some useful test macros can be found in the *macros/tests* folder.

The tests are implemented in such a way that they can run on a SQL Server database and on Snowflake. For this purpose, the variable `database` in the `dbt_project.yml` needs to be set to the used database. By default this is set to `sqlserver`. 

### Multiple databases support
Each database has specific SQL syntax. Most transformations can run on every database, but some functions have a database specific syntax. To run the dbt project on multiple databases, macros in combination with the Jinja templating language are used. Information on macros and Jinja can be found in the [dbt documentation](https://docs.getdbt.com/docs/building-a-dbt-project/jinja-macros).

For an illustration on how a dbt project can run on multiple databases, see `Multiple_databases_support.sql`. The Jinja language allows to define which lines of code should end up in the compiled query. Based on the value of the variable `database` in the `dbt_project.yml` either the code for SQL Server or for Snowflake is used. This functionality can best be implemented in macros for readability of the transformations. Some useful functions can be found in the *macros* folder.

### Development documentation
There is quite a lot of information on how to build dbt projects on [dbt docs](https://docs.getdbt.com/docs/introduction). dbt also has an active community on Slack, to whom you can reach out when you are in need of help.

[![Slack Channel](https://img.shields.io/badge/slack-%23dbt--community-9cf?style=social&logo=data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAABzlBMVEUAAAA2xfAutn0vt342xvAut33gHlrssi7ssy/gHlvssy42xfA2xfA2xfA3xvYutXcutn0utn0utn03xvE2xfA2xvQutnkutn0utn02xfA2xfA2xfA2xvQutnoutn0utn02xvA2xfA2xfA2xfA2xfA3x/8utnwutn0vt342xfA2xfA2xfA2xfA2xfA2xfA4yf8utn0utn0utn0utn02xvQutnkutn0utn0utn02xfA2xvUutXgutn0utn0utn0utn0tzvgwy/UxyvU1xvE0x/Ewy/UuzPcq1P8ftXomtoEntoAAt5ATt4gotoAntoAktoHpFVLmGFXmGVX4B0X/ADbnGFToF1PsBVL8viX1sivysivusi3tsi3ysizzsiv3sirgHlrgHlrgHlrgHlrgHlrgF1ztuSzssi7ssi7gHlrgHlrgHlrgHlrgGVztuCzssi7gHlrgHlrgHlrgHlrgHlrgHVrv1iTssi7ssi7ssi7ssi7ssi7ssi7hH1vgHlruxyjssi7ssi7ssi7ssi7ssi7gHlrgGlvsty3ssi7ssi7ssi7hHlrgHlrgGVzstyzssi7tsy/gHlrfFl3tuizssi42xfAutn3gHlrssi7///+Vukr7AAAAlXRSTlMAAAAAAAAAAAAAAFju2C4u2O5XAaZvb6gCaO36dHmxBAIECTVCG3uwAVeosbCugw8JZ6ZYY3iuNe34U1L4g0L6Lm95e3t4UgcHU2MPG3RvLi5vdBsPY1MHB1J4e3t5by7Y+kKD+FJT+Nju7TWueGPuWKZnCbB7D4OusLGoVwEEG0I1CQQCsXl0+u1oAqhvb6YBVy4uWNqBwKcAAAABYktHRJkB1jaoAAAAB3RJTUUH5QIEEjEQu7eEbgAAAQBJREFUGNMdj9VCQkEUAM+uumuAgt2IHdid2N3dYoOFrRgY2F2ccz9X7p23mbcBAMZCdPrQMIMxnPuBCouI9HqjohFjYrlP/RljcfEJiUmIySbOA4ClmM2paekZmYhZJp7NISc3z2LJLyhUQ1FxSSnovBpl5YgVlVVoBL3m1TW1dVjfYEUDNDY1t7S2tXd0dnX39Pb1D8Dg0PDI6Nj4xOTU9Mzs3PwC2GhxaZlWVtfWFRU7OGhjc4toe0dzxQm7e/sHh0RHxyenLtfZ+QWIS+FWw9X1za3HcydBCOG+J3p4fHp+kVIG+m7E6xvR+4eifH5J7TZIfDtsP792558MBvgHJWxO8mpdwJAAAAAldEVYdGRhdGU6Y3JlYXRlADIwMjEtMDItMDRUMTg6NDk6MDQrMDA6MDDEvgYEAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIxLTAyLTA0VDE4OjQ5OjA0KzAwOjAwteO+uAAAAABJRU5ErkJggg==)](https://www.getdbt.com/community/join-the-community)
