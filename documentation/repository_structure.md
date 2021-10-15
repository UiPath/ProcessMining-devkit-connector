# Repository structure
A newly developed connector is expected to have the same repository structure as this devkit connector. This document describes what the repository should contain for a released connector.

## .vscode
Workspace settings that are relevant when working in Visual Studio Code. The folder contains an `extensions.json` and a `settings.json` file. The `extensions.json` lists recommended extensions to support development on the connector. The `settings.json` contains settings related to formatting. The content of this folder could remain the same as the devkit connector.

## documentation
supporting documentation about this connector.

## extractors

Lists a set of possible extraction methods to get data into this connector. For example, a SAP connector could have these extractors: “load-from-file”, “CData-sync”, “theobald-Xtract-universal”, “theobald-erp-connect”, “custom”.

The **readme.md** contains:
- **Installation instructions** on how to set up this specific extractor. Typically that would refer to external urls that describe how to install such an extractor on your server.
- **Extraction instructions** on how to load the data needed for this connector.

Depending on the extractor, there could be additional files that would serve as input to the extractor; e.g. the set of tables to be extracted, or the SQL files for the queries that need to be executed.

The following extraction methods will typically be available:

- **load-from-file**: load data from files into the DB.
- **odbc**: load from database.
- **custom**: the data is loaded into the DB by a custom process not included in this connector.

## sample_data
A sample dataset which is meaningful and comprehensive to validate the complete set of transformations in the connector. The data should be in the form of .csv files.

Quality requirements:
- All defined activities should appear and be recognized on the output dataset.
- All mandatory fields should be filled in for the complete output dataset.
- All optional fields should at least contain data for some cases in the output dataset.
- The data should be an extraction from the source system instead of artificially created data, since we expect the data stories to be present to run the validation (by following the data confidentiality guidelines).

Size requirements:
- The data size should be less than 1MB.
- We care about the expressiveness and relevance of the data rather than the actual size of it. Therefore, minimum data size will not be declared.

Besides the small sample dataset, a large dataset will be requested to check the performance of the transformations. 

## scripts

Scripts that will be needed in the implementation process for the connectors are indicated. This can be grouped under the scripts which are used to run the connector and the scripts used to validate and test the obtained data.

## transforms

This dir contains a dbt project defining all transformations from input data to the data model of the corresponding app.  There are 5 levels of transformation applied on the extracted data which is already stored as input data.

The schema yml files are used to test the validity of the input and output data structure.

## .gitignore

Generated files from running the transformations are listed.

## README

This section describes instructions on how to use the connector.

## license.txt

License for UiPath Process Mining connectors.

## settings.json

A set of settings for this connector:

- **name**: display name of the connector.
- **app**: a reference to the repo name of the implemented app.
- **framework-version**: the version of the Connector and App framework that was used to create this connector.

The framework will use major numbers for breaking changes, minor numbers for incremental non-breaking changes. Doing this is needed to make sure we know which connector/app definition is readible by our software, and which connectors/apps we still support.

- **extractor**: current extraction method that’s used to extract data. This setting is left empty for connector templates.

Example:

```json
{
  "name": "SAP connector for Purchase-to-Pay Discovery Accelerator",
  "app": "P2P-app",
  "framework-version": "1.0",
  "extractor": "load-from-file"
}
```
