# Devkit connector
The devkit connector describes the standardized format of UiPath Process Mining connectors that are developed with [dbt](https://docs.getdbt.com/). Use this template to quick start the development of a new connector. Before developing a new connector, please read the [dbt introduction](https://docs.getdbt.com/docs/introduction/).

## Repository structure
The repository contains the following:
- .vscode: workspace settings that are relevant when working in Visual Studio Code.
- dev_data: input data files to validate the transformations.
- documentation: enablement material to develop a new connector.
- extractors: the extraction methods to load input data.
- scripts: scripts to extract data, run transformations, and run tests.
- tranforms: the transformations of the connector (example dbt project).
- `.gitignore`: generated files from running the transformations.
- `README.md`: instructions on how to use the connector.
- `license.txt`: license for UiPath Process Mining connectors.
- `settings.json`: settings for this connector.

### Documentation
The documentation folder contains the following material:
- [repository_structure.md](documentation/repository_structure.md): a newly developed connector is expected to have the same repository structure as this devkit connector. This document describes what the repository should contain for a released connector.
- [release_process.md](documentation/release_process.md): guidelines on the git workflow and explanation about versioning.
- [example.md](documentation/example.md): the devkit connector contains a simple procurement example on how to write transformations in a dbt project. This document provides information about the example dbt project.
- [development.md](documentation/development.md): guidelines and tips&tricks on writing transformations.
- [validation.md](documentation/validation.md): guidelines on how to write tests and information on the validation of a connector.
- [connector_documentation_template.docx](documentation/connector_documentation_template.docx): template to be filled in with documentation about the developed connector.

## Installation
### Prerequisites
- To install and run a dbt project, you need Python 3.6 or higher. You can download it from [here](https://www.python.org/downloads/).
    - If you experience problems with a recent version of Python where dbt can not properly be installed, consider using a previous version of Python.
- For editing and running a dbt project, we advise Visual Studio Code. You can download it from [here](https://code.visualstudio.com/download).
- To run the transformations you need to have access to a database.
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
