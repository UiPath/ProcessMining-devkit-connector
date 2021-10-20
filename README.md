# Devkit connector
The devkit connector describes the standardized format of UiPath Process Mining connectors that are developed with [dbt](https://docs.getdbt.com/). Use this template to quick start the development of a new connector. Before developing a new connector, please read the [dbt introduction](https://docs.getdbt.com/docs/introduction/).

## Repository structure
The repository contains the following:
- `.vscode\`: workspace settings that are relevant when working in Visual Studio Code.
- `documentation\`: enablement material to develop a new connector.
- `extractors\`: the extraction methods to load input data.
- `sample_data\`: input data files to validate the transformations.
- `scripts\`: scripts to extract data, run transformations, and run tests.
- `transformations\`: the transformations of the connector (example dbt project).
- `.gitignore`: list of generated files from running the transformations.
- `README.md`: instructions on how to use the connector.
- `license.txt`: license for UiPath Process Mining connectors.
- `settings.json`: settings for the connector.

### Documentation
The documentation folder contains the following material:
- [design_specification.md](documentation/design_specification.md): generic design specification for UiPath Process Mining connectors.
- [development_best_practices.md](documentation/development_best_practices.md): guidelines and best practices on writing transformations.
- [release_process.md](documentation/release_process.md): guidelines on the git workflow and explanation about versioning.

- [validation.md](documentation/validation.md): guidelines on how to write tests and information on the validation of a connector.

Besides that, the folder contains the following enablement material:
- [connector_documentation_template.docx](documentation/connector_documentation_template.docx): template to be filled with documentation about the developed connector.
- [example.md](documentation/example.md): the devkit connector contains a simple procurement example on how to write transformations in a dbt project. This document provides information about the example dbt project.
- [repository_structure.md](documentation/repository_structure.md): a newly developed connector is expected to have the same repository structure as this devkit connector. This document describes what the repository should contain for a released connector.

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

Make sure that the installed version of dbt and dbt-sqlserver are the same. Having a newer version of dbt could result in not having all functionality available. You can check the installed versions by the command `dbt --version`. 

## Running a dbt project
### Configuration
Dbt projects contain a `profiles.yml` and `dbt_project.yml` file. Configuration of these files is necessary to run a dbt project on your database.
- Add the environment variable `DBT_PROFILES_DIR` with as value the path to the *folder* where the `profiles.yml` is located.
    - If you work on multiple dbt projects, make sure to put the `profiles.yml` at a location where all projects can access it.
    - You need only one `profiles.yml` with a configuration for each project. 
- Follow the [dbt documentation](https://docs.getdbt.com/dbt-cli/configure-your-profile) on how to configure your profile.
- Configure the variables in the `dbt_project.yml`.
    - Set on which database the transformations run.
    - Set the name of your schema.
    
### Execute
To run a dbt project you need to activate the virtual environment where dbt is installed. Follow the steps below to run a dbt project using Visual Studio Code:
- Install the recommended extensions in Visual Studio Code.
    - Go to manage extensions (Ctrl+Shift+X) and search for `@recommended`.
- Set the Python interpreter to the `python.exe` of your virtual environment.
- The policy on your machine should allow you to execute scripts. 
    - Set your policy to `RemoteSigned` by opening a terminal and running the command: `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser`
- Right click on the models folder and choose `Open in Integrated Terminal`.

The virtual environment is activated and you can run a dbt project.
